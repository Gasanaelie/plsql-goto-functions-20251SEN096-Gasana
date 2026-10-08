-- ============================================================
-- File   : 02_functions/B3_fn_calculate_tax.sql
-- Task   : B3 - Tax Calculator
-- Returns: monthly tax for a monthly salary, using these bands
--          (the band's rate applies to the whole salary):
--             0       - 60,000   RWF ->  0%
--             60,001  - 100,000  RWF -> 10%
--             100,001 - 200,000  RWF -> 20%
--             above   200,000    RWF -> 30%
--          NULL if the salary is missing or negative.
-- ============================================================
CREATE OR REPLACE FUNCTION fn_calculate_tax (
   p_salary IN NUMBER
) RETURN NUMBER
IS
   v_rate NUMBER;
BEGIN
   IF p_salary IS NULL OR p_salary < 0 THEN
      RETURN NULL;
   END IF;

   IF p_salary <= 60000 THEN
      v_rate := 0;
   ELSIF p_salary <= 100000 THEN
      v_rate := 0.10;
   ELSIF p_salary <= 200000 THEN
      v_rate := 0.20;
   ELSE
      v_rate := 0.30;
   END IF;

   RETURN ROUND(p_salary * v_rate, 2);
END fn_calculate_tax;
/

SHOW ERRORS;
