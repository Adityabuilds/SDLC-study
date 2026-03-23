# Top 30 SQL Interview Questions & Answers

---

## Fundamentals

### Q1. What is SQL and what is it used for?
**Answer:**  
SQL (Structured Query Language) is the standard language for **managing and querying relational databases**. It is used to create tables (DDL), insert/update/delete data (DML), control access (DCL), and manage transactions (TCL).

**Explanation:** SQL is declarative — you describe *what* data you want, not *how* to retrieve it. The database engine figures out the most efficient way to fetch it.

---

### Q2. What is the difference between DDL, DML, DCL, and TCL?
**Answer:**  
| Sub-language | Commands | Purpose |
|-------------|---------|---------|
| **DDL** | CREATE, ALTER, DROP, TRUNCATE | Define/modify database structure |
| **DML** | SELECT, INSERT, UPDATE, DELETE | Manipulate data |
| **DCL** | GRANT, REVOKE | Control user access/permissions |
| **TCL** | COMMIT, ROLLBACK, SAVEPOINT | Manage transactions |

**Explanation:** Think of DDL as the architect's work (design the structure), DML as the day-to-day data work, DCL as security management, and TCL as the safety net for data changes.

---

### Q3. What is a Primary Key?
**Answer:**  
A **Primary Key** is a column (or combination of columns) that **uniquely identifies each row** in a table. It enforces two constraints: `NOT NULL` (must have a value) and `UNIQUE` (no two rows can have the same PK value).

**Explanation:** Every table should have a primary key. Without one, rows are indistinguishable, making updates and deletes unreliable.

---

### Q4. What is a Foreign Key?
**Answer:**  
A **Foreign Key** is a column that references the **Primary Key of another table**. It enforces **referential integrity** — you cannot insert a FK value that doesn't exist in the referenced table, and you cannot delete a referenced PK row without handling dependent FK rows.

**Explanation:** FKs are the mechanism that makes a database "relational." They define how tables relate to each other and prevent orphaned records.

---

### Q5. What is the difference between DELETE, TRUNCATE, and DROP?
**Answer:**  
| Command | What It Does | Rollback? | Removes Structure? |
|---------|-------------|-----------|-------------------|
| `DELETE` | Removes specific rows (with WHERE) or all rows | Yes (DML, in a transaction) | No |
| `TRUNCATE` | Removes all rows instantly; resets auto-increment | Usually No (DDL in most DBs) | No |
| `DROP` | Removes the entire table including structure | No | Yes |

**Explanation:** Use `DELETE` when you need to conditionally remove rows or might need to undo. Use `TRUNCATE` to quickly empty a table. Use `DROP` to permanently remove the table.

---

### Q6. What is the difference between WHERE and HAVING?
**Answer:**  
- `WHERE` filters **individual rows before** grouping (`GROUP BY`).
- `HAVING` filters **groups after** aggregation.

```sql
SELECT department_id, AVG(salary) AS avg_sal
FROM employees
WHERE hire_date > '2018-01-01'   -- filters rows first
GROUP BY department_id
HAVING AVG(salary) > 70000;      -- filters groups after
```

**Explanation:** `WHERE` can't use aggregate functions because aggregation hasn't happened yet. `HAVING` exists specifically to filter on aggregated results.

---

### Q7. What are aggregate functions in SQL?
**Answer:**  
Aggregate functions compute a **single value from multiple rows**:
- `COUNT(*)` / `COUNT(col)` — Row count
- `SUM(col)` — Sum
- `AVG(col)` — Average
- `MIN(col)` / `MAX(col)` — Minimum/Maximum

**Explanation:** They are typically used with `GROUP BY` to summarize data per group. Without `GROUP BY`, they produce a single result for the entire table.

---

### Q8. What is the difference between CHAR and VARCHAR?
**Answer:**  
| Type | Storage | Best For |
|------|---------|---------|
| `CHAR(n)` | Fixed length — always stores exactly n characters (pads with spaces) | Fixed-length data like country codes ('US', 'IN') |
| `VARCHAR(n)` | Variable length — stores only actual characters up to n | Variable-length data like names, emails |

**Explanation:** `CHAR` wastes space for short values but is slightly faster for fixed-length lookups. `VARCHAR` saves space but has a tiny overhead for tracking length.

---

### Q9. What is NULL in SQL and how do you handle it?
**Answer:**  
`NULL` represents an **unknown or missing value** — it is not zero, not an empty string, not false. Any comparison with NULL using `=` returns UNKNOWN (not TRUE or FALSE).

```sql
-- WRONG: this returns no rows even if email is NULL
SELECT * FROM employees WHERE email = NULL;

-- CORRECT:
SELECT * FROM employees WHERE email IS NULL;
SELECT * FROM employees WHERE email IS NOT NULL;

-- COALESCE: returns the first non-NULL value
SELECT COALESCE(email, 'No email provided') FROM employees;
```

**Explanation:** NULL propagates in arithmetic (5 + NULL = NULL) and comparisons. Always use `IS NULL` / `IS NOT NULL`, never `= NULL`.

---

### Q10. What is the difference between UNION and UNION ALL?
**Answer:**  
- `UNION` combines results from two queries and **removes duplicates** (slower — sorts to find duplicates).
- `UNION ALL` combines results and **keeps all rows** including duplicates (faster).

```sql
SELECT city FROM customers
UNION
SELECT city FROM suppliers;   -- Distinct cities only

SELECT city FROM customers
UNION ALL
SELECT city FROM suppliers;   -- All cities, including duplicates
```

**Explanation:** Use `UNION` when duplicates must be removed. Use `UNION ALL` when you know data is distinct or performance matters more.

---

## JOINs

### Q11. What is the difference between INNER JOIN and LEFT JOIN?
**Answer:**  
- `INNER JOIN` returns only rows with a **matching record in both tables**.
- `LEFT JOIN` returns **all rows from the left table** plus matched rows from the right table. Unmatched right-table columns appear as NULL.

```sql
-- INNER: only employees WITH a department
SELECT e.first_name, d.department_name
FROM employees e INNER JOIN departments d ON e.department_id = d.department_id;

-- LEFT: ALL employees, even those without a department
SELECT e.first_name, d.department_name
FROM employees e LEFT JOIN departments d ON e.department_id = d.department_id;
```

**Explanation:** Use INNER JOIN when you only want complete matches. Use LEFT JOIN when the left table's data is the primary focus and the right table data is optional.

---

### Q12. What is a Self Join?
**Answer:**  
A **Self Join** joins a table **with itself**. It's used for hierarchical relationships within a single table (e.g., employees and their managers stored in the same table).

```sql
SELECT e.first_name AS employee, m.first_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;
```

**Explanation:** The key is aliasing — use different aliases for the two "instances" of the same table to distinguish them in the query.

---

### Q13. What is a CROSS JOIN?
**Answer:**  
A `CROSS JOIN` returns the **Cartesian product** — every row from the first table paired with every row from the second table. If Table A has 5 rows and Table B has 4 rows, the result is 20 rows.

```sql
SELECT a.color, b.size
FROM colors a
CROSS JOIN sizes b;
```

**Explanation:** CROSS JOINs are rarely used for regular queries but are useful for generating combinations (e.g., all color-size product variants).

---

### Q14. How do you find rows in Table A that have no match in Table B?
**Answer:**  
Use a `LEFT JOIN` and filter for `NULL` in the right table's primary key:

```sql
SELECT e.first_name, e.last_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id
WHERE d.department_id IS NULL;
```

**Explanation:** This is the classic "anti-join" pattern. The LEFT JOIN keeps all employees; the `WHERE d.department_id IS NULL` keeps only those with no matching department.

---

## Aggregations & Subqueries

### Q15. How do you find the second highest salary?
**Answer:**  
Multiple approaches:

```sql
-- Approach 1: Subquery
SELECT MAX(salary) AS second_highest
FROM employees
WHERE salary < (SELECT MAX(salary) FROM employees);

-- Approach 2: LIMIT with OFFSET
SELECT DISTINCT salary
FROM employees
ORDER BY salary DESC
LIMIT 1 OFFSET 1;

-- Approach 3: Dense Rank window function
SELECT salary FROM (
    SELECT salary, DENSE_RANK() OVER (ORDER BY salary DESC) AS rnk
    FROM employees
) ranked
WHERE rnk = 2;
```

**Explanation:** This is one of the most common SQL interview questions. The window function approach is the most general — it easily extends to Nth highest.

---

### Q16. What is the difference between a correlated and a non-correlated subquery?
**Answer:**  
- **Non-correlated subquery:** Executes **independently** of the outer query. Runs once.
- **Correlated subquery:** References a column from the **outer query**. Executes once **per row** of the outer query.

```sql
-- Non-correlated (runs once):
SELECT * FROM employees WHERE salary > (SELECT AVG(salary) FROM employees);

-- Correlated (runs for each employee row):
SELECT * FROM employees e1
WHERE salary > (SELECT AVG(salary) FROM employees e2 WHERE e2.department_id = e1.department_id);
```

**Explanation:** Correlated subqueries can be expensive on large tables. Often replaced by JOINs with CTEs for better performance.

---

### Q17. What is a CTE (Common Table Expression)?
**Answer:**  
A **CTE** (using the `WITH` clause) is a **named temporary result set** that exists only for the duration of a single query. It makes complex queries more readable and can be referenced multiple times.

```sql
WITH dept_avg AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT e.first_name, e.salary, da.avg_salary
FROM employees e
JOIN dept_avg da ON e.department_id = da.department_id
WHERE e.salary > da.avg_salary;
```

**Explanation:** CTEs improve readability by replacing deeply nested subqueries. They do not always improve performance — check your database's execution plan.

---

### Q18. How do you find duplicate rows in a table?
**Answer:**  
```sql
-- Find duplicate emails
SELECT email, COUNT(*) AS occurrences
FROM employees
WHERE email IS NOT NULL
GROUP BY email
HAVING COUNT(*) > 1;

-- Find ALL columns that are fully duplicated
SELECT first_name, last_name, email, COUNT(*) AS cnt
FROM employees
GROUP BY first_name, last_name, email
HAVING COUNT(*) > 1;
```

**Explanation:** `GROUP BY` on the columns that define uniqueness, then `HAVING COUNT(*) > 1` filters for groups with more than one row — those are the duplicates.

---

## Indexes & Performance

### Q19. What is an index in SQL?
**Answer:**  
An **index** is a data structure (typically a B-tree) that allows the database to locate rows faster than scanning the entire table. Indexes speed up `SELECT` queries but slow down `INSERT`, `UPDATE`, and `DELETE` operations because the index must be maintained.

**Explanation:** Think of a book index — instead of reading every page to find "recursion," you look it up in the index and jump to page 142. A database index works the same way.

---

### Q20. What is the difference between a clustered and a non-clustered index?
**Answer:**  
- **Clustered Index:** Determines the **physical storage order** of rows in the table. Only one per table. In MySQL InnoDB, the Primary Key is always the clustered index.
- **Non-Clustered Index:** A **separate structure** that points to the actual data rows. Many per table.

**Explanation:** Clustered index = the data IS the index. Non-clustered index = a separate lookup table that tells you where to find the data.

---

### Q21. When should you NOT create an index?
**Answer:**  
Avoid indexes on:
- **Columns with low cardinality** (e.g., a boolean `is_active` — only 2 values).
- **Frequently updated columns** (each update must also update the index).
- **Small tables** (full scan is faster than index lookup + data fetch).
- **Rarely queried columns**.

**Explanation:** Every index adds write overhead. Over-indexing can make inserts and updates significantly slower, which can be worse than slightly slower reads.

---

## Transactions & ACID

### Q22. What are ACID properties?
**Answer:**  
ACID defines the guarantees a database transaction must provide:

| Property | Meaning |
|----------|---------|
| **Atomicity** | All operations in a transaction succeed, or all fail (all-or-nothing) |
| **Consistency** | Transaction moves database from one valid state to another |
| **Isolation** | Concurrent transactions don't interfere with each other |
| **Durability** | Committed transactions survive system failures (written to disk) |

**Explanation:** The classic example is a bank transfer: debit Account A AND credit Account B must both succeed (Atomicity). After the transfer, both accounts must satisfy balance constraints (Consistency).

---

### Q23. What is the difference between COMMIT and ROLLBACK?
**Answer:**  
- `COMMIT` permanently **saves all changes** made during the current transaction to the database.
- `ROLLBACK` **undoes all changes** made since the last COMMIT, returning the database to its previous state.

```sql
BEGIN;
UPDATE accounts SET balance = balance - 100 WHERE id = 1;
-- Something goes wrong...
ROLLBACK;   -- Account 1 balance is unchanged
```

**Explanation:** Think of `BEGIN...COMMIT` like a document edit session — `COMMIT` is Ctrl+S, `ROLLBACK` is Ctrl+Z all the way back to the last save.

---

## Views, Window Functions & Normalization

### Q24. What is a View in SQL?
**Answer:**  
A **View** is a saved SELECT query stored in the database with a name. It behaves like a virtual table — you can `SELECT` from it, but it stores no data itself. The underlying query runs each time the view is queried.

**Explanation:** Views provide abstraction (hide complexity), security (expose only certain columns/rows), and reusability. They don't improve performance unless the database supports **materialized views**.

---

### Q25. What are Window Functions?
**Answer:**  
Window functions perform calculations across a **set of rows related to the current row** (the "window") without collapsing rows like `GROUP BY` does. They use the `OVER()` clause.

```sql
SELECT
    first_name, salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) AS dept_rank,
    AVG(salary) OVER (PARTITION BY department_id) AS dept_avg
FROM employees;
```

**Explanation:** Unlike `GROUP BY`, window functions return a value for **every row** while still computing across multiple rows. They're essential for rankings, running totals, and moving averages.

---

### Q26. What is the difference between RANK(), DENSE_RANK(), and ROW_NUMBER()?
**Answer:**  
All three assign a number to rows based on an ordering, but they handle **ties** differently:

| Function | Tie Handling | Example (tied at 2nd) |
|----------|-------------|----------------------|
| `ROW_NUMBER()` | Assigns unique numbers; ties broken arbitrarily | 1, 2, 3, 4 |
| `RANK()` | Ties get the same rank; next rank skips numbers | 1, 2, 2, 4 |
| `DENSE_RANK()` | Ties get the same rank; no gaps | 1, 2, 2, 3 |

**Explanation:** Use `ROW_NUMBER` for pagination. Use `RANK` when skipping numbers after a tie is acceptable. Use `DENSE_RANK` for top-N queries where gaps in ranking don't make sense.

---

### Q27. What is database normalization?
**Answer:**  
**Normalization** is the process of structuring tables to **minimize data redundancy** and prevent data anomalies.

- **1NF:** Each cell contains atomic (single) values; no repeating groups.
- **2NF:** 1NF + no partial dependencies (every non-key column depends on the entire primary key).
- **3NF:** 2NF + no transitive dependencies (non-key columns don't depend on other non-key columns).

**Explanation:** An unnormalized database has duplication (storing a department name in every employee row). If you rename the department, you must update every row — leading to update anomalies. Normalization solves this by storing the department name once.

---

### Q28. What is denormalization and when would you use it?
**Answer:**  
**Denormalization** is **intentionally introducing redundancy** into a normalized database to improve **read performance** — at the cost of more complex write logic.

**When to use it:**
- Read-heavy workloads (data warehouses, reporting databases).
- When JOINs across many tables become a performance bottleneck.
- Pre-computed aggregations for dashboards.

**Explanation:** Normalization optimizes for writes and storage; denormalization optimizes for reads. Most OLAP/analytical databases are denormalized (star schema, flat wide tables).

---

### Q29. What is a stored procedure?
**Answer:**  
A **stored procedure** is a precompiled, reusable block of SQL statements stored in the database and invoked by name. It can accept input parameters and return output values.

```sql
CALL GetEmployeesByDept(10);
```

**Benefits:** Reduces network traffic (logic runs in the database), encapsulates business logic, allows parameterized/reusable queries, can improve performance through precompilation.

**Explanation:** Instead of sending 10 SQL statements from the application every time, you call one stored procedure. The database already has the compiled execution plan ready.

---

### Q30. What is the difference between a stored procedure and a function in SQL?
**Answer:**  
| Aspect | Stored Procedure | Function |
|--------|-----------------|---------|
| **Returns** | Zero, one, or many result sets | Always returns a single value |
| **Can be used in SELECT** | No | Yes (scalar functions) |
| **Can modify data** | Yes (INSERT/UPDATE/DELETE allowed) | Usually read-only |
| **Transactions** | Can manage transactions | Cannot (in most DBs) |
| **Called with** | `CALL procedure_name()` | `SELECT function_name()` |

**Explanation:** Use a function when you need a reusable calculation you can embed in a SELECT. Use a stored procedure when you need to execute complex logic with side effects (data modifications, multiple result sets).

---

*Review all 3 Days to reinforce these answers before your SQL interview!*
