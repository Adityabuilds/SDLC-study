# Day 1 — Databases, RDBMS & Core SQL Queries (2 Hours)

## Hour 1: Database Fundamentals

### 1.1 What Is a Database?
A **database** is an organized collection of structured data stored electronically. Databases allow data to be efficiently stored, retrieved, updated, and deleted.

### 1.2 Types of Databases

| Type | Description | Examples |
|------|-------------|---------|
| **Relational (RDBMS)** | Data stored in tables with rows and columns; relationships defined by keys | MySQL, PostgreSQL, Oracle, SQL Server |
| **NoSQL** | Document, key-value, graph, or column-family stores | MongoDB, Redis, Cassandra |
| **NewSQL** | Relational + horizontal scalability | CockroachDB, Google Spanner |
| **In-Memory** | Data stored in RAM for ultra-fast access | Redis, Memcached |

---

### 1.3 Relational Database Management System (RDBMS)

In an RDBMS:
- Data is stored in **tables** (also called relations).
- Each table has **columns** (attributes) and **rows** (records/tuples).
- Tables are related through **keys**.

#### Key Concepts

| Concept | Definition | Example |
|---------|------------|---------|
| **Primary Key (PK)** | Uniquely identifies each row in a table | `employee_id` |
| **Foreign Key (FK)** | References a Primary Key in another table; enforces referential integrity | `department_id` in `employees` |
| **Unique Key** | Ensures all values in a column are unique (can allow one NULL) | `email` |
| **Composite Key** | Primary key made of two or more columns | `(order_id, product_id)` |
| **NULL** | Represents an unknown/missing value (not zero, not empty string) | `middle_name = NULL` |

---

### 1.4 SQL — Structured Query Language

**SQL** is the standard language for interacting with relational databases. It is divided into sub-languages:

| Sub-language | Purpose | Key Commands |
|-------------|---------|-------------|
| **DDL** (Data Definition Language) | Define database structure | `CREATE`, `ALTER`, `DROP`, `TRUNCATE` |
| **DML** (Data Manipulation Language) | Manipulate data | `INSERT`, `UPDATE`, `DELETE`, `SELECT` |
| **DCL** (Data Control Language) | Control access/permissions | `GRANT`, `REVOKE` |
| **TCL** (Transaction Control Language) | Manage transactions | `COMMIT`, `ROLLBACK`, `SAVEPOINT` |

---

## Hour 2: Core SQL Queries

### 2.1 Creating Tables — DDL

```sql
CREATE TABLE employees (
    employee_id   INT           PRIMARY KEY,
    first_name    VARCHAR(50)   NOT NULL,
    last_name     VARCHAR(50)   NOT NULL,
    email         VARCHAR(100)  UNIQUE,
    salary        DECIMAL(10,2) DEFAULT 0.00,
    hire_date     DATE,
    department_id INT
);
```

**Key constraints:**
- `NOT NULL` — Column must have a value.
- `UNIQUE` — All values must be distinct.
- `DEFAULT` — Value used when none is provided.
- `PRIMARY KEY` — Combines NOT NULL + UNIQUE; uniquely identifies a row.

---

### 2.2 Inserting Data — DML

```sql
-- Single row insert
INSERT INTO employees (employee_id, first_name, last_name, email, salary, hire_date, department_id)
VALUES (1, 'Alice', 'Johnson', 'alice@company.com', 75000.00, '2020-03-15', 10);

-- Multiple rows insert
INSERT INTO employees VALUES
(2, 'Bob',   'Smith',  'bob@company.com',   82000.00, '2019-07-22', 20),
(3, 'Carol', 'White',  'carol@company.com', 67000.00, '2021-01-10', 10),
(4, 'David', 'Brown',  'david@company.com', 91000.00, '2018-11-05', 30),
(5, 'Eve',   'Davis',  'eve@company.com',   54000.00, '2022-06-01', 20);
```

---

### 2.3 The SELECT Statement

The `SELECT` statement is the foundation of all data retrieval in SQL.

```sql
-- Select all columns
SELECT * FROM employees;

-- Select specific columns
SELECT first_name, last_name, salary FROM employees;

-- With column aliases (rename in output)
SELECT first_name AS "First Name", salary AS "Monthly Pay" FROM employees;
```

---

### 2.4 Filtering with WHERE

```sql
-- Simple condition
SELECT * FROM employees WHERE salary > 70000;

-- Multiple conditions with AND
SELECT * FROM employees WHERE salary > 70000 AND department_id = 10;

-- Multiple conditions with OR
SELECT * FROM employees WHERE department_id = 10 OR department_id = 20;

-- NOT operator
SELECT * FROM employees WHERE NOT department_id = 30;

-- BETWEEN (inclusive)
SELECT * FROM employees WHERE salary BETWEEN 60000 AND 90000;

-- IN (check against a list)
SELECT * FROM employees WHERE department_id IN (10, 20);

-- LIKE (pattern matching)
-- % matches any sequence of characters, _ matches a single character
SELECT * FROM employees WHERE first_name LIKE 'A%';     -- starts with A
SELECT * FROM employees WHERE email LIKE '%@company%';  -- contains @company
SELECT * FROM employees WHERE last_name LIKE '__o%';    -- 3rd char is 'o'

-- IS NULL / IS NOT NULL
SELECT * FROM employees WHERE email IS NOT NULL;
```

---

### 2.5 Sorting with ORDER BY

```sql
-- Ascending (default)
SELECT * FROM employees ORDER BY salary;
SELECT * FROM employees ORDER BY salary ASC;

-- Descending
SELECT * FROM employees ORDER BY salary DESC;

-- Multiple columns: sort by department, then by salary descending within each dept
SELECT * FROM employees ORDER BY department_id ASC, salary DESC;
```

---

### 2.6 Limiting Results

```sql
-- MySQL / PostgreSQL / SQLite
SELECT * FROM employees ORDER BY salary DESC LIMIT 3;

-- SQL Server / Oracle (use TOP or FETCH)
-- SQL Server: SELECT TOP 3 * FROM employees ORDER BY salary DESC;
-- Oracle: SELECT * FROM employees ORDER BY salary DESC FETCH FIRST 3 ROWS ONLY;

-- Pagination: skip first 2 rows, return next 3 (MySQL/PostgreSQL)
SELECT * FROM employees ORDER BY employee_id LIMIT 3 OFFSET 2;
```

---

### 2.7 Updating and Deleting Data

```sql
-- Update specific row
UPDATE employees SET salary = 80000.00 WHERE employee_id = 3;

-- Update multiple columns
UPDATE employees SET salary = 95000.00, department_id = 30 WHERE employee_id = 4;

-- Delete a specific row
DELETE FROM employees WHERE employee_id = 5;

-- WARNING: DELETE without WHERE removes ALL rows
-- DELETE FROM employees;   -- Don't do this without a WHERE clause!

-- TRUNCATE removes all rows faster (can't be rolled back in some DBs)
-- TRUNCATE TABLE employees;
```

---

## Day 1 Summary

| Concept | Key Takeaway |
|---------|--------------|
| RDBMS | Stores data in tables connected by keys |
| Primary Key | Unique, non-null identifier for each row |
| Foreign Key | Links one table to another |
| DDL | CREATE, ALTER, DROP — define structure |
| DML | SELECT, INSERT, UPDATE, DELETE — manipulate data |
| WHERE | Filter rows with conditions |
| ORDER BY | Sort results |
| LIMIT / OFFSET | Paginate results |

---

## Day 1 Checklist
- [ ] Can I create a table with constraints?
- [ ] Can I insert multiple rows with a single statement?
- [ ] Do I know when to use AND vs OR in WHERE clauses?
- [ ] Can I use BETWEEN, IN, LIKE, and IS NULL?
- [ ] Can I sort by multiple columns?
- [ ] Do I understand the risk of UPDATE/DELETE without a WHERE clause?

➡️ **Hands-on practice: [Day1-hands-on.sql](Day1-hands-on.sql)**  
➡️ **Next: [Day 2 — JOINs, Aggregations & Subqueries](Day2-theory.md)**
