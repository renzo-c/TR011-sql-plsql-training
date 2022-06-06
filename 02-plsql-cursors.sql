--Question 4-8

DECLARE
    CURSOR c_employee IS 
        SELECT * FROM employee
            WHERE job != 'PRESIDENT';
    r_employee c_employee%ROWTYPE;
    new_salary employee.sal%TYPE;
    raised NUMBER := 0;
    total_cost_salary_increases NUMBER := 0;
    pad NUMBER := 10;
BEGIN
    OPEN c_employee;
    LOOP
        FETCH c_employee INTO r_employee;
        EXIT WHEN c_employee%NOTFOUND;
        raised := 12 * r_employee.sal * 0.06;
        IF (raised > 2000) THEN
            raised := 2000;
        END IF;
        new_salary := r_employee.sal + ( raised / 12 );
        total_cost_salary_increases := total_cost_salary_increases +  raised;
       
        DBMS_OUTPUT.PUT_LINE('EMPNO: ' || r_employee.empno || ', Current anual salary: ' || r_employee.sal * 12 || ', Raised: ' || raised || ', Proposed new annual salary: ' || new_salary * 12);
        UPDATE employee set sal = new_salary where employee.empno = r_employee.empno;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Total Cost of salary increases: ' || total_cost_salary_increases );
    CLOSE c_employee;
END;

/
--Question 4-9
            
DECLARE
    CURSOR c_pledge_pay IS 
        select 
            pl.idpledge as pledge_ID, 
            pl.pledgeamt as pledge_amount, 
            pl.paymonths as number_monthly_payments,
            pt.paydate as payment_date, 
            pt.payamt as payment_amount
                from dd_pledge pl
                    join dd_payment pt on pt.idpledge = pl.idpledge
                        order by pl.idpledge, pt.paydate;
    r c_pledge_pay%ROWTYPE;
    curr_pledge dd_pledge.idpledge%TYPE := 0;
    str varchar2(20);
BEGIN
    OPEN c_pledge_pay;
    
    LOOP
        FETCH c_pledge_pay INTO r;
        EXIT WHEN c_pledge_pay%NOTFOUND;
        IF(curr_pledge <> r.pledge_ID) THEN
            str := 'First payment   ';
            curr_pledge := r.pledge_ID;
        ELSE
            str := '                ';
        END IF;
        DBMS_OUTPUT.PUT_LINE(str || 'pledge_ID: ' || r.pledge_ID || '    pledge_amount: ' || r.pledge_amount || '    number_monthly_payments: ' || r.number_monthly_payments || '    payment_date: ' || r.payment_date || '  payment_amount: ' || r.payment_amount);
    END LOOP;
    CLOSE c_pledge_pay;
END;

/
-- Question 4-11
                
DECLARE
    TYPE type_typecode IS TABLE OF dd_donor.typecode%TYPE;
    TYPE type_pledgeamt IS TABLE OF dd_pledge.pledgeamt%TYPE;
    
    CURSOR c_pledge_pay IS 
        select firstname || ' ' || lastname as donor_name, typecode, pledgeamt
            from dd_donor
                join dd_pledge
                    using(iddonor);

    r_pledge_pay c_pledge_pay%ROWTYPE;
    tbl_cod type_typecode;
    tbl_amt type_pledgeamt;
    total INTEGER;
    
BEGIN
    tbl_cod := type_typecode('I', 'B');
    tbl_amt := type_pledgeamt(250, 500);
    total := tbl_cod.count;
    
    FOR i IN 1 .. total LOOP 
        FOR rec_pledge_pay IN c_pledge_pay LOOP
            IF (rec_pledge_pay.typecode = tbl_cod(i) AND rec_pledge_pay.pledgeamt > tbl_amt(i)) THEN
                dbms_output.put_line('Name: ' || TRIM(rec_pledge_pay.donor_name) || ', Pledge amount: ' || rec_pledge_pay.pledgeamt);                         
            END IF;
        END LOOP;
    END LOOP; 
END;

/
-- Question 4-12

DECLARE
    cv_payments SYS_REFCURSOR;
    lv_donor_id     dd_donor.iddonor%TYPE := '308';
    lv_indicator    char := 'D';
    
    TYPE type_payment_details IS RECORD (
        iddonor dd_donor.iddonor%TYPE,
        idpledge dd_pledge.idpledge%TYPE,
        idpay dd_payment.idpay%TYPE,
        payamt dd_payment.payamt%TYPE
    );
    
    TYPE type_total_payments IS RECORD (
    idpledge dd_pledge.idpledge%TYPE,
    totalpayments NUMBER(8)
    );
    
    rec_payment_details type_payment_details;
    rec_total_payments type_total_payments;
BEGIN
    IF (lv_indicator = 'D') THEN
        OPEN cv_payments FOR 
            SELECT iddonor, idpledge, idpay, payamt from dd_payment 
                join (
                    SELECT iddonor, idpledge FROM dd_donor 
                    join dd_pledge
                        using (iddonor)
                )
                using (idpledge) 
                        where iddonor = lv_donor_id
                            order by idpledge;
        
        DBMS_OUTPUT.PUT_LINE('=================================');
        DBMS_OUTPUT.PUT_LINE('DETAILS OF PAYMENT ON ALL PLEDGES');
        DBMS_OUTPUT.PUT_LINE('=================================');
        LOOP
        FETCH cv_payments INTO rec_payment_details;
        EXIT WHEN cv_payments%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
            'Pledge ID: ' || rec_payment_details.idpledge || 
            '   Payment ID: ' || rec_payment_details.idpay || 
             '  Payment Amount: ' || rec_payment_details.payamt);
        END LOOP;
    ELSE
        OPEN cv_payments FOR 
            SELECT idpledge, SUM(payamt) as total_payment  from dd_payment 
                join (
                    SELECT iddonor, idpledge FROM dd_donor
                    join dd_pledge 
                        using (iddonor) 
                            order by iddonor, idpledge
                )
                using (idpledge) 
                    where iddonor = lv_donor_id 
                        group by idpledge;
                        
        DBMS_OUTPUT.PUT_LINE('===============================================');
        DBMS_OUTPUT.PUT_LINE('SUMMARY OF TOTAL PLEDGE PAYMENT FOR EACH PLEDGE');
        DBMS_OUTPUT.PUT_LINE('===============================================');
        LOOP
            FETCH cv_payments INTO rec_total_payments;
            EXIT WHEN cv_payments%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(
                'Pledge ID: ' || rec_total_payments.idpledge ||
                '   Total Payment: ' || rec_total_payments.totalpayments
                );
        END LOOP;
    END IF;
END;

/
--Question 4-13

DECLARE
    lv_new_id dd_donor.iddonor%TYPE := 301;
    lv_curr_id dd_donor.iddonor%TYPE := 305;
BEGIN
    UPDATE dd_donor
        SET iddonor = lv_new_id 
            where iddonor = lv_curr_id;
        
EXCEPTION
    WHEN DUP_VAL_ON_INDEX THEN
        DBMS_OUTPUT.PUT_LINE('This ID is already assigned');
        ROLLBACK;
        
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE ('Error code = ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE ('Error message = ' || SQLERRM);
        RAISE;
END;

