-- ============================================================
-- File   : 03_tests/test_functions.sql
-- Purpose: Test B1 - B4 and C1 with normal values and edge cases
--          (NULL, negative, future date, unknown department,
--          employee not found).
-- Needs  : create_tables.sql, B1 - B4, C1
-- ============================================================
SET SERVEROUTPUT ON;

BEGIN
   DBMS_OUTPUT.PUT_LINE('=== B1: fn_annual_salary ===');
   DBMS_OUTPUT.PUT_LINE('250000 -> ' || fn_annual_salary(250000));          -- 3000000
   DBMS_OUTPUT.PUT_LINE('NULL   -> ' || NVL(TO_CHAR(fn_annual_salary(NULL)), 'NULL'));
   DBMS_OUTPUT.PUT_LINE('-500   -> ' || NVL(TO_CHAR(fn_annual_salary(-500)), 'NULL'));

   DBMS_OUTPUT.PUT_LINE('=== B2: fn_years_of_service ===');
   DBMS_OUTPUT.PUT_LINE('2015-09-20 -> ' || fn_years_of_service(DATE '2015-09-20'));
   DBMS_OUTPUT.PUT_LINE('2030-01-01 -> ' || fn_years_of_service(DATE '2030-01-01'));  -- 0
   DBMS_OUTPUT.PUT_LINE('NULL       -> ' || NVL(TO_CHAR(fn_years_of_service(NULL)), 'NULL'));

   DBMS_OUTPUT.PUT_LINE('=== B3: fn_calculate_tax ===');
   DBMS_OUTPUT.PUT_LINE('50000  -> ' || fn_calculate_tax(50000));    -- 0
   DBMS_OUTPUT.PUT_LINE('80000  -> ' || fn_calculate_tax(80000));    -- 8000
   DBMS_OUTPUT.PUT_LINE('150000 -> ' || fn_calculate_tax(150000));   -- 30000
   DBMS_OUTPUT.PUT_LINE('450000 -> ' || fn_calculate_tax(450000));   -- 135000
   DBMS_OUTPUT.PUT_LINE('NULL   -> ' || NVL(TO_CHAR(fn_calculate_tax(NULL)), 'NULL'));

   DBMS_OUTPUT.PUT_LINE('=== B4: fn_dept_name ===');
   DBMS_OUTPUT.PUT_LINE('10  -> ' || fn_dept_name(10));    -- Finance
   DBMS_OUTPUT.PUT_LINE('30  -> ' || fn_dept_name(30));    -- IT
   DBMS_OUTPUT.PUT_LINE('999 -> ' || fn_dept_name(999));   -- Unknown

   DBMS_OUTPUT.PUT_LINE('=== C1: fn_validate_payroll ===');
   DBMS_OUTPUT.PUT_LINE('Employee 1   -> ' || fn_validate_payroll(1));    -- VALID
   DBMS_OUTPUT.PUT_LINE('Employee 5   -> ' || fn_validate_payroll(5));    -- missing salary
   DBMS_OUTPUT.PUT_LINE('Employee 6   -> ' || fn_validate_payroll(6));    -- unknown department
   DBMS_OUTPUT.PUT_LINE('Employee 7   -> ' || fn_validate_payroll(7));    -- future hire date
   DBMS_OUTPUT.PUT_LINE('Employee 100 -> ' || fn_validate_payroll(100));  -- not found
END;
/
