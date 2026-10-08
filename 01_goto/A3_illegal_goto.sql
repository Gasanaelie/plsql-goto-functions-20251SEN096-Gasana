-- ============================================================
-- File   : 01_goto/A3_illegal_goto.sql
-- Task   : A3 - Illegal GOTO and Fix
-- Rule   : A GOTO cannot jump INTO an IF statement, a LOOP,
--          a sub-block, or from an exception handler back into
--          the executable section.
-- Run    : Run the whole script (F5). Part 1 fails with
--          PLS-00375, Part 2 runs correctly.
-- ============================================================
SET SERVEROUTPUT ON;

-- ------------------------------------------------------------
-- PART 1: ILLEGAL GOTO (jumps INTO an IF block)
-- Expected error:
--   PLS-00375: illegal GOTO statement; this GOTO cannot branch
--   to label 'INSIDE_IF'
-- ------------------------------------------------------------
DECLARE
   v_num NUMBER := 5;
BEGIN
   DBMS_OUTPUT.PUT_LINE('Part 1: illegal GOTO');
   GOTO inside_if;                 -- ILLEGAL: target is inside the IF

   IF v_num > 0 THEN
      <<inside_if>>
      DBMS_OUTPUT.PUT_LINE(v_num || ' is positive');
   END IF;
END;
/

-- ------------------------------------------------------------
-- PART 2: FIXED VERSION
-- The label is moved OUT of the IF block, to the same level as
-- the GOTO. Jumping OUT of an IF (or forward in the same block)
-- is allowed.
-- ------------------------------------------------------------
DECLARE
   v_num NUMBER := 5;
BEGIN
   DBMS_OUTPUT.PUT_LINE('Part 2: fixed GOTO');

   IF v_num > 0 THEN
      GOTO positive;               -- LEGAL: jumping out of the IF
   END IF;
   DBMS_OUTPUT.PUT_LINE(v_num || ' is not positive');
   GOTO end_program;

   <<positive>>
   DBMS_OUTPUT.PUT_LINE(v_num || ' is positive');

   <<end_program>>
   DBMS_OUTPUT.PUT_LINE('Program finished without errors');
END;
/
