-- =============================================================================
-- SQL Day 2 Hands-On Practice
-- Topic: JOINs, Aggregations, GROUP BY, HAVING & Subqueries
-- Compatible with: MySQL 8+, PostgreSQL 13+, SQLite 3
--
-- HOW TO RUN:
--   MySQL:      mysql -u root -p < Day2-hands-on.sql
--   PostgreSQL: psql -U postgres -f Day2-hands-on.sql
--   SQLite:     sqlite3 study.db < Day2-hands-on.sql
-- =============================================================================


-- =============================================================================
-- SETUP: Rebuild tables from Day 1 for standalone use
-- =============================================================================

DROP TABLE IF EXISTS order_items;
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS projects;

CREATE TABLE departments (
    department_id   INT          PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    location        VARCHAR(100)
);

CREATE TABLE employees (
    employee_id   INT            PRIMARY KEY,
    first_name    VARCHAR(50)    NOT NULL,
    last_name     VARCHAR(50)    NOT NULL,
    email         VARCHAR(100)   UNIQUE,
    salary        DECIMAL(10,2)  DEFAULT 0.00,
    hire_date     DATE,
    department_id INT,
    manager_id    INT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

CREATE TABLE projects (
    project_id   INT          PRIMARY KEY,
    project_name VARCHAR(100) NOT NULL,
    department_id INT,
    budget       DECIMAL(12,2),
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

-- Populate departments
INSERT INTO departments VALUES
    (10, 'Engineering',  'New York'),
    (20, 'Marketing',    'Chicago'),
    (30, 'HR',           'San Francisco'),
    (40, 'Finance',      'Boston'),
    (50, 'Legal',        'New York');   -- No employees assigned yet

-- Populate employees (including manager_id for self-join)
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

-- Note: employee_id 11 has no department (for LEFT JOIN demo)
INSERT INTO employees (employee_id, first_name, last_name, salary, hire_date, department_id, manager_id)
VALUES (11, 'Kai', 'Lee', 60000.00, '2024-01-15', NULL, NULL);

-- Populate projects
INSERT INTO projects VALUES
    (101, 'Product Relaunch',  20, 500000.00),
    (102, 'Cloud Migration',   10, 1200000.00),
    (103, 'HRIS Upgrade',      30, 300000.00),
    (104, 'Brand Refresh',     20, 150000.00);
    -- Department 40 (Finance) and 50 (Legal) have no projects


-- =============================================================================
-- SECTION 1: INNER JOIN
-- =============================================================================

-- 1a. Basic INNER JOIN: employee names with their department names
SELECT
    e.first_name,
    e.last_name,
    d.department_name,
    d.location
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;

-- 1b. Three-table JOIN: employees + departments + projects
SELECT
    e.first_name,
    e.last_name,
    d.department_name,
    p.project_name,
    p.budget
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
INNER JOIN projects    p ON d.department_id = p.department_id;


-- =============================================================================
-- SECTION 2: LEFT JOIN
-- =============================================================================

-- 2a. All employees — even those without a department (Kai appears with NULL dept)
SELECT
    e.first_name,
    e.last_name,
    d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;

-- 2b. Find employees who have NO department assigned
SELECT
    e.first_name,
    e.last_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;

-- 2c. All departments — even those with no employees (Legal shows up)
SELECT
    d.department_name,
    e.first_name,
    e.last_name
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id;


-- =============================================================================
-- SECTION 3: SELF JOIN
-- =============================================================================

-- Show each employee with their manager's name
SELECT
    e.first_name    AS employee_first,
    e.last_name     AS employee_last,
    m.first_name    AS manager_first,
    m.last_name     AS manager_last
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id
ORDER BY m.last_name, e.last_name;


-- =============================================================================
-- SECTION 4: Aggregate Functions
-- =============================================================================

-- 4a. Company-wide statistics
SELECT
    COUNT(*)          AS total_headcount,
    COUNT(email)      AS employees_with_email,
    SUM(salary)       AS total_payroll,
    ROUND(AVG(salary), 2) AS avg_salary,
    MIN(salary)       AS lowest_salary,
    MAX(salary)       AS highest_salary
FROM employees;

-- 4b. How many employees are missing an email?
SELECT COUNT(*) - COUNT(email) AS missing_emails FROM employees;


-- =============================================================================
-- SECTION 5: GROUP BY
-- =============================================================================

-- 5a. Employee count per department
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
ORDER BY employee_count DESC;

-- 5b. Salary statistics per department
SELECT
    d.department_name,
    COUNT(e.employee_id)          AS headcount,
    ROUND(AVG(e.salary), 2)       AS avg_salary,
    MAX(e.salary)                 AS max_salary,
    MIN(e.salary)                 AS min_salary,
    SUM(e.salary)                 AS total_salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name
ORDER BY avg_salary DESC;

-- 5c. Count employees by hire year
SELECT
    -- MySQL / SQLite syntax:
    STRFTIME('%Y', hire_date) AS hire_year,    -- SQLite
    -- YEAR(hire_date) AS hire_year,           -- MySQL
    -- EXTRACT(YEAR FROM hire_date) AS hire_year, -- PostgreSQL
    COUNT(*) AS hires
FROM employees
WHERE hire_date IS NOT NULL
GROUP BY STRFTIME('%Y', hire_date)
ORDER BY hire_year;


-- =============================================================================
-- SECTION 6: HAVING
-- =============================================================================

-- 6a. Departments with more than 2 employees
SELECT
    d.department_name,
    COUNT(e.employee_id) AS employee_count
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING COUNT(e.employee_id) > 2;

-- 6b. Departments where average salary exceeds 70000
SELECT
    d.department_name,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > 70000
ORDER BY avg_salary DESC;

-- 6c. WHERE vs HAVING: filter before and after grouping
-- Find departments with avg salary > 70000, but only for employees hired before 2022
SELECT
    d.department_name,
    ROUND(AVG(e.salary), 2) AS avg_salary
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
WHERE e.hire_date < '2022-01-01'          -- WHERE filters BEFORE grouping
GROUP BY d.department_name
HAVING AVG(e.salary) > 70000;             -- HAVING filters AFTER grouping


-- =============================================================================
-- SECTION 7: Subqueries
-- =============================================================================

-- 7a. Scalar subquery: employees earning above company average
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

-- 7b. Subquery with IN: employees in departments located in New York
SELECT first_name, last_name, department_id
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location = 'New York'
);

-- 7c. Subquery in FROM (derived table): departments with above-average total payroll
SELECT dept_stats.department_name, dept_stats.total_payroll
FROM (
    SELECT d.department_name, SUM(e.salary) AS total_payroll
    FROM employees e
    INNER JOIN departments d ON e.department_id = d.department_id
    GROUP BY d.department_name
) AS dept_stats
WHERE dept_stats.total_payroll > (
    SELECT AVG(dept_total.dept_pay)
    FROM (
        SELECT SUM(salary) AS dept_pay
        FROM employees
        GROUP BY department_id
    ) AS dept_total
);

-- 7d. Correlated subquery: employees earning more than their department's average
SELECT
    e.first_name,
    e.last_name,
    e.salary,
    e.department_id
FROM employees e
WHERE e.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e.department_id
)
ORDER BY e.department_id, e.salary DESC;


-- =============================================================================
-- SECTION 8: Common Table Expressions (CTEs)
-- =============================================================================

-- 8a. Rewrite correlated subquery using a CTE for clarity
WITH dept_avg AS (
    SELECT department_id, ROUND(AVG(salary), 2) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT
    e.first_name,
    e.last_name,
    e.salary,
    da.avg_salary      AS dept_avg_salary,
    d.department_name
FROM employees e
JOIN dept_avg da ON e.department_id = da.department_id
JOIN departments d ON e.department_id = d.department_id
WHERE e.salary > da.avg_salary
ORDER BY d.department_name, e.salary DESC;

-- 8b. Multiple CTEs chained together
WITH
top_earners AS (
    SELECT employee_id, first_name, last_name, salary, department_id
    FROM employees
    WHERE salary > 80000
),
dept_info AS (
    SELECT department_id, department_name, location
    FROM departments
)
SELECT
    te.first_name,
    te.last_name,
    te.salary,
    di.department_name,
    di.location
FROM top_earners te
JOIN dept_info di ON te.department_id = di.department_id
ORDER BY te.salary DESC;


-- =============================================================================
-- CHALLENGE EXERCISES
-- =============================================================================
-- Try these before looking at the answers!
--
-- Challenge 1: Show each department's name and the number of projects assigned to it.
--              Include departments with NO projects (hint: use LEFT JOIN).
--
-- Challenge 2: Find the department(s) with the highest total payroll.
--
-- Challenge 3: List all employees who work in the same department as 'Alice Johnson'.
--              Do NOT hardcode department_id — use a subquery.
--
-- Challenge 4: Find managers (employees who manage at least one other employee)
--              and the count of employees they manage.
-- =============================================================================

-- ANSWERS (uncomment to run):

-- Challenge 1:
-- SELECT d.department_name, COUNT(p.project_id) AS project_count
-- FROM departments d
-- LEFT JOIN projects p ON d.department_id = p.department_id
-- GROUP BY d.department_name
-- ORDER BY project_count DESC;

-- Challenge 2:
-- SELECT d.department_name, SUM(e.salary) AS total_payroll
-- FROM employees e
-- JOIN departments d ON e.department_id = d.department_id
-- GROUP BY d.department_name
-- HAVING SUM(e.salary) = (
--     SELECT MAX(dept_pay)
--     FROM (SELECT SUM(salary) AS dept_pay FROM employees GROUP BY department_id) AS t
-- );

-- Challenge 3:
-- SELECT e.first_name, e.last_name
-- FROM employees e
-- WHERE e.department_id = (
--     SELECT department_id FROM employees WHERE first_name = 'Alice' AND last_name = 'Johnson'
-- )
-- AND NOT (e.first_name = 'Alice' AND e.last_name = 'Johnson');

-- Challenge 4:
-- SELECT m.first_name AS manager_first, m.last_name AS manager_last,
--        COUNT(e.employee_id) AS reports_count
-- FROM employees m
-- INNER JOIN employees e ON e.manager_id = m.employee_id
-- GROUP BY m.employee_id, m.first_name, m.last_name
-- ORDER BY reports_count DESC;

-- =============================================================================
-- End of Day 2 Hands-On
-- =============================================================================
