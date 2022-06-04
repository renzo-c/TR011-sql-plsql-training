-- Question 1

select (first || ' ' || last) officer_first_and_last_name
    from officers
    join (
        select officer_id, count(crime_id) num_crimes_reported
        from crime_officers
        group by officer_id   
    ) using (officer_id)
    where num_crimes_reported > (
        select avg(count(crime_id)) 
            from crime_officers
            group by officer_id
    );

-- Question 2

select (first || ' ' || last) criminal_first_and_last_name 
    from criminals
    join (
        select criminal_id, count(*) num_crimes_committed
            from crimes
            group by criminal_id
    ) using(criminal_id)
    where num_crimes_committed < (
        select avg(count(*)) num_crimes 
            from crimes 
            group by criminal_id
    ) and criminal_id not in (
        select criminal_id from criminals where v_status = 'Y'  
    )
    order by criminal_first_and_last_name;
    
-- Question 3

select * from appeals
    where (to_date(hearing_date, 'DD-MM-YYYY') - 
            to_date(filing_date, 'DD-MM-YYYY')) < (
        select avg(
            to_date(hearing_date, 'DD-MM-YYYY') - 
            to_date(filing_date, 'DD-MM-YYYY'))
        from appeals
        );
        
-- Question 4

select (first || ' ' || last) officer_first_and_last_name 
    from prob_officers
    where prob_id in (
        select prob_id from sentences
            join prob_officers using (prob_id)
            group by prob_id
            having count(criminal_id) >= (
                -- average number of criminals assigned to each probation officer
                -- https://stackoverflow.com/questions/10702546/sql-query-with-avg-and-group-by
                select avg(count(*)) avg_num_crim_by_prob_off
                from sentences
                group by prob_id
            )
    );

-- Question 5

select crime_id 
    from appeals
    group by crime_id
    having count(appeal_id) in (
        select max(count(appeal_id)) 
            from appeals
            group by crime_id
    );

-- Question 6

select * from crime_charges
    where nvl(fine_amount, 0) < (
        select avg(nvl(fine_amount, 0))
            from crime_charges
        ) and (
        nvl(amount_paid, 0) > (
            select avg(nvl(amount_paid, 0))
                from crime_charges
        )
    );

-- Question 7

select distinct (first || ' ' || last) criminal_first_and_last_name from criminals
    join crimes using(criminal_id)
    join crime_charges using (crime_id)
    where crime_code = (
        select crime_code from crime_charges
            where crime_id = '10091'
    )
    order by criminal_first_and_last_name;
