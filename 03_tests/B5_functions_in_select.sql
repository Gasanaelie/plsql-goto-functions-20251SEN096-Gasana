-- ============================================================
-- File   : 03_tests/B5_functions_in_select.sql
-- Task   : B5 - Functions used in SQL
-- Idea   : Stored functions that return a value can be used
--          directly in SELECT, WHERE and GROUP BY.
-- Needs  : create_tables.sql, B1 - B4
-- ============================================================

-- 1. Functions in the SELECT list
SELECT emp_id,
       first_name || ' ' || last_name     AS employee,
       salary                             AS monthly_salary,
       fn_annual_salary(salary)           AS annual_salary,
       fn_years_of_service(hire_date)     AS years_of_service,
       fn_calculate_tax(salary)           AS monthly_tax,
       fn_dept_name(dept_id)              AS department
  FROM employees
 ORDER BY emp_id;

-- 2. Function in the WHERE clause: employees with 3 or more years of service
SELECT first_name || ' ' || last_name     AS employee,
       fn_years_of_service(hire_date)     AS years_of_service
  FROM employees
 WHERE fn_years_of_service(hire_date) >= 3
 ORDER BY years_of_service DESC;

-- 3. Function in GROUP BY: total annual salary per department
SELECT fn_dept_name(dept_id)              AS department,
       COUNT(*)                           AS employees,
       SUM(fn_annual_salary(salary))      AS total_annual_salary
  FROM employees
 GROUP BY fn_dept_name(dept_id)
 ORDER BY department;
