-- ============================================================
-- File   : 02_functions/B4_fn_dept_name.sql
-- Task   : B4 - Department Name
-- Returns: the department name for a department id, or
--          'Unknown' when the id does not exist (NO_DATA_FOUND).
-- Needs  : 00_setup/create_tables.sql
-- ============================================================
CREATE OR REPLACE FUNCTION fn_dept_name (
   p_dept_id IN departments.dept_id%TYPE
) RETURN VARCHAR2
IS
   v_name departments.dept_name%TYPE;
BEGIN
   SELECT dept_name
     INTO v_name
     FROM departments
    WHERE dept_id = p_dept_id;

   RETURN v_name;
EXCEPTION
   WHEN NO_DATA_FOUND THEN
      RETURN 'Unknown';
END fn_dept_name;
/

SHOW ERRORS;
