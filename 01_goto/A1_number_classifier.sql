-- ============================================================
-- File   : 01_goto/A1_number_classifier.sql
-- Task   : A1 - Number Classifier using GOTO
-- Idea   : For each number, GOTO jumps to the label that matches
--          its class (negative / zero / positive), then GOTO
--          next_number skips the other labels.
-- ============================================================
SET SERVEROUTPUT ON;

DECLARE
   TYPE t_numbers IS VARRAY(6) OF NUMBER;
   v_numbers t_numbers := t_numbers(-7, 0, 12, 5, -1, 100);
   v_num     NUMBER;
BEGIN
   DBMS_OUTPUT.PUT_LINE('=== A1: Number Classifier (GOTO) ===');

   FOR i IN 1 .. v_numbers.COUNT LOOP
      v_num := v_numbers(i);

      IF v_num < 0 THEN
         GOTO negative;
      ELSIF v_num = 0 THEN
         GOTO zero;
      END IF;
      GOTO positive;

      <<negative>>
      DBMS_OUTPUT.PUT_LINE(v_num || ' is NEGATIVE');
      GOTO next_number;

      <<zero>>
      DBMS_OUTPUT.PUT_LINE(v_num || ' is ZERO');
      GOTO next_number;

      <<positive>>
      IF MOD(v_num, 2) = 0 THEN
         DBMS_OUTPUT.PUT_LINE(v_num || ' is POSITIVE and EVEN');
      ELSE
         DBMS_OUTPUT.PUT_LINE(v_num || ' is POSITIVE and ODD');
      END IF;

      <<next_number>>
      NULL;   -- a label must be followed by an executable statement
   END LOOP;

   DBMS_OUTPUT.PUT_LINE('=== End of classification ===');
END;
/
