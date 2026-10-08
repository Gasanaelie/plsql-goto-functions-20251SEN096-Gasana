-- ============================================================
-- File   : 02_functions/C1_fn_validate_payroll.sql
-- Task   : C1 - Payroll Validator (combined task)
-- Combines: a stored function + structured control flow +
--           the B functions + exception handling.
-- Returns : 'VALID: ...' or 'INVALID: <reason>'.
--           The first check that fails returns its reason, so the
--           remaining checks are skipped.
-- Needs   : create_tables.sql, B1, B3, B4
-- ============================================================
CREATE OR REPLACE FUNCTION fn_validate_payroll (
   p_emp_id IN employees.emp_id%TYPE
) RETURN VARCHAR2
IS
   v_salary    employees.salary%TYPE;
   v_hire_date employees.hire_date%TYPE;
   v_dept_id   employees.dept_id%TYPE;
BEGIN
   SELECT salary, hire_date, dept_id
     INTO v_salary, v_hire_date, v_dept_id
     FROM employees
    WHERE emp_id = p_emp_id;

   IF v_salary IS NULL OR v_salary <= 0 THEN                    -- Check 1: salary
      RETURN 'INVALID: salary is missing or not positive';
   ELSIF v_hire_date IS NULL OR v_hire_date > SYSDATE THEN      -- Check 2: hire date
      RETURN 'INVALID: hire date is missing or in the future';
   ELSIF fn_dept_name(v_dept_id) = 'Unknown' THEN               -- Check 3: department (B4)
      RETURN 'INVALID: department ' || v_dept_id || ' does not exist';
   END IF;

   -- All checks passed (uses B1 and B3)
   RETURN 'VALID: annual salary ' || fn_annual_salary(v_salary) || ' RWF, monthly tax ' || fn_calculate_tax(v_salary) || ' RWF';

EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 'INVALID: employee ' || p_emp_id || ' not found';
   WHEN OTHERS THEN
      RETURN 'ERROR: ' || SQLERRM;
END fn_validate_payroll;
/

SHOW ERRORS;
