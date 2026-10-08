
SET SERVEROUTPUT ON;

DECLARE
   v_raise_count  NUMBER := 0;
   v_review_count NUMBER := 0;
   v_ok_count     NUMBER := 0;
   v_null_count   NUMBER := 0;
BEGIN
   DBMS_OUTPUT.PUT_LINE('=== A2: Salary Review (GOTO) ===');

   FOR emp IN (SELECT emp_id, first_name, last_name, salary
                 FROM employees
                ORDER BY emp_id) LOOP

      IF emp.salary IS NULL THEN
         GOTO no_salary;
      ELSIF emp.salary < 100000 THEN
         GOTO raise_needed;
      ELSIF emp.salary < 300000 THEN
         GOTO under_review;
      END IF;
      GOTO salary_ok;

      <<no_salary>>
      DBMS_OUTPUT.PUT_LINE(emp.emp_id || ' ' || emp.first_name || ' ' || emp.last_name
                           || ': NO SALARY RECORDED - check payroll');
      v_null_count := v_null_count + 1;
      GOTO next_employee;

      <<raise_needed>>
      DBMS_OUTPUT.PUT_LINE(emp.emp_id || ' ' || emp.first_name || ' ' || emp.last_name
                           || ': ' || emp.salary || ' RWF - RAISE NEEDED');
      v_raise_count := v_raise_count + 1;
      GOTO next_employee;

      <<under_review>>
      DBMS_OUTPUT.PUT_LINE(emp.emp_id || ' ' || emp.first_name || ' ' || emp.last_name
                           || ': ' || emp.salary || ' RWF - UNDER REVIEW');
      v_review_count := v_review_count + 1;
      GOTO next_employee;

      <<salary_ok>>
      DBMS_OUTPUT.PUT_LINE(emp.emp_id || ' ' || emp.first_name || ' ' || emp.last_name
                           || ': ' || emp.salary || ' RWF - SALARY OK');
      v_ok_count := v_ok_count + 1;

      <<next_employee>>
      NULL;
   END LOOP;

   DBMS_OUTPUT.PUT_LINE('--- Summary ---');
   DBMS_OUTPUT.PUT_LINE('Raise needed : ' || v_raise_count);
   DBMS_OUTPUT.PUT_LINE('Under review : ' || v_review_count);
   DBMS_OUTPUT.PUT_LINE('Salary OK    : ' || v_ok_count);
   DBMS_OUTPUT.PUT_LINE('No salary    : ' || v_null_count);
END;
/
