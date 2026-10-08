-- ============================================================
-- File   : 02_functions/B1_fn_annual_salary.sql
-- Task   : B1 - Annual Salary
-- Returns: monthly salary * 12, or NULL if the salary is missing
--          or negative.
-- ============================================================
CREATE OR REPLACE FUNCTION fn_annual_salary (
   p_monthly_salary IN NUMBER
) RETURN NUMBER
IS
BEGIN
   IF p_monthly_salary IS NULL OR p_monthly_salary < 0 THEN
      RETURN NULL;
   END IF;

   RETURN p_monthly_salary * 12;
END fn_annual_salary;
/

SHOW ERRORS;
