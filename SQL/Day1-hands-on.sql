-- =============================================================================
-- SQL Day 1 Hands-On Practice
-- Topic: Databases, Core Queries, DDL & DML
-- Compatible with: MySQL 8+, PostgreSQL 13+, SQLite 3
--
-- HOW TO RUN:
--   MySQL:      mysql -u root -p < Day1-hands-on.sql
--   PostgreSQL: psql -U postgres -f Day1-hands-on.sql
--   SQLite:     sqlite3 study.db < Day1-hands-on.sql
-- =============================================================================


-- =============================================================================
-- SETUP: Create a clean working schema/database
-- =============================================================================

-- For MySQL: uncomment the next two lines
-- DROP DATABASE IF EXISTS sql_study;
-- CREATE DATABASE sql_study;
-- USE sql_study;

-- For PostgreSQL: connect to your target database before running.
-- For SQLite: the file-based DB is used directly.


-- =============================================================================
-- SECTION 1: DDL — Create Tables
-- =============================================================================

-- Drop tables if they already exist (for safe re-runs)
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;

-- Create the departments table first (referenced by employees)
CREATE TABLE departments (
    department_id   INT          PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location        VARCHAR(100)
);

-- Create the employees table
CREATE TABLE employees (
    employee_id   INT            PRIMARY KEY,
    first_name    VARCHAR(50)    NOT NULL,
    last_name     VARCHAR(50)    NOT NULL,
    email         VARCHAR(100)   UNIQUE,
    salary        DECIMAL(10,2)  DEFAULT 0.00,
    hire_date     DATE,
    department_id INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);


-- =============================================================================
-- SECTION 2: DML — Insert Data
-- =============================================================================

-- Insert departments
INSERT INTO departments VALUES (10, 'Engineering',  'New York');
INSERT INTO departments VALUES (20, 'Marketing',    'Chicago');
INSERT INTO departments VALUES (30, 'HR',           'San Francisco');
INSERT INTO departments VALUES (40, 'Finance',      'Boston');

-- Insert employees
INSERT INTO employees (employee_id, first_name, last_name, email, salary, hire_date, department_id)
VALUES
    (1, 'Alice',   'Johnson', 'alice@company.com',   75000.00, '2020-03-15', 10),
    (2, 'Bob',     'Smith',   'bob@company.com',     82000.00, '2019-07-22', 20),
    (3, 'Carol',   'White',   'carol@company.com',   67000.00, '2021-01-10', 10),
    (4, 'David',   'Brown',   'david@company.com',   91000.00, '2018-11-05', 30),
    (5, 'Eve',     'Davis',   'eve@company.com',     54000.00, '2022-06-01', 20),
    (6, 'Frank',   'Wilson',  'frank@company.com',   88000.00, '2017-09-14', 10),
    (7, 'Grace',   'Moore',   'grace@company.com',   71000.00, '2021-04-20', 40),
    (8, 'Henry',   'Taylor',  NULL,                  63000.00, '2023-02-28', 30),
    (9, 'Iris',    'Anderson','iris@company.com',    95000.00, '2016-12-01', 40),
    (10,'James',   'Thomas',  'james@company.com',   78000.00, '2020-08-11', 20);


-- =============================================================================
-- SECTION 3: SELECT — Retrieving Data
-- =============================================================================

-- 3a. Select all columns from employees
SELECT * FROM employees;

-- 3b. Select specific columns
SELECT first_name, last_name, salary FROM employees;

-- 3c. Column aliases
SELECT
    first_name  AS "First Name",
    last_name   AS "Last Name",
    salary      AS "Annual Salary"
FROM employees;


-- =============================================================================
-- SECTION 4: WHERE — Filtering Rows
-- =============================================================================

-- 4a. Simple comparison: employees earning more than 80000
SELECT first_name, last_name, salary
FROM employees
WHERE salary > 80000;

-- 4b. AND: Engineering employees earning over 70000
SELECT first_name, last_name, salary, department_id
FROM employees
WHERE department_id = 10 AND salary > 70000;

-- 4c. OR: Marketing or HR employees
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id = 20 OR department_id = 30;

-- 4d. BETWEEN: salaries between 65000 and 85000
SELECT first_name, last_name, salary
FROM employees
WHERE salary BETWEEN 65000 AND 85000;

-- 4e. IN: employees in Engineering or Finance
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id IN (10, 40);

-- 4f. LIKE: employees whose first name starts with 'A' or 'E'
SELECT first_name, last_name
FROM employees
WHERE first_name LIKE 'A%' OR first_name LIKE 'E%';

-- 4g. IS NULL: employees missing an email
SELECT first_name, last_name, email
FROM employees
WHERE email IS NULL;

-- 4h. IS NOT NULL: employees with a registered email
SELECT first_name, last_name, email
FROM employees
WHERE email IS NOT NULL;

-- 4i. NOT IN: employees NOT in Marketing or HR
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id NOT IN (20, 30);


-- =============================================================================
-- SECTION 5: ORDER BY — Sorting Results
-- =============================================================================

-- 5a. Sort by salary ascending (lowest first)
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary ASC;

-- 5b. Sort by salary descending (highest first)
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC;

-- 5c. Sort by department, then by salary descending within each department
SELECT first_name, last_name, department_id, salary
FROM employees
ORDER BY department_id ASC, salary DESC;


-- =============================================================================
-- SECTION 6: LIMIT — Restrict Number of Rows
-- =============================================================================

-- Top 3 highest-paid employees
SELECT first_name, last_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

-- Pagination: rows 4–6 (skip first 3, take next 3)
SELECT first_name, last_name, salary
FROM employees
ORDER BY employee_id
LIMIT 3 OFFSET 3;


-- =============================================================================
-- SECTION 7: UPDATE — Modify Existing Data
-- =============================================================================

-- Give Carol a raise
UPDATE employees
SET salary = 72000.00
WHERE employee_id = 3;

-- Verify the change
SELECT first_name, last_name, salary FROM employees WHERE employee_id = 3;

-- Update multiple columns at once
UPDATE employees
SET salary = 97000.00, department_id = 10
WHERE employee_id = 9;

-- Verify
SELECT * FROM employees WHERE employee_id = 9;


-- =============================================================================
-- SECTION 8: DELETE — Remove Rows
-- =============================================================================

-- Delete employee with id 10
DELETE FROM employees WHERE employee_id = 10;

-- Verify deletion
SELECT * FROM employees WHERE employee_id = 10;

-- Confirm remaining employees
SELECT COUNT(*) AS remaining_employees FROM employees;


-- =============================================================================
-- SECTION 9: ALTER TABLE — Modify Structure (DDL)
-- =============================================================================

-- Add a new column (works in MySQL, PostgreSQL, SQLite 3.35+)
ALTER TABLE employees ADD COLUMN phone VARCHAR(20);

-- Rename a column (MySQL 8+ and PostgreSQL)
-- ALTER TABLE employees RENAME COLUMN phone TO phone_number;

-- Drop a column (MySQL and PostgreSQL; NOT supported in SQLite)
-- ALTER TABLE employees DROP COLUMN phone;


-- =============================================================================
-- CHALLENGE EXERCISES
-- =============================================================================
-- Try these yourself before looking at the answers below!
--
-- Challenge 1: Find all employees hired before 2020.
-- Challenge 2: Find all employees in Finance with a salary above 80000.
-- Challenge 3: Find employees whose last name ends with 'son'.
-- Challenge 4: Show the top 5 highest-paid employees' names and salaries.
-- Challenge 5: Update the salary of all Marketing employees to 90000.
-- =============================================================================


-- ANSWERS (uncomment to run):

-- Challenge 1:
-- SELECT first_name, last_name, hire_date
-- FROM employees
-- WHERE hire_date < '2020-01-01';

-- Challenge 2:
-- SELECT first_name, last_name, salary
-- FROM employees
-- WHERE department_id = 40 AND salary > 80000;

-- Challenge 3:
-- SELECT first_name, last_name
-- FROM employees
-- WHERE last_name LIKE '%son';

-- Challenge 4:
-- SELECT first_name, last_name, salary
-- FROM employees
-- ORDER BY salary DESC
-- LIMIT 5;

-- Challenge 5:
-- UPDATE employees
-- SET salary = 90000
-- WHERE department_id = 20;

-- =============================================================================
-- End of Day 1 Hands-On
-- =============================================================================
