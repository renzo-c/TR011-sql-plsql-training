-- EXERCISE 1:

CREATE OR REPLACE
FUNCTION calc_shopper_spendings
(
    shopper_id IN bb_shopper.idshopper%TYPE,
    date_shop IN VARCHAR2
)
    RETURN NUMBER
    IS
        lv_total_spendings NUMBER;
        num_rec_id NUMBER := -1;
        num_rec_date NUMBER := -1;
        NO_USER_ID_FOUND EXCEPTION;
        NO_DATE_FOUND EXCEPTION;
BEGIN
    --This select triggers the no_data_found exception if id does not exist
    SELECT COUNT(*) 
        INTO num_rec_id 
            FROM bb_basket
                WHERE idshopper = shopper_id;
                
    IF num_rec_id = 0 THEN
        RAISE NO_USER_ID_FOUND;
    END IF;
    
    --This select triggers the no_data_found exception if year does not exist            
    SELECT COUNT(*)
        INTO num_rec_date
            FROM bb_basket
                WHERE EXTRACT(YEAR from dtcreated) = date_shop;
                
    IF num_rec_date = 0 THEN
        RAISE NO_DATE_FOUND;
    END IF;
    
    SELECT SUM(subtotal) 
        INTO lv_total_spendings 
            from bb_basket 
                where idshopper = shopper_id;
                
    RETURN lv_total_spendings;
EXCEPTION
    WHEN NO_USER_ID_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No user ID found in the database');
        RETURN 0;
    WHEN NO_DATE_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No date found in the database');
        RETURN 0;
    WHEN OTHERS THEN
       raise_application_error(-20001,'Error code - '||SQLCODE||' -ERROR- '||SQLERRM);
END;
/   
DECLARE
    shopper_id bb_shopper.idshopper%TYPE := 21;
    shop_year VARCHAR2(4) := '2012';
    total_spendings NUMBER;
BEGIN
    total_spendings := calc_shopper_spendings(shopper_id, shop_year);
    IF total_spendings <> 0 THEN
        DBMS_OUTPUT.PUT_LINE('Total spending is: ' || total_spendings);
    END IF;
END;
/

-- EXERCISE 2:

CREATE OR REPLACE 
PROCEDURE UPDATE_ORDER_STATUS(
    curr_status_idstage IN bb_basketstatus.idstage%TYPE,
    date_dtstage IN bb_basketstatus.dtstage%TYPE, 
    comments_notes IN bb_basketstatus.notes%TYPE
    )
IS
BEGIN
    INSERT INTO bb_basketstatus
        (idstatus, idstage, dtstage, notes) values
        (BB_STATUS_SEQ.nextval, curr_status_idstage, date_dtstage, comments_notes);
    COMMIT;
END;
/
DECLARE
BEGIN
    UPDATE_ORDER_STATUS(1,'15-MAR-22', 'Shipment confirmed');
END;
/


-- EXERCISE 3:

CREATE OR REPLACE
FUNCTION insert_product_to_order(
    v_idproduct IN bb_basketitem.idproduct%TYPE,
    v_price IN bb_basketitem.price%TYPE,
    v_quantity IN bb_basketitem.quantity%TYPE,
    v_idbasket IN bb_basketitem.idbasket%TYPE
)
    RETURN VARCHAR2
    IS
    num_rec NUMBER;
    
    NO_PRODUCT_ID_FOUND EXCEPTION;
    NO_BASKET_FOUND EXCEPTION;
    basket_count NUMBER;
    product_count NUMBER;
    
BEGIN
    SELECT COUNT(*) 
        INTO basket_count
            FROM bb_basket 
                WHERE idbasket = v_idbasket;
    
    IF basket_count = 0 THEN
        RAISE NO_BASKET_FOUND;
    END IF;
    
    SELECT COUNT(*) 
        INTO product_count
            FROM bb_product 
                WHERE idproduct = v_idproduct;
                
    IF product_count = 0 THEN
        RAISE NO_PRODUCT_ID_FOUND;
    END IF;
    
    INSERT INTO bb_basketitem
        (idbasketitem, idproduct, price, quantity, idbasket) values
        (BB_IDBASKETITEM_SEQ.nextval, v_idproduct, v_price, v_quantity, v_idbasket);
    num_rec := SQL%rowcount;
    COMMIT;       
    DBMS_OUTPUT.PUT_LINE('Records commited: ' || num_rec);
    IF num_rec > 0 THEN
        RETURN 'Product successfully inserted';
    ELSE
        RETURN 'Failed on inserting product';
    END IF;
EXCEPTION
    WHEN NO_PRODUCT_ID_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No product ID found in the database');
        RETURN 'Failed on inserting product.';
    WHEN NO_BASKET_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No basket ID found in the database');
        RETURN 'Failed on inserting product. ';
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An error was encountered - '||SQLCODE||' -ERROR- '||SQLERRM);
        RETURN 'Failed on inserting product.';
END;
/

DECLARE
    id_product bb_basketitem.idproduct%TYPE := 2;
    unit_price bb_basketitem.price%TYPE := 99.99;
    prod_qty bb_basketitem.quantity%TYPE := 22;
    id_basket bb_basketitem.idbasket%TYPE := 6; --the basket is like the order
    ans_msg VARCHAR2(200);
BEGIN
    ans_msg := insert_product_to_order(id_product, unit_price, prod_qty, id_basket);
    DBMS_OUTPUT.PUT_LINE('Result: ' || ans_msg);
END;
/


-- EXERCISE 4:

-- Considering that it does not exist a sequence to insert values in dd_pledge
-- and dd_project tables, I am creating them to avoid errors when running 
-- codes of different students
CREATE SEQUENCE DD_PROJECT_SEQ 
    START WITH 505
    INCREMENT BY 1 
    MINVALUE 505 
    MAXVALUE 9999999999999999999999999999;

CREATE SEQUENCE DD_PLEDGE_SEQ 
    START WITH 113
    INCREMENT BY 1 
    MINVALUE 113 
    MAXVALUE 9999999999999999999999999999;

-- Creating Covid project and Adding 2 rows for the project
INSERT INTO dd_project (idproj, projname, projstartdate, projenddate, projfundgoal, projcoord)
VALUES (DD_PROJECT_SEQ.nextval, 'Covid-19 relief fund', '01-JAN-22', '01-JUN-22', 20000, 'Shawn Hasee');

INSERT INTO dd_pledge (idpledge, iddonor, pledgedate, pledgeamt, idproj, idstatus, paymonths, campaign, firstpledge)
VALUES (DD_PLEDGE_SEQ.nextval, 309, '13-MAR-22', 80, 505, 20, 0, 738, 'Y');

INSERT INTO dd_pledge (idpledge, iddonor, pledgedate, pledgeamt, idproj, idstatus, paymonths, campaign, firstpledge)
VALUES (DD_PLEDGE_SEQ.nextval, 309, '13-MAR-22', 180, 505, 20, 0, 738, 'Y');

CREATE OR REPLACE
FUNCTION get_total_pledge_amt 
    (proj_id IN NUMBER)
    RETURN NUMBER
IS
    total_pledge_amt NUMBER := 0;
BEGIN
    SELECT SUM(pledgeamt) 
        INTO total_pledge_amt
            FROM dd_pledge
                WHERE idproj = proj_id;
        
    RETURN total_pledge_amt;
END;
/
DECLARE
    CURSOR c_projects IS SELECT * FROM dd_project;
    r_projects c_projects%ROWTYPE;
    proj_name dd_project.projname%TYPE;
    total_amt NUMBER := 0;
BEGIN
    OPEN c_projects;
    DBMS_OUTPUT.PUT_LINE(
            RPAD('Project ID ', 15, ' ') || 
            RPAD('Project Name', 45, ' ') || 
            'Total Amount');
    LOOP 
        FETCH c_projects INTO r_projects;
        EXIT WHEN c_projects%NOTFOUND;

        SELECT projname 
            INTO proj_name
            FROM dd_project
                WHERE idproj = r_projects.idproj;

        total_amt := get_total_pledge_amt(r_projects.idproj);
        
        IF total_amt IS NULL THEN
            total_amt := 0;
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(
            RPAD(r_projects.idproj, 15, ' ') || 
            RPAD(proj_name, 45, ' ') || 
            RPAD(TO_CHAR(total_amt,'$9,999.99'), 15, ' '));
    END LOOP;
END;
/


-- QUESTION 5

CREATE OR REPLACE
PROCEDURE add_new_product
(
    p_name IN bb_product.productname%TYPE, 
    p_desc IN bb_product.description%TYPE, 
    p_image IN bb_product.productimage%TYPE, 
    p_price IN bb_product.price%TYPE, 
    p_sale_start IN bb_product.salestart%TYPE, 
    p_sale_end IN bb_product.saleend%TYPE, 
    p_sale_price IN bb_product.saleprice%TYPE, 
    p_active IN bb_product.active%TYPE, 
    p_feat IN bb_product.featured%TYPE, 
    p_feat_start IN bb_product.featurestart%TYPE, 
    p_feat_end IN bb_product.featureend%TYPE, 
    p_type IN bb_product.type%TYPE, 
    p_id_dep IN bb_product.iddepartment%TYPE, 
    p_stock IN bb_product.stock%TYPE, 
    p_ordered IN bb_product.ordered%TYPE, 
    p_reorder IN bb_product.reorder%TYPE 
)
IS
BEGIN
    INSERT INTO bb_product VALUES 
    (BB_PRODID_SEQ.NEXTVAL, p_name, p_desc, p_image, p_price, p_sale_start, p_sale_end, p_sale_price, 
        p_active, p_feat, p_feat_start, p_feat_end, p_type, p_id_dep, p_stock, p_ordered, p_reorder);
        
    IF SQL%ROWCOUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE( '1 row inserted');
    ELSE
        DBMS_OUTPUT.PUT_LINE( 'Something failed!, no row inserted');
    END IF;
END;
/
DECLARE
BEGIN
    add_new_product(
        'Coffee for testing', 'This is a test for assignment', 'test.jpg', 20, 
        '12-JUN-21', '12-JUN-22', 25, 1, NULL, NULL, NULL, 'C', 1, 42, 0, 35
        );
END;
