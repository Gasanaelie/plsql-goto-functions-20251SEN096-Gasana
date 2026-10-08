-- ============================================================
-- File   : 03_tests/test_validate_payroll.sql
-- Purpose: Test C1 fn_validate_payroll with valid employees,
--          invalid employees and an employee that does not exist.
-- Needs  : create_tables.sql, B1 - B4, C1
-- ============================================================
SET SERVEROUTPUT ON;

-- 1. Test from PL/SQL
DECLARE
   TYPE t_ids IS VARRAY(8) OF NUMBER;
   v_ids t_ids := t_ids(1, 2, 3, 4, 5, 6, 7, 100);
BEGIN
   DBMS_OUTPUT.PUT_LINE('=== C1: Payroll Validator tests ===');
   FOR i IN 1 .. v_ids.COUNT LOOP
      DBMS_OUTPUT.PUT_LINE('Employee ' || v_ids(i) || ' -> ' || fn_validate_payroll(v_ids(i)));
   END LOOP;
END;
/
-- Expected:
--   1, 2, 3, 4 -> VALID
--   5          -> INVALID: salary is missing or not positive
--   6          -> INVALID: department 99 does not exist
--   7          -> INVALID: hire date is missing or in the future
--   100        -> INVALID: employee 100 not found

-- 2. Test from SQL
SELECT emp_id,
       first_name || ' ' || last_name  AS employee,
       fn_validate_payroll(emp_id)     AS payroll_status
  FROM employees
 ORDER BY emp_id;
