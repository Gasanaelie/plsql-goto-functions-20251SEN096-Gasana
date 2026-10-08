-- ============================================================
-- File   : 01_goto/A4_rewrite_no_goto.sql
-- Task   : A4 - Rewrite Without GOTO
-- Idea   : Same logic as A1 and A2, but using structured control
--          flow (CASE and IF/ELSIF) instead of GOTO and labels.
--          The output is the same, the code is shorter and easier
--          to read.
-- Needs  : 00_setup/create_tables.sql
-- ============================================================
SET SERVEROUTPUT ON;

-- A1 rewritten with CASE
DECLARE
   TYPE t_numbers IS VARRAY(6) OF NUMBER;
   v_numbers t_numbers := t_numbers(-7, 0, 12, 5, -1, 100);
   v_num     NUMBER;
BEGIN
   DBMS_OUTPUT.PUT_LINE('=== A4 (part 1): Number Classifier without GOTO ===');

   FOR i IN 1 .. v_numbers.COUNT LOOP
      v_num := v_numbers(i);

      CASE
         WHEN v_num < 0 THEN
            DBMS_OUTPUT.PUT_LINE(v_num || ' is NEGATIVE');
         WHEN v_num = 0 THEN
            DBMS_OUTPUT.PUT_LINE(v_num || ' is ZERO');
         WHEN MOD(v_num, 2) = 0 THEN
            DBMS_OUTPUT.PUT_LINE(v_num || ' is POSITIVE and EVEN');
         ELSE
            DBMS_OUTPUT.PUT_LINE(v_num || ' is POSITIVE and ODD');
      END CASE;
   END LOOP;
END;
/

-- A2 rewritten with IF / ELSIF
DECLARE
   v_status VARCHAR2(40);
BEGIN
   DBMS_OUTPUT.PUT_LINE('=== A4 (part 2): Salary Review without GOTO ===');

   FOR emp IN (SELECT emp_id, first_name, last_name, salary
                 FROM employees
                ORDER BY emp_id) LOOP

      IF emp.salary IS NULL THEN
         v_status := 'NO SALARY RECORDED - check payroll';
      ELSIF emp.salary < 100000 THEN
         v_status := 'RAISE NEEDED';
      ELSIF emp.salary < 300000 THEN
         v_status := 'UNDER REVIEW';
      ELSE
         v_status := 'SALARY OK';
      END IF;

      DBMS_OUTPUT.PUT_LINE(emp.emp_id || ' ' || emp.first_name || ' ' || emp.last_name
                           || ': ' || NVL(TO_CHAR(emp.salary), '-') || ' RWF - ' || v_status);
   END LOOP;
END;
/
