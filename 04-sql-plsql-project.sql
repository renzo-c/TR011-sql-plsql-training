----CREATE TABLES
CREATE TABLE RN_Employees (
    Employees_id number(10) NOT NULL, 
    Password varchar2(20) NOT NULL, 
    Username varchar2(20) NOT NULL, 
    First_Name varchar2(20) NOT NULL, 
    Last_Name varchar2(20) NOT NULL, 
    Status varchar2(8) NOT NULL, CONSTRAINT chk_Status CHECK (Status IN ('active', 'disabled')),
    PRIMARY KEY (Employees_id));

CREATE TABLE RN_Companies (
    Companies_id number(10) NOT NULL, 
    Name varchar2(100) NOT NULL, 
    Phone varchar2(20), 
    PRIMARY KEY (Companies_id));
    
CREATE TABLE RN_Customers (
    Customers_id number(10) NOT NULL, 
    First_Name varchar2(20) NOT NULL, 
    Last_Name varchar2(20), 
    Email varchar2(100) NOT NULL, 
    Status varchar2(8) NOT NULL, 
    Companies_id number(10) NOT NULL, 
    PRIMARY KEY (Customers_id),
    CONSTRAINT customer_companies_id_fk FOREIGN KEY (Companies_id)
           REFERENCES RN_COMPANIES (Companies_id));

CREATE TABLE RN_TICKETS_STATUS (
    Tickets_status_id number(10), 
    Status varchar2(255) NOT NULL, 
    PRIMARY KEY (Tickets_status_id));
    
CREATE TABLE RN_Tickets (
    Tickets_id number(10) NOT NULL, 
    Status number(10) NOT NULL, 
    Title varchar2(255) NOT NULL, 
    Description varchar2(350) NOT NULL, 
    Customers_id number(10) NOT NULL, 
    Employees_id number(10) NOT NULL, 
    Created_at date NOT NULL, 
    Closed_at date, 
    PRIMARY KEY (Tickets_id),
    CONSTRAINT tickets_ticket_status_id_fk FOREIGN KEY (Status)
            REFERENCES RN_TICKETS_STATUS (Tickets_status_id),
    CONSTRAINT tickets_customers_id_fk FOREIGN KEY (Customers_id)
            REFERENCES RN_CUSTOMERS (Customers_id),
    CONSTRAINT tickets_employees_id_fk FOREIGN KEY (Employees_id)
            REFERENCES RN_EMPLOYEES (Employees_id));

CREATE TABLE RN_Messages (
    Messages_id number(10) NOT NULL, 
    "From" number(10) NOT NULL, 
    Sender_role varchar2(20) NOT NULL, CONSTRAINT chk_Sender_role CHECK (Sender_role IN ('employee', 'customer')),
    "To" number(10) NOT NULL, 
    Created_at date NOT NULL, 
    Message varchar2(255) NOT NULL,
    Tickets_id number(10) NOT NULL, 
    PRIMARY KEY (Messages_id),
    CONSTRAINT messages_tickets_id_fk FOREIGN KEY (Tickets_id)
            REFERENCES RN_TICKETS (Tickets_id));

CREATE TABLE RN_LOGS (
    Logs_id number(10) NOT NULL, 
    Operation varchar2(255), 
    Table_mod varchar2(255), 
    Description varchar2(255), 
    Created_at date, 
    Tickets_id number(10) NOT NULL, 
    PRIMARY KEY (Logs_id),
    CONSTRAINT logs_tickets_id_fk FOREIGN KEY (Tickets_id)
            REFERENCES RN_TICKETS (Tickets_id));


-- CREATE SEQUENCES
CREATE SEQUENCE rn_companies_seq START WITH 100;
CREATE SEQUENCE rn_employees_seq START WITH 100;
CREATE SEQUENCE rn_customers_seq START WITH 100;
CREATE SEQUENCE rn_tickets_seq START WITH 100;
CREATE SEQUENCE rn_messages_seq START WITH 100;
CREATE SEQUENCE rn_logs_seq START WITH 100;

-- CREATE INDEXES
CREATE INDEX "customers_last_name_i" ON rn_customers(last_name);
CREATE INDEX "tickets_title_i" ON rn_tickets(title);

-- INSERT COMPANIES
INSERT INTO RN_Companies(Companies_id, Name, Phone) VALUES (rn_companies_seq.NEXTVAL, LOWER('Wonka Industries'), '+151489525698');
INSERT INTO RN_Companies(Companies_id, Name, Phone) VALUES (rn_companies_seq.NEXTVAL, LOWER('Acme Corp'), '+1545255657813');
INSERT INTO RN_Companies(Companies_id, Name, Phone) VALUES (rn_companies_seq.NEXTVAL, LOWER('Stark Industries'), '+1549858698180');
INSERT INTO RN_Companies(Companies_id, Name, Phone) VALUES (rn_companies_seq.NEXTVAL, LOWER('Ollivander Wand Shop'), '613-555-0158');
INSERT INTO RN_Companies(Companies_id, Name, Phone) VALUES (rn_companies_seq.NEXTVAL, LOWER('Gekko and Co'), '613-555-0115');
INSERT INTO RN_Companies(Companies_id, Name, Phone) VALUES (rn_companies_seq.NEXTVAL, LOWER('Wayne Enterprises'), '613-555-0178');
INSERT INTO RN_Companies(Companies_id, Name, Phone) VALUES (rn_companies_seq.NEXTVAL, LOWER('Cyberdyne Systems'), '613-555-0190');
INSERT INTO RN_Companies(Companies_id, Name, Phone) VALUES (rn_companies_seq.NEXTVAL, LOWER('Cheers'), '613-555-0182');
INSERT INTO RN_Companies(Companies_id, Name, Phone) VALUES (rn_companies_seq.NEXTVAL, LOWER('Hane-Skiles'), '613-555-0168');
INSERT INTO RN_Companies(Companies_id, Name, Phone) VALUES (rn_companies_seq.NEXTVAL, LOWER('Yundt PLC'), '613-555-0102');

-- INSERT EMPLOYEES
INSERT INTO RN_Employees(Employees_id, Password, Username, First_Name, Last_Name, Status) VALUES (rn_employees_seq.NEXTVAL , 'X3j5RRC', 'omartin', 'Opal', 'Martin', 'active');
INSERT INTO RN_Employees(Employees_id, Password, Username, First_Name, Last_Name, Status) VALUES (rn_employees_seq.NEXTVAL , 'cGQp]9p', 'mbell', 'Martha', 'Bell', 'active');
INSERT INTO RN_Employees(Employees_id, Password, Username, First_Name, Last_Name, Status) VALUES (rn_employees_seq.NEXTVAL , 'uB5q8aq', 'prich', 'Paula', 'Rich', 'active');
INSERT INTO RN_Employees(Employees_id, Password, Username, First_Name, Last_Name, Status) VALUES (rn_employees_seq.NEXTVAL , 'F6cu7e3', 'swalker', 'Sylvia', 'Walker', 'active');
INSERT INTO RN_Employees(Employees_id, Password, Username, First_Name, Last_Name, Status) VALUES (rn_employees_seq.NEXTVAL , 'gDXjP3E', 'ahecker', 'Addie', 'Hecker', 'active');
INSERT INTO RN_Employees(Employees_id, Password, Username, First_Name, Last_Name, Status) VALUES (rn_employees_seq.NEXTVAL , 'wDCx5Kf', 'amartin', 'Arthur', 'Martin', 'active');
INSERT INTO RN_Employees(Employees_id, Password, Username, First_Name, Last_Name, Status) VALUES (rn_employees_seq.NEXTVAL , 'Mm8DRUM', 'dlindner', 'Deborah', 'Lindner', 'active');
INSERT INTO RN_Employees(Employees_id, Password, Username, First_Name, Last_Name, Status) VALUES (rn_employees_seq.NEXTVAL , 'test123', 'econdori', 'Edward', 'Condori', 'active');
INSERT INTO RN_Employees(Employees_id, Password, Username, First_Name, Last_Name, Status) VALUES (rn_employees_seq.NEXTVAL , 'test456', 'jnunn', 'Joshua', 'Nunn', 'active');
INSERT INTO RN_Employees(Employees_id, Password, Username, First_Name, Last_Name, Status) VALUES (rn_employees_seq.NEXTVAL , 'test789', 'ctaylor', 'Christina ', 'Taylor', 'active');


-- INSERT CUSTOMERS
INSERT INTO RN_Customers(Customers_id, First_Name, Last_Name, Email, Status, Companies_id) VALUES (rn_customers_seq.NEXTVAL, 'Tracy', 'Hunt', 'thunt@raid.com', 'active', 	100);
INSERT INTO RN_Customers(Customers_id, First_Name, Last_Name, Email, Status, Companies_id) VALUES (rn_customers_seq.NEXTVAL, 'Charlene', 'Hengel', 'chengel@wonka.com', 'active', 101);
INSERT INTO RN_Customers(Customers_id, First_Name, Last_Name, Email, Status, Companies_id) VALUES (rn_customers_seq.NEXTVAL, 'William', 'Levin', 'lwilliam@acme.com', 'active', 102);
INSERT INTO RN_Customers(Customers_id, First_Name, Last_Name, Email, Status, Companies_id) VALUES (rn_customers_seq.NEXTVAL, 'George', 'Wurst', 'gwurst@starkindustries.com', 'active', 103);
INSERT INTO RN_Customers(Customers_id, First_Name, Last_Name, Email, Status, Companies_id) VALUES (rn_customers_seq.NEXTVAL, 'Charles', 'Harp', 'charp@ollivander.com', 'active', 104);
INSERT INTO RN_Customers(Customers_id, First_Name, Last_Name, Email, Status, Companies_id) VALUES (rn_customers_seq.NEXTVAL, 'Leroy', 'Kramer', 'lkramer@gekko.com', 'active', 105);
INSERT INTO RN_Customers(Customers_id, First_Name, Last_Name, Email, Status, Companies_id) VALUES (rn_customers_seq.NEXTVAL, 'Lisa', 'Moore', 'lmoore@wayne.com', 'active', 106);
INSERT INTO RN_Customers(Customers_id, First_Name, Last_Name, Email, Status, Companies_id) VALUES (rn_customers_seq.NEXTVAL, 'Peter', 'Quigley', 'pquigley@cyberdyne.com', 'active', 107);
INSERT INTO RN_Customers(Customers_id, First_Name, Last_Name, Email, Status, Companies_id) VALUES (rn_customers_seq.NEXTVAL, 'Jean', 'Yamasaki', 'jyamasaki@cheers.com', 'active', 108);
INSERT INTO RN_Customers(Customers_id, First_Name, Last_Name, Email, Status, Companies_id) VALUES (rn_customers_seq.NEXTVAL, 'Steven', 'Cady', 'scady@haneskiles.com', 'active', 109);
INSERT INTO RN_Customers(Customers_id, First_Name, Last_Name, Email, Status, Companies_id) VALUES (rn_customers_seq.NEXTVAL, 'Dorothea', 'Landwehr', 'dlandwehr@yundtplc.com', 'active', 109);


-- INSERT TICKET STATUS
INSERT INTO RN_TICKETS_STATUS(Tickets_status_id, Status) VALUES (1, 'ASSIGNED');
INSERT INTO RN_TICKETS_STATUS(Tickets_status_id, Status) VALUES (2, 'RESEARCH');
INSERT INTO RN_TICKETS_STATUS(Tickets_status_id, Status) VALUES (3, 'STANDBY');
INSERT INTO RN_TICKETS_STATUS(Tickets_status_id, Status) VALUES (4, 'SOLVED');
INSERT INTO RN_TICKETS_STATUS(Tickets_status_id, Status) VALUES (5, 'CLOSED');

-------------------------
------- TRIGGERS --------
-------------------------

-- TRIGGER TO WRITE LOG WHEN A TICKET IS CREATED
CREATE OR REPLACE TRIGGER ADD_TICKET_EVENT_TO_LOG
    AFTER INSERT OR UPDATE ON rn_tickets
    FOR EACH ROW
DECLARE
    var_operation VARCHAR(255);
    var_description VARCHAR(350);
    var_employee RN_EMPLOYEES%ROWTYPE;
BEGIN
    var_operation := CASE
        WHEN UPDATING THEN 'UPDATE'
        WHEN INSERTING THEN 'ASSIGNMENT'
    END;
    
    SELECT * INTO var_employee from rn_employees where employees_id = :NEW.employees_id;
    IF var_operation = 'ASSIGNMENT' THEN
        var_description := 'Ticket ASSIGNED to ' || var_employee.Username || ', user_id ' || :NEW.employees_id;
    ELSE
        var_description := 'Ticket PASSED FROM ' || :OLD.employees_id || ' TO ' || :NEW.employees_id;
    END IF;
    
    INSERT INTO RN_LOGS(Logs_id, Operation, Table_mod, Description, Created_at, Tickets_id) 
        VALUES (RN_LOGS_SEQ.nextval, var_operation, 'RN_TICKETS', var_description, :NEW.Created_at, :NEW.Tickets_id);
END;
/

-- TRIGGER TO WRITE LOG WHEN A MESSAGE IS SENT BETWEEN EMPLOYEE AND CUSTOMER
CREATE OR REPLACE TRIGGER LOG_MESSAGE
    AFTER INSERT ON RN_MESSAGES
    FOR EACH ROW
DECLARE
    v_receiver_role VARCHAR2(100);
BEGIN
    IF :NEW.Sender_role = 'employee' THEN
        v_receiver_role := 'customer';
    ELSE
        v_receiver_role := 'employee';
    END IF;
    INSERT INTO RN_Logs(Logs_id, Operation, Table_mod, Description, Created_at, Tickets_id) VALUES 
        (RN_LOGS_SEQ.NEXTVAL, 'MESSAGE_SENT', 'RN_MESSAGES', 
            :NEW.Sender_role || ' (' || :NEW."From" || ') sent message to ' || v_receiver_role || ' (' || :NEW."To" || ') ', 
                :NEW.Created_at, :NEW.Tickets_id);
    DBMS_OUTPUT.PUT_LINE('Message sent was added to logs');
END;
/   
-------------------------
-- EMPLOYEE MANAGEMENT --
-------------------------
CREATE OR REPLACE PACKAGE EMPLOYEE_MGMT
    AS
    FUNCTION GET_EMPLOYEE_LESS_TICKETS
    RETURN NUMBER;
END;
            
/
CREATE OR REPLACE PACKAGE BODY EMPLOYEE_MGMT
    AS
    -- FUNCTION THAT SELECTS EMPLOYEE WITH LESS NUMBER OF TICKETS TO ASSING A NEW ONE
    FUNCTION GET_EMPLOYEE_LESS_TICKETS
    RETURN NUMBER AS
    var_id rn_employees.employees_id%TYPE;
    var_num_tickets NUMBER(2);
    
    NO_EMPLOYEE_IN_DB EXCEPTION;
    PRAGMA exception_init(NO_EMPLOYEE_IN_DB, -20998);
    
    CURSOR cur_selected_row is SELECT * FROM 
        (SELECT RN_EMPLOYEES.employees_id, COUNT(rn_tickets.tickets_id) AS num_tickets FROM rn_tickets 
            RIGHT JOIN RN_EMPLOYEES ON RN_EMPLOYEES.EMPLOYEES_ID = RN_TICKETS.EMPLOYEES_ID
                GROUP BY RN_EMPLOYEES.employees_id ORDER BY num_tickets ASC) WHERE ROWNUM = 1;
            
    BEGIN
        OPEN cur_selected_row;
        FETCH cur_selected_row INTO var_id, var_num_tickets;       
        CLOSE cur_selected_row;
        IF var_id IS NULL THEN
            SELECT employees_id INTO var_id FROM rn_employees where ROWNUM = 1;
        END IF;
        IF var_id IS NULL THEN
            RAISE_APPLICATION_ERROR(-20998, 'NO EMPLOYEE RECORD WAS FOUND IN THE DB.');
        END IF;
        RETURN var_id;
    EXCEPTION
        WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE ('Error code = ' || SQLCODE);
        DBMS_OUTPUT.PUT_LINE ('Error message = ' || SQLERRM);
        RAISE;
    END;
END;
/

-------------------------
-- CUSTOMER MANAGEMENT --
-------------------------

-- PACKAGE THAT HANDLES CUSTOMER MANAGEMENT
CREATE OR REPLACE PACKAGE CUSTOMER_MGMT
AS
    var_ticket_status_01 RN_TICKETS.STATUS%TYPE := 1;
    
    PROCEDURE PRC_UPDATE_CUSTOMER_COMPANY
    (var_company_name IN RN_Companies.name%TYPE,
     var_customer_id IN RN_Customers.Customers_id%TYPE);
     
    PROCEDURE PRC_CUSTOMER_CREATES_TICKET(
    var_customer_id IN rn_customers.customers_id%TYPE,
    var_title IN rn_tickets.title%TYPE,
    var_message IN rn_tickets.description%TYPE
    );
END;
/

CREATE OR REPLACE PACKAGE BODY CUSTOMER_MGMT
AS
    -- PROCEDURE TO UPDATE COMPANY LINKED TO A CUSTOMER
    PROCEDURE PRC_UPDATE_CUSTOMER_COMPANY
        (var_company_name IN RN_Companies.name%TYPE,
         var_customer_id IN RN_Customers.Customers_id%TYPE)
        AS
            company_exists NUMBER(2);
            comp_id NUMBER(10);
            NO_COMPANY_NAME EXCEPTION;
            PRAGMA exception_init(NO_COMPANY_NAME, -20999);
    BEGIN
        SELECT COUNT(*) INTO company_exists FROM rn_companies WHERE lower(name)= lower(var_company_name);
        IF company_exists <> 0 THEN
            SELECT Companies_id INTO comp_id FROM rn_companies WHERE lower(name) = lower(var_company_name);
            UPDATE RN_Customers SET Companies_id = comp_id WHERE Customers_id = var_customer_id;
            DBMS_OUTPUT.PUT_LINE ('CUSTOMER COMPANY UPDATED TO ' || LOWER(var_company_name));
        ELSE
            RAISE_APPLICATION_ERROR(-20999, 'NO COMPANY WITH SUCH A NAME WAS FOUND.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE ('Error code = ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE ('Error message = ' || SQLERRM);
            RAISE;
    END PRC_UPDATE_CUSTOMER_COMPANY;
    
    --PROCEDURE THAT SIMULATES THE CREATION OF A TICKET IN THE IT REPORT PLATFORM
    PROCEDURE PRC_CUSTOMER_CREATES_TICKET(
        var_customer_id IN rn_customers.customers_id%TYPE,
        var_title IN rn_tickets.title%TYPE,
        var_message IN rn_tickets.description%TYPE
        )
        AS
        var_selected_employee_id rn_employees.employees_id%TYPE;
        EMPTY_MESSAGE EXCEPTION;
        PRAGMA exception_init(EMPTY_MESSAGE, -20998);
    BEGIN
        IF TRIM(var_message) IS NULL THEN
            RAISE_APPLICATION_ERROR(-20998, 'ALL TICKETS MUST HAVE A DESCRIPTION.');
        END IF;
        
        var_selected_employee_id := EMPLOYEE_MGMT.GET_EMPLOYEE_LESS_TICKETS();
        
        INSERT INTO RN_Tickets(Tickets_id, Status, Title, Description, Customers_id, Employees_id, Created_at, Closed_at) 
            VALUES (RN_TICKETS_SEQ.nextval, var_ticket_status_01, var_title, var_message, var_customer_id, var_selected_employee_id,
                (SELECT TO_CHAR(SYSDATE, 'MM-DD-YYYY HH24:MI:SS') FROM dual),
                    NULL);
        DBMS_OUTPUT.PUT_LINE('TICKET ID '|| RN_TICKETS_SEQ.CURRVAL || ' CREATED BY CUSTOMER ID ' || var_customer_id || ' ASSIGNED TO EMPLOYEE_ID ' || var_selected_employee_id ||'. LOG ADDED TO RN_LOGS TABLE');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE ('Error code = ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE ('Error message = ' || SQLERRM);
            RAISE;
    END PRC_CUSTOMER_CREATES_TICKET;
END;
/

-- PACKAGE THAT HANDLES TICKET MANAGEMENT
CREATE OR REPLACE PACKAGE TICKET_MGMT
AS
    FUNCTION GET_DIFF_DATES_IN_HOURS
        (var_date_1 DATE,
         var_date_2 DATE)
         RETURN NUMBER;
         
    FUNCTION GET_OPENED_TICKETS
        RETURN NUMBER;
        
    PROCEDURE CREATE_MESSAGE
        (v_person_id_1 IN RN_EMPLOYEES.EMPLOYEES_ID%TYPE,
         v_person_id_2 IN RN_EMPLOYEES.EMPLOYEES_ID%TYPE,
         v_sender_role IN VARCHAR2,
         v_ticket_id IN RN_TICKETS.TICKETS_ID%TYPE,
         v_message IN RN_MESSAGES.MESSAGE%TYPE);
         
    FUNCTION GET_TICKETS_BY_TITLE 
        (var_title VARCHAR2)
        RETURN SYS_REFCURSOR;
END;
/

CREATE OR REPLACE PACKAGE BODY TICKET_MGMT
AS
    var_num_opened_tickets NUMBER;
    -- FUNCTION TO RETURN HOW MANY HOURS A TICKET WAS/IS OPENED/OPEN
    FUNCTION GET_DIFF_DATES_IN_HOURS
        (var_date_1 DATE,
         var_date_2 DATE)
         RETURN NUMBER AS
         hours_passed NUMBER(2,2);
         final_date DATE;
        BEGIN
            IF var_date_2 IS NULL THEN
                final_date := SYSDATE;
            ELSE
                final_date := var_date_2;
            END IF;
             SELECT 24 * (SYSDATE - to_date(var_date_1, 'MM-DD-YYYY hh24:mi:ss')) INTO hours_passed FROM dual;
             RETURN hours_passed;
        EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE ('Error code = ' || SQLCODE);
            DBMS_OUTPUT.PUT_LINE ('Error message = ' || SQLERRM);
            RAISE;
    END;
    
    FUNCTION GET_OPENED_TICKETS
        RETURN NUMBER AS
        BEGIN
            SELECT COUNT(*) INTO var_num_opened_tickets FROM rn_tickets WHERE Status <> 5;
        RETURN var_num_opened_tickets;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE ('Error code = ' || SQLCODE);
                DBMS_OUTPUT.PUT_LINE ('Error message = ' || SQLERRM);
                RAISE;
    END;
    
    PROCEDURE CREATE_MESSAGE
        (v_person_id_1 IN RN_EMPLOYEES.EMPLOYEES_ID%TYPE,
         v_person_id_2 IN RN_EMPLOYEES.EMPLOYEES_ID%TYPE,
         v_sender_role IN VARCHAR2,
         v_ticket_id IN RN_TICKETS.TICKETS_ID%TYPE,
         v_message IN RN_MESSAGES.MESSAGE%TYPE)
         IS
         v_employee_id RN_EMPLOYEES.EMPLOYEES_ID%TYPE;
         v_customer_id RN_CUSTOMERS.CUSTOMERS_ID%TYPE;
         v_receiver_role VARCHAR2(20);
    BEGIN
        IF LOWER(v_sender_role) = 'employee' THEN
            v_receiver_role := 'customer';
        ELSE
            v_receiver_role := 'employee';
        END IF;
        INSERT INTO RN_Messages(Messages_id, "From", Sender_role, "To", Created_at, Message, Tickets_id) VALUES 
            (RN_MESSAGES_SEQ.NEXTVAL, v_person_id_1, v_sender_role, v_person_id_2, SYSDATE, v_message, v_ticket_id);
        DBMS_OUTPUT.PUT_LINE(v_sender_role || ' with ID ' || v_person_id_1 || ' has successfully sent a message to ' || v_receiver_role || ' with ID ' || v_person_id_2);
    END;
    
    FUNCTION GET_TICKETS_BY_TITLE 
        (var_title VARCHAR2)
       RETURN SYS_REFCURSOR
    IS
       ref_cur   SYS_REFCURSOR;
    BEGIN
       OPEN ref_cur FOR
          SELECT *
            FROM RN_TICKETS
           WHERE LOWER(TITLE) like LOWER('%'||var_title||'%');
    
       RETURN ref_cur;
    END GET_TICKETS_BY_TITLE;
END;
/

------------------------------------------------
----- TESTS - PACKAGE EMPLOYEE_MGMT ------
------------------------------------------------

-- TEST OF FUNCTION THAT RETURNS THE EMPLOYEE ID WITH LESS TICKETS
DECLARE
    res rn_employees.employees_id%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('1 - TEST OF FUNCTION THAT RETURNS THE EMPLOYEE ID WITH LESS TICKETS');
    res := EMPLOYEE_MGMT.GET_EMPLOYEE_LESS_TICKETS();
    DBMS_OUTPUT.PUT_LINE('Employee ID with less tickets: ' || res);
    DBMS_OUTPUT.PUT_LINE(chr(10));
END;
/

------------------------------------------------
----- TESTS - PACKAGE CUSTOMER_MGMT ------
------------------------------------------------
-- TEST OF PROCEDURE THAT UPDATES THE COMPANY COLUMN(FK) IN CUSTOMER ROW
BEGIN
    DBMS_OUTPUT.PUT_LINE ('2 - TEST OF PROCEDURE THAT UPDATES THE COMPANY COLUMN(FK) IN CUSTOMER ROW');
    CUSTOMER_MGMT.PRC_UPDATE_CUSTOMER_COMPANY('acme corp', 109);
    DBMS_OUTPUT.PUT_LINE(chr(10));
END;
/

-- TEST OF PROCEDURE THAT CREATES AND ASSIGNS TICKETS
BEGIN
    DBMS_OUTPUT.PUT_LINE ('3 - TEST OF PROCEDURE THAT CREATES AND ASSIGNS TICKETS');
    CUSTOMER_MGMT.PRC_CUSTOMER_CREATES_TICKET(100, 'Router not working', 'Pcs cannot connect to internet');
    CUSTOMER_MGMT.PRC_CUSTOMER_CREATES_TICKET(101, 'Monitor with blue screen', 'New monitor shows blue screen');
    CUSTOMER_MGMT.PRC_CUSTOMER_CREATES_TICKET(102, 'Keyboard not working', 'Wireless keyboard never gets to syncronize');
    CUSTOMER_MGMT.PRC_CUSTOMER_CREATES_TICKET(103, 'Internet connection to slow', 'Packet degradation in LAN network');
    CUSTOMER_MGMT.PRC_CUSTOMER_CREATES_TICKET(104, 'SoftPhone not working well', 'Call Redirection button does not work');
    CUSTOMER_MGMT.PRC_CUSTOMER_CREATES_TICKET(105, 'Printer requires maintenance', 'Monthly maintenance has not yet been done this month');
    CUSTOMER_MGMT.PRC_CUSTOMER_CREATES_TICKET(106, 'Storage sending alerts', 'Storage warns that there is almost full of its capacity');
    CUSTOMER_MGMT.PRC_CUSTOMER_CREATES_TICKET(107, 'Website is not loading', 'Some sections of the website break');
    CUSTOMER_MGMT.PRC_CUSTOMER_CREATES_TICKET(108, 'New ip required for intern', 'A new computer has been installed and we require a LAN port');
    CUSTOMER_MGMT.PRC_CUSTOMER_CREATES_TICKET(109, 'Upgrade to windows 11', 'Our laptops are requiring to upgrade the SO');
    DBMS_OUTPUT.PUT_LINE(chr(10));
END;
/

------------------------------------------------
----- TESTS - PACKAGE TICKETS_MGMT ------
------------------------------------------------

-- TEST OF FUNCTION THAT RETURNS HOW MANY HOURS HAVE PASSED SINCE
-- A TICKET WAS OPENED UNTIL NOW OR UNTIL IT WAS CLOSED
DECLARE
    CURSOR c_tickets IS SELECT * FROM RN_TICKETS;
    r_tickets c_tickets%ROWTYPE;
    hours NUMBER(2,2);
BEGIN
    DBMS_OUTPUT.PUT_LINE ('4 - TEST OF FUNCTION THAT RETURNS HOW MANY HOURS HAVE PASSED SINCE A TICKET WAS OPENED');
    OPEN c_tickets;
    DBMS_OUTPUT.PUT_LINE(RPAD('TICKET ID', 15) || RPAD('HOURS OPENED', 15));
    DBMS_OUTPUT.PUT_LINE('===========================');
    LOOP 
        FETCH c_tickets INTO r_tickets;
        EXIT WHEN c_tickets%NOTFOUND;
        hours := TICKET_MGMT.GET_DIFF_DATES_IN_HOURS(r_tickets.Created_at, r_tickets.Closed_at);
    
        DBMS_OUTPUT.PUT_LINE(RPAD(r_tickets.tickets_id, 15) || RPAD(hours, 15));
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(chr(10));
END;
/

-- TEST OF FUNCTION THAT RETURNS THE NUMBER OF TICKETS YET OPENED
BEGIN
    DBMS_OUTPUT.PUT_LINE('5 - TEST OF FUNCTION THAT RETURNS THE NUMBER OF TICKETS YET OPENED');
    DBMS_OUTPUT.PUT_LINE(TICKET_MGMT.get_opened_tickets());
    DBMS_OUTPUT.PUT_LINE(chr(10));
END;
/

-- TEST OF PROCEDURE THAT CREATES A NEW MESSAGE RECORD WHEN EMPLOYEES OR CUSTOMERS SEND A MESSAGE
BEGIN
    DBMS_OUTPUT.PUT_LINE('6 - TEST OF PROCEDURE THAT CREATES A NEW MESSAGE RECORD WHEN EMPLOYEES OR CUSTOMERS SEND A MESSAGE');
    TICKET_MGMT.CREATE_MESSAGE(100, 100, 'employee', 100, 'Hi, Tracy, This is Opal, Can you give me more insights about the router problem?');
    TICKET_MGMT.CREATE_MESSAGE(101, 101, 'employee', 100, 'Hi, Charlene, It seems like the blue screen is a problem with your OS. I will answer back ASAP');
    TICKET_MGMT.CREATE_MESSAGE(102, 102, 'employee', 100, 'Hi, William, This is Paula, Can you bring your keyboard to the IT department?');
    TICKET_MGMT.CREATE_MESSAGE(103, 103, 'employee', 100, 'Hi, George, This is Sylvia, Can I visit your office this afternoon to test the internet connection?');
    TICKET_MGMT.CREATE_MESSAGE(104, 104, 'employee', 100, 'Hi, Charles, This is Addie, I am quite sure that your softphone is missing a configuration');
    TICKET_MGMT.CREATE_MESSAGE(100, 100, 'customer', 100, 'Hi, Opal, This is  Tracy. The issue started at 9:00am yesterday and since then I cannot connect to the servers');
    TICKET_MGMT.CREATE_MESSAGE(106, 106, 'customer', 100, 'Hi, Deborah, This is  Lisa. Can you please confirm that you read my ticket about the storage?');
    TICKET_MGMT.CREATE_MESSAGE(107, 107, 'customer', 100, 'Hi, Edward, This is  Peter. Let me know when you are available to give you more details about the website issue');
    TICKET_MGMT.CREATE_MESSAGE(108, 108, 'customer', 100, 'Hi, Joshua, This is  Jean, Please confirm to use when you could come to install the new network point ');
    TICKET_MGMT.CREATE_MESSAGE(109, 109, 'customer', 100, 'Hi, Christina, This is Steven. Please come to upgrade my system ASAP, it is kind of urgent');
    DBMS_OUTPUT.PUT_LINE(chr(10));
END;
/

-- TEST OF FUNCTION THAT RETURNS TICKETS SEARCHED BY TITLE
DECLARE
    c_matches SYS_REFCURSOR;
    v_tickets_id RN_TICKETS.TICKETS_ID%TYPE;
    v_status RN_TICKETS.STATUS%TYPE;
    v_title RN_TICKETS.TITLE%TYPE;
    v_description RN_TICKETS.DESCRIPTION%TYPE;
    v_customers_id RN_TICKETS.CUSTOMERS_ID%TYPE;
    v_employees_id RN_TICKETS.EMPLOYEES_ID%TYPE;
    v_created_at RN_TICKETS.CREATED_AT%TYPE;
    v_closed_at RN_TICKETS.CLOSED_AT%TYPE;
BEGIN
    DBMS_OUTPUT.PUT_LINE('7 - TEST OF FUNCTION THAT RETURNS TICKETS SEARCHED BY TITLE');
    c_matches := TICKET_MGMT.GET_TICKETS_BY_TITLE('ROUTER');
    LOOP
      FETCH c_matches INTO
        v_tickets_id,
        v_status,
        v_title,
        v_description,
        v_customers_id,
        v_employees_id,
        v_created_at,
        v_closed_at;
      EXIT
   WHEN c_matches%NOTFOUND;
      dbms_output.put_line('TICKET_ID: '||v_tickets_id || '   STATUS: ' || v_status || '    TITLE: ' ||  v_title );
   END LOOP;
   CLOSE c_matches;
   DBMS_OUTPUT.PUT_LINE(chr(10));
END;
