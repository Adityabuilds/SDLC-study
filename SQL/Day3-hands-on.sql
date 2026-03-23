-- =============================================================================
-- SQL Day 3 Hands-On Practice
-- Topic: Indexes, Transactions, Views, Window Functions,
--        Stored Procedures & Normalization
-- Compatible with: MySQL 8+, PostgreSQL 13+, SQLite 3
--
-- NOTE: Stored Procedures use MySQL syntax.
--       Window Functions require MySQL 8+, PostgreSQL, or SQLite 3.25+.
--       Some ALTER/DROP INDEX syntax differs between databases.
--
-- HOW TO RUN:
--   MySQL:      mysql -u root -p < Day3-hands-on.sql
--   PostgreSQL: psql -U postgres -f Day3-hands-on.sql
--   SQLite:     sqlite3 study.db < Day3-hands-on.sql
-- =============================================================================


-- =============================================================================
-- SETUP: Rebuild all tables for standalone use
-- =============================================================================

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS accounts;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS student_courses_unnormalized;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;
DROP TABLE IF EXISTS enrollments;

CREATE TABLE departments (
    department_id   INT          PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location        VARCHAR(100)
);

CREATE TABLE employees (
    employee_id   INT            PRIMARY KEY,
    first_name    VARCHAR(50)    NOT NULL,
    last_name     VARCHAR(50)    NOT NULL,
    email         VARCHAR(100),
    salary        DECIMAL(10,2)  DEFAULT 0.00,
    hire_date     DATE,
    department_id INT,
    manager_id    INT
);

CREATE TABLE accounts (
    account_id  INT             PRIMARY KEY,
    owner_name  VARCHAR(100)    NOT NULL,
    balance     DECIMAL(12,2)   NOT NULL DEFAULT 0.00
);

INSERT INTO departments VALUES
    (10, 'Engineering',  'New York'),
    (20, 'Marketing',    'Chicago'),
    (30, 'HR',           'San Francisco'),
    (40, 'Finance',      'Boston');

INSERT INTO employees VALUES
    (1,  'Alice',  'Johnson', 'alice@company.com',   75000.00, '2020-03-15', 10, NULL),
    (2,  'Bob',    'Smith',   'bob@company.com',     82000.00, '2019-07-22', 20, NULL),
    (3,  'Carol',  'White',   'carol@company.com',   67000.00, '2021-01-10', 10, 1),
    (4,  'David',  'Brown',   'david@company.com',   91000.00, '2018-11-05', 30, NULL),
    (5,  'Eve',    'Davis',   'eve@company.com',     54000.00, '2022-06-01', 20, 2),
    (6,  'Frank',  'Wilson',  'frank@company.com',   88000.00, '2017-09-14', 10, 1),
    (7,  'Grace',  'Moore',   'grace@company.com',   71000.00, '2021-04-20', 40, NULL),
    (8,  'Henry',  'Taylor',  NULL,                  63000.00, '2023-02-28', 30, 4),
    (9,  'Iris',   'Anderson','iris@company.com',    95000.00, '2016-12-01', 40, NULL),
    (10, 'James',  'Thomas',  'james@company.com',   78000.00, '2020-08-11', 20, 2);

INSERT INTO accounts VALUES
    (1, 'Alice Johnson', 5000.00),
    (2, 'Bob Smith',     3000.00);


-- =============================================================================
-- SECTION 1: Indexes
-- =============================================================================

-- 1a. Create an index on salary (speeds up WHERE salary > X queries)
CREATE INDEX idx_salary ON employees(salary);

-- 1b. Create a composite index (used for queries filtering by department AND salary)
CREATE INDEX idx_dept_salary ON employees(department_id, salary);

-- 1c. Check if indexes help (run EXPLAIN on a query):
-- EXPLAIN SELECT * FROM employees WHERE salary > 80000;
-- EXPLAIN SELECT * FROM employees WHERE department_id = 10 AND salary > 70000;

-- 1d. Query that benefits from the composite index
SELECT first_name, last_name, salary
FROM employees
WHERE department_id = 10 AND salary > 70000;

-- 1e. Drop indexes (MySQL syntax)
-- DROP INDEX idx_salary ON employees;
-- DROP INDEX idx_dept_salary ON employees;

-- PostgreSQL syntax:
-- DROP INDEX IF EXISTS idx_salary;
-- DROP INDEX IF EXISTS idx_dept_salary;


-- =============================================================================
-- SECTION 2: Transactions — COMMIT & ROLLBACK
-- =============================================================================

-- 2a. Successful transaction: Transfer $500 from Account 1 to Account 2

-- View initial balances
SELECT * FROM accounts;

BEGIN;

UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;

COMMIT;

-- View final balances (should be 4500 and 3500)
SELECT * FROM accounts;


-- 2b. Failed transaction — ROLLBACK example
-- Simulate a bad update and roll it back

BEGIN;

-- This update is intentional and correct
UPDATE accounts SET balance = balance + 1000 WHERE account_id = 1;

-- Oops — we would accidentally zero out account 2
-- In real code, an error or logic check triggers ROLLBACK
UPDATE accounts SET balance = 0 WHERE account_id = 2;

-- We changed our mind — roll back BOTH updates
ROLLBACK;

-- Verify accounts are back to their post-commit state (4500, 3500)
SELECT * FROM accounts;


-- 2c. SAVEPOINT demonstration
BEGIN;

-- First change: give Alice a raise
UPDATE employees SET salary = 80000 WHERE employee_id = 1;

-- Create a savepoint after the first change
SAVEPOINT after_alice_raise;

-- Second change: accidentally set everyone's salary to 0
UPDATE employees SET salary = 0;

-- View the damage
SELECT first_name, salary FROM employees ORDER BY employee_id LIMIT 3;

-- Roll back ONLY to the savepoint (undo the mass update, keep Alice's raise)
ROLLBACK TO SAVEPOINT after_alice_raise;

-- Commit: only Alice's raise is saved
COMMIT;

-- Verify: Alice has 80000, others have original salaries
SELECT first_name, last_name, salary FROM employees ORDER BY employee_id;


-- =============================================================================
-- SECTION 3: Views
-- =============================================================================

-- 3a. Create a simple view for high-earning employees
DROP VIEW IF EXISTS high_earners;

CREATE VIEW high_earners AS
SELECT employee_id, first_name, last_name, salary, department_id
FROM employees
WHERE salary > 75000;

-- Query the view
SELECT * FROM high_earners;

-- Use the view in a WHERE clause
SELECT first_name, last_name, salary
FROM high_earners
WHERE department_id = 10;


-- 3b. Create a view that joins employees and departments
DROP VIEW IF EXISTS employee_details;

CREATE VIEW employee_details AS
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    e.hire_date,
    d.department_name,
    d.location
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Use the richer view
SELECT * FROM employee_details WHERE location = 'New York';
SELECT department_name, COUNT(*) AS headcount, ROUND(AVG(salary), 2) AS avg_sal
FROM employee_details
GROUP BY department_name;


-- 3c. Drop a view
DROP VIEW IF EXISTS high_earners;
-- The underlying employees table is unaffected


-- =============================================================================
-- SECTION 4: Window Functions
-- =============================================================================

-- 4a. ROW_NUMBER: Rank employees by salary within each department
SELECT
    first_name,
    last_name,
    department_id,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank_in_dept
FROM employees;


-- 4b. RANK vs DENSE_RANK
-- Add a duplicate salary to see the difference
INSERT INTO employees VALUES (11, 'Zara', 'Kim', NULL, 88000.00, '2023-06-01', 10, 1);

SELECT
    first_name,
    salary,
    RANK()       OVER (ORDER BY salary DESC) AS rank_with_gaps,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank_no_gaps
FROM employees
ORDER BY salary DESC;

-- Clean up
DELETE FROM employees WHERE employee_id = 11;


-- 4c. Running total of salaries ordered by hire date
SELECT
    first_name,
    hire_date,
    salary,
    SUM(salary) OVER (ORDER BY hire_date) AS running_payroll
FROM employees
WHERE hire_date IS NOT NULL
ORDER BY hire_date;


-- 4d. LAG and LEAD: compare each employee's salary to the one before/after
SELECT
    first_name,
    salary,
    LAG(salary,  1, 0) OVER (ORDER BY salary) AS prev_lower_salary,
    LEAD(salary, 1, 0) OVER (ORDER BY salary) AS next_higher_salary,
    salary - LAG(salary, 1, salary) OVER (ORDER BY salary) AS diff_from_prev
FROM employees
ORDER BY salary;


-- 4e. NTILE: divide employees into 4 salary quartiles
SELECT
    first_name,
    salary,
    NTILE(4) OVER (ORDER BY salary) AS salary_quartile
FROM employees
ORDER BY salary;


-- =============================================================================
-- SECTION 5: Stored Procedures (MySQL syntax)
-- =============================================================================
-- NOTE: Run this section in MySQL only.
--       PostgreSQL uses CREATE OR REPLACE FUNCTION with PL/pgSQL.
--       SQLite does not support stored procedures.

-- Uncomment this entire section if using MySQL:

/*

DELIMITER $$

-- 5a. Simple procedure: get employees by department
DROP PROCEDURE IF EXISTS GetEmployeesByDept $$
CREATE PROCEDURE GetEmployeesByDept(IN dept_id INT)
BEGIN
    SELECT employee_id, first_name, last_name, salary
    FROM employees
    WHERE department_id = dept_id
    ORDER BY salary DESC;
END $$

-- 5b. Procedure with OUT parameter: get average salary for a department
DROP PROCEDURE IF EXISTS GetDeptAvgSalary $$
CREATE PROCEDURE GetDeptAvgSalary(IN dept_id INT, OUT avg_sal DECIMAL(10,2))
BEGIN
    SELECT AVG(salary) INTO avg_sal
    FROM employees
    WHERE department_id = dept_id;
END $$

-- 5c. Procedure with IF logic: give raise if below average
DROP PROCEDURE IF EXISTS GiveRaiseIfBelowAvg $$
CREATE PROCEDURE GiveRaiseIfBelowAvg(IN emp_id INT)
BEGIN
    DECLARE emp_salary DECIMAL(10,2);
    DECLARE avg_salary DECIMAL(10,2);

    SELECT salary INTO emp_salary FROM employees WHERE employee_id = emp_id;
    SELECT AVG(salary) INTO avg_salary FROM employees;

    IF emp_salary < avg_salary THEN
        UPDATE employees SET salary = salary * 1.10 WHERE employee_id = emp_id;
        SELECT CONCAT('Raise given. New salary: ', salary) AS message
        FROM employees WHERE employee_id = emp_id;
    ELSE
        SELECT 'No raise — already above average' AS message;
    END IF;
END $$

DELIMITER ;

-- Call the procedures:
CALL GetEmployeesByDept(10);

CALL GetDeptAvgSalary(10, @avg);
SELECT @avg AS engineering_avg;

CALL GiveRaiseIfBelowAvg(5);   -- Eve earns 54000 — below average

*/


-- =============================================================================
-- SECTION 6: Normalization Demo
-- =============================================================================

-- 6a. UNNORMALIZED table (violates 1NF — multiple skills in one cell)
CREATE TABLE student_courses_unnormalized (
    student_id   INT,
    student_name VARCHAR(100),
    courses      VARCHAR(200)   -- "SQL, Python, Java" — BAD! Multi-valued
);

INSERT INTO student_courses_unnormalized VALUES
    (1, 'Alice', 'SQL, Python, Java'),
    (2, 'Bob',   'SQL, R'),
    (3, 'Carol', 'Java, JavaScript');

SELECT * FROM student_courses_unnormalized;

-- This table is HARD to query: you can't easily find "all students taking SQL"


-- 6b. NORMALIZED tables (1NF through 3NF)

-- Students table
CREATE TABLE students (
    student_id   INT          PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL
);

-- Courses table
CREATE TABLE courses (
    course_id   INT          PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL
);

-- Enrollment junction table (satisfies 1NF, 2NF, 3NF)
CREATE TABLE enrollments (
    student_id INT,
    course_id  INT,
    grade      CHAR(2),
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id)  REFERENCES courses(course_id)
);

INSERT INTO students VALUES (1, 'Alice'), (2, 'Bob'), (3, 'Carol');
INSERT INTO courses  VALUES (1, 'SQL'), (2, 'Python'), (3, 'Java'), (4, 'R'), (5, 'JavaScript');

INSERT INTO enrollments VALUES
    (1, 1, 'A'),   -- Alice: SQL
    (1, 2, 'B'),   -- Alice: Python
    (1, 3, 'A'),   -- Alice: Java
    (2, 1, 'B'),   -- Bob: SQL
    (2, 4, 'A'),   -- Bob: R
    (3, 3, 'B'),   -- Carol: Java
    (3, 5, 'A');   -- Carol: JavaScript

-- Now we can easily answer "all students taking SQL"
SELECT s.student_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c     ON e.course_id  = c.course_id
WHERE c.course_name = 'SQL';

-- "What courses is Alice taking?"
SELECT c.course_name, e.grade
FROM enrollments e
JOIN courses c ON e.course_id = c.course_id
WHERE e.student_id = 1;


-- =============================================================================
-- CHALLENGE EXERCISES
-- =============================================================================
-- Challenge 1: Create a view called 'dept_summary' showing department_name,
--              employee count, and average salary for each department.
--
-- Challenge 2: Using a window function, find the top 2 earners in each department.
--
-- Challenge 3: Write a transaction that:
--              a) Increases all Engineering salaries by 5%
--              b) Decreases all Marketing salaries by 2%
--              Commit only if both updates succeed.
--
-- Challenge 4: Normalize this table to 3NF:
--   | order_id | customer_name | customer_city | product_id | product_name | qty |
-- =============================================================================

-- ANSWERS (uncomment to run):

-- Challenge 1:
-- CREATE VIEW dept_summary AS
-- SELECT d.department_name, COUNT(e.employee_id) AS headcount,
--        ROUND(AVG(e.salary), 2) AS avg_salary
-- FROM departments d
-- LEFT JOIN employees e ON d.department_id = e.department_id
-- GROUP BY d.department_name;
-- SELECT * FROM dept_summary;

-- Challenge 2:
-- SELECT * FROM (
--     SELECT first_name, last_name, department_id, salary,
--            DENSE_RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank
--     FROM employees
-- ) ranked
-- WHERE dept_rank <= 2
-- ORDER BY department_id, dept_rank;

-- Challenge 3:
-- BEGIN;
-- UPDATE employees SET salary = salary * 1.05 WHERE department_id = 10;
-- UPDATE employees SET salary = salary * 0.98 WHERE department_id = 20;
-- COMMIT;

-- Challenge 4 (3NF solution):
-- customers:  | customer_id | customer_name | customer_city |
-- products:   | product_id  | product_name |
-- orders:     | order_id    | customer_id |
-- order_items: | order_id   | product_id | qty |

-- =============================================================================
-- End of Day 3 Hands-On
-- =============================================================================
