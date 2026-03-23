# Day 3 — Indexes, Transactions, Views, Stored Procedures & Normalization (2 Hours)

## Hour 1: Indexes, Transactions & Views

### 1.1 Indexes

An **index** is a data structure (usually a B-tree) that allows the database to find rows **much faster** than scanning the entire table — similar to an index at the back of a book.

#### How Indexes Work
Without an index: the database does a **full table scan** — reads every row.  
With an index: the database jumps directly to matching rows using the index structure.

#### Types of Indexes

| Type | Description |
|------|-------------|
| **Primary Key Index** | Automatically created on the PRIMARY KEY column |
| **Unique Index** | Enforces uniqueness; created automatically with UNIQUE constraint |
| **Composite Index** | Index on two or more columns together |
| **Full-Text Index** | For searching large text fields (MySQL, PostgreSQL) |
| **Clustered Index** | Determines the physical order of rows in the table (one per table) |
| **Non-Clustered Index** | Separate structure pointing back to table rows (many per table) |

#### Creating and Dropping Indexes

```sql
-- Create an index on salary column
CREATE INDEX idx_salary ON employees(salary);

-- Create a composite index (useful for queries filtering by both columns)
CREATE INDEX idx_dept_salary ON employees(department_id, salary);

-- Create a unique index
CREATE UNIQUE INDEX idx_unique_email ON employees(email);

-- Drop an index
DROP INDEX idx_salary ON employees;   -- MySQL
-- DROP INDEX idx_salary;             -- PostgreSQL
```

#### When to Use Indexes
✅ Columns used frequently in `WHERE`, `JOIN ON`, `ORDER BY`, `GROUP BY`.  
✅ Foreign key columns (speeds up JOIN performance).  
✅ Columns in `UNIQUE` constraints.

#### When NOT to Index
❌ Small tables (full scan is faster).  
❌ Columns with low cardinality (e.g., a boolean `is_active` field).  
❌ Columns that are frequently updated (index maintenance overhead).  
❌ Heavy write workloads (inserts/updates/deletes are slower with many indexes).

---

### 1.2 Transactions

A **transaction** is a sequence of SQL statements executed as a **single unit**. Either all statements succeed (**COMMIT**) or all are rolled back (**ROLLBACK**), maintaining data integrity.

#### ACID Properties

| Property | Description | Example |
|----------|-------------|---------|
| **Atomicity** | All or nothing — entire transaction succeeds or fails | Bank transfer: debit + credit both happen, or neither does |
| **Consistency** | Database moves from one valid state to another | Balance can't go negative if constraint is defined |
| **Isolation** | Concurrent transactions don't interfere with each other | Two users booking the last seat simultaneously |
| **Durability** | Committed changes survive system failures | Power cut after COMMIT — data still persists |

#### Transaction Control

```sql
-- Start a transaction (MySQL / SQLite)
BEGIN;
-- or: START TRANSACTION;

-- Make changes
UPDATE accounts SET balance = balance - 500 WHERE account_id = 1;
UPDATE accounts SET balance = balance + 500 WHERE account_id = 2;

-- If everything is OK — save permanently
COMMIT;

-- If something goes wrong — undo everything since BEGIN
ROLLBACK;

-- SAVEPOINT: partial rollback
BEGIN;
UPDATE employees SET salary = 100000 WHERE employee_id = 1;
SAVEPOINT before_second_update;
UPDATE employees SET salary = 0 WHERE department_id = 10;  -- Oops!
ROLLBACK TO SAVEPOINT before_second_update;    -- Only undo the second update
COMMIT;  -- Keeps the first update
```

---

### 1.3 Views

A **view** is a **saved SELECT query** stored in the database. It acts like a virtual table — you can query it like a real table, but it doesn't store data itself.

```sql
-- Create a view
CREATE VIEW high_earners AS
SELECT employee_id, first_name, last_name, salary, department_id
FROM employees
WHERE salary > 80000;

-- Query the view (just like a table)
SELECT * FROM high_earners;

-- More complex view with JOIN
CREATE VIEW employee_details AS
SELECT
    e.employee_id,
    e.first_name,
    e.last_name,
    e.salary,
    d.department_name,
    d.location
FROM employees e
JOIN departments d ON e.department_id = d.department_id;

-- Use the view
SELECT * FROM employee_details WHERE location = 'New York';

-- Drop a view
DROP VIEW IF EXISTS high_earners;
```

#### Benefits of Views
- **Security:** Expose only specific columns/rows to certain users.
- **Simplicity:** Hide complex JOIN logic behind a simple name.
- **Reusability:** Write complex logic once; reuse many times.
- **Abstraction:** Applications don't need to change if underlying table structure changes.

---

## Hour 2: Window Functions, Stored Procedures & Normalization

### 2.1 Window Functions

**Window functions** perform calculations across a set of rows **related to the current row**, without collapsing rows like `GROUP BY`.

```sql
-- Syntax:
-- function_name() OVER ([PARTITION BY col] [ORDER BY col])

-- ROW_NUMBER: Assign a rank within each department
SELECT
    first_name,
    last_name,
    department_id,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rank_in_dept
FROM employees;

-- RANK: Same as ROW_NUMBER but ties get the same rank (with gaps)
SELECT
    first_name, salary,
    RANK() OVER (ORDER BY salary DESC) AS salary_rank
FROM employees;

-- DENSE_RANK: Like RANK but no gaps in ranking numbers
SELECT
    first_name, salary,
    DENSE_RANK() OVER (ORDER BY salary DESC) AS dense_rank
FROM employees;

-- SUM with running total
SELECT
    first_name, salary,
    SUM(salary) OVER (ORDER BY employee_id) AS running_total
FROM employees;

-- LAG / LEAD: Access previous/next row values
SELECT
    first_name, salary,
    LAG(salary,  1) OVER (ORDER BY salary) AS prev_salary,
    LEAD(salary, 1) OVER (ORDER BY salary) AS next_salary
FROM employees;
```

---

### 2.2 Stored Procedures

A **stored procedure** is a reusable block of SQL code stored in the database and executed by name.

```sql
-- MySQL syntax

DELIMITER $$

CREATE PROCEDURE GetEmployeesByDept(IN dept_id INT)
BEGIN
    SELECT employee_id, first_name, last_name, salary
    FROM employees
    WHERE department_id = dept_id;
END $$

DELIMITER ;

-- Call the procedure
CALL GetEmployeesByDept(10);
CALL GetEmployeesByDept(20);

-- Procedure with OUT parameter
DELIMITER $$

CREATE PROCEDURE GetDeptAvgSalary(IN dept_id INT, OUT avg_sal DECIMAL(10,2))
BEGIN
    SELECT AVG(salary) INTO avg_sal
    FROM employees
    WHERE department_id = dept_id;
END $$

DELIMITER ;

-- Call and get output
CALL GetDeptAvgSalary(10, @result);
SELECT @result AS engineering_avg_salary;
```

---

### 2.3 Database Normalization

**Normalization** is the process of organizing database tables to **reduce redundancy** and improve data integrity.

#### Why Normalize?
Unnormalized data leads to **anomalies**:
- **Insertion anomaly:** Can't add a department without adding an employee.
- **Update anomaly:** Changing a department name requires updating every employee row.
- **Deletion anomaly:** Deleting the last employee in a department loses the department data.

---

#### First Normal Form (1NF)
**Rule:** Each column contains **atomic (indivisible) values**; no repeating groups.

❌ Violates 1NF (multiple values in one cell):
```
| emp_id | name  | skills              |
| 1      | Alice | Java, Python, SQL   |
```

✅ Satisfies 1NF:
```
| emp_id | name  | skill  |
| 1      | Alice | Java   |
| 1      | Alice | Python |
| 1      | Alice | SQL    |
```

---

#### Second Normal Form (2NF)
**Rule:** Must be in 1NF **+** every non-key column must depend on the **entire primary key** (no partial dependencies).

Applies to tables with **composite primary keys**.

❌ Violates 2NF (`student_name` depends only on `student_id`, not the full key):
```
| student_id | course_id | student_name | grade |
```

✅ Satisfies 2NF (split into two tables):
```
students: | student_id | student_name |
enrollments: | student_id | course_id | grade |
```

---

#### Third Normal Form (3NF)
**Rule:** Must be in 2NF **+** no **transitive dependencies** (non-key columns must not depend on other non-key columns).

❌ Violates 3NF (`dept_location` depends on `dept_id`, not on `emp_id`):
```
| emp_id | dept_id | dept_location |
```

✅ Satisfies 3NF:
```
employees:   | emp_id | dept_id |
departments: | dept_id | dept_location |
```

---

#### Normalization Summary

| Form | What It Eliminates |
|------|-------------------|
| 1NF | Multi-valued cells, repeating groups |
| 2NF | Partial dependencies (in composite-key tables) |
| 3NF | Transitive dependencies (non-key → non-key) |
| BCNF | Edge cases 3NF misses (every determinant is a candidate key) |

---

## Day 3 Summary

| Concept | Key Takeaway |
|---------|--------------|
| Index | Speeds up read queries; slows down writes |
| ACID | Atomicity, Consistency, Isolation, Durability |
| Transaction | All-or-nothing execution with COMMIT/ROLLBACK |
| View | Saved SELECT query; virtual table |
| Window Function | Row-level calculations without collapsing rows |
| Stored Procedure | Reusable SQL logic stored in the database |
| Normalization | Eliminate redundancy and data anomalies |

---

## Day 3 Checklist
- [ ] Can I create and drop an index? Do I know when NOT to index?
- [ ] Can I explain all 4 ACID properties with examples?
- [ ] Can I write a transaction with a SAVEPOINT?
- [ ] Can I create a view and explain its benefits?
- [ ] Can I use ROW_NUMBER, RANK, and LAG window functions?
- [ ] Can I normalize a table from an unnormalized form to 3NF?

➡️ **Hands-on practice: [Day3-hands-on.sql](Day3-hands-on.sql)**  
➡️ **Now test yourself: [Top 30 SQL Interview Questions](interview-questions.md)**
