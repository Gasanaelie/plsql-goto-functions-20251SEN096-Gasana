-- ============================================================
-- File   : 00_setup/create_tables.sql
-- Purpose: Create and populate the tables used in Assignment III
-- Author : Gasana (20251SEN096)
-- Course : INSY 8311 - Database Development with PL/SQL
-- ============================================================
SET SERVEROUTPUT ON;

-- Drop old tables if they already exist (ignore "table does not exist")
BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE employees PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

BEGIN
   EXECUTE IMMEDIATE 'DROP TABLE departments PURGE';
EXCEPTION
   WHEN OTHERS THEN
      IF SQLCODE != -942 THEN
         RAISE;
      END IF;
END;
/

-- Departments table
CREATE TABLE departments (
   dept_id    NUMBER        PRIMARY KEY,
   dept_name  VARCHAR2(50)  NOT NULL,
   location   VARCHAR2(50)
);

-- Employees table
-- (no foreign key on dept_id on purpose, so we can test an unknown department)
CREATE TABLE employees (
   emp_id      NUMBER        PRIMARY KEY,
   first_name  VARCHAR2(50)  NOT NULL,
   last_name   VARCHAR2(50)  NOT NULL,
   salary      NUMBER(10,2),          -- monthly salary in RWF
   hire_date   DATE,
   dept_id     NUMBER
);

-- Sample departments
INSERT INTO departments VALUES (10, 'Finance',         'Kigali');
INSERT INTO departments VALUES (20, 'Human Resources', 'Kigali');
INSERT INTO departments VALUES (30, 'IT',              'Huye');

-- Sample employees (monthly salary in RWF)
INSERT INTO employees VALUES (1, 'Alice',   'Uwase',     450000, DATE '2018-03-15', 10);
INSERT INTO employees VALUES (2, 'Jean',    'Mugabo',    250000, DATE '2021-07-01', 20);
INSERT INTO employees VALUES (3, 'Grace',   'Ineza',      80000, DATE '2024-01-10', 30);
INSERT INTO employees VALUES (4, 'Eric',    'Habimana',  150000, DATE '2015-09-20', 10);
-- Test cases for validation:
INSERT INTO employees VALUES (5, 'Diane',   'Mukamana',    NULL, DATE '2023-05-05', 20); -- missing salary
INSERT INTO employees VALUES (6, 'Patrick', 'Niyonzima', 120000, DATE '2020-11-11', 99); -- unknown department
INSERT INTO employees VALUES (7, 'Kevin',   'Mugisha',   200000, DATE '2030-01-01', 30); -- hire date in the future

COMMIT;

-- Check the data
SELECT * FROM departments ORDER BY dept_id;
SELECT * FROM employees   ORDER BY emp_id;
