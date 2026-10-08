-- ============================================================
-- File   : 02_functions/B2_fn_years_of_service.sql
-- Task   : B2 - Years of Service
-- Returns: full years between hire date and today.
--          NULL if the hire date is missing, 0 if it is in the
--          future.
-- ============================================================
CREATE OR REPLACE FUNCTION fn_years_of_service (
   p_hire_date IN DATE
) RETURN NUMBER
IS
BEGIN
   IF p_hire_date IS NULL THEN
      RETURN NULL;
   ELSIF p_hire_date > SYSDATE THEN
      RETURN 0;
   END IF;

   RETURN TRUNC(MONTHS_BETWEEN(SYSDATE, p_hire_date) / 12);
END fn_years_of_service;
/

SHOW ERRORS;
