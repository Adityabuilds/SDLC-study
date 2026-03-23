# Day 2 — JOINs, Aggregations & Subqueries (2 Hours)

## Hour 1: JOINs

### 1.1 Why JOINs?

Relational databases split data across multiple tables to reduce redundancy (**normalization**). JOINs allow you to **combine rows from two or more tables** based on a related column.

---

### 1.2 Types of JOINs

#### Visual Reference
```
Table A          Table B
[1,2,3]          [2,3,4]

INNER JOIN  →  [2,3]           (only matching rows)
LEFT JOIN   →  [1,2,3]         (all of A + matching B; NULLs for B where no match)
RIGHT JOIN  →  [2,3,4]         (matching A + all of B; NULLs for A where no match)
FULL OUTER  →  [1,2,3,4]       (all rows from both; NULLs where no match)
CROSS JOIN  →  [1×2,1×3...]    (every A row paired with every B row)
```

---

#### INNER JOIN
Returns only rows where there is a **match in both tables**.

```sql
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id;
```

> Employees without a department, or departments without employees, are excluded.

---

#### LEFT JOIN (LEFT OUTER JOIN)
Returns **all rows from the left table**, plus matched rows from the right table. If no match, NULLs appear for right-table columns.

```sql
SELECT e.first_name, e.last_name, d.department_name
FROM employees e
LEFT JOIN departments d ON e.department_id = d.department_id;
```

> Use LEFT JOIN when you want all records from the primary table regardless of whether there's a match.

---

#### RIGHT JOIN (RIGHT OUTER JOIN)
Returns **all rows from the right table**, plus matched rows from the left. Less common — usually rewritten as a LEFT JOIN.

```sql
SELECT e.first_name, d.department_name
FROM employees e
RIGHT JOIN departments d ON e.department_id = d.department_id;
```

---

#### FULL OUTER JOIN
Returns **all rows from both tables**. NULLs appear where there is no match on either side.

```sql
SELECT e.first_name, d.department_name
FROM employees e
FULL OUTER JOIN departments d ON e.department_id = d.department_id;
```

> Note: MySQL does not natively support FULL OUTER JOIN — use `LEFT JOIN UNION RIGHT JOIN` instead.

---

#### SELF JOIN
A table joined with **itself**. Useful for hierarchical data (e.g., employees and their managers).

```sql
-- employees table has a manager_id column referencing employee_id
SELECT e.first_name AS employee, m.first_name AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.employee_id;
```

---

### 1.3 JOIN Best Practices
- Always **alias** table names for readability (`employees e`).
- Specify the join condition explicitly with `ON`; avoid implicit cross joins.
- Use `INNER JOIN` by default; use `LEFT/RIGHT JOIN` when you need unmatched rows.
- Index the columns used in JOIN conditions for performance.

---

## Hour 2: Aggregations, GROUP BY, HAVING & Subqueries

### 2.1 Aggregate Functions

Aggregate functions perform **calculations on a set of rows** and return a single value.

| Function | Description | Example |
|----------|-------------|---------|
| `COUNT(*)` | Count all rows | `COUNT(*)` |
| `COUNT(col)` | Count non-NULL values in a column | `COUNT(email)` |
| `SUM(col)` | Sum of a numeric column | `SUM(salary)` |
| `AVG(col)` | Average of a numeric column | `AVG(salary)` |
| `MIN(col)` | Minimum value | `MIN(salary)` |
| `MAX(col)` | Maximum value | `MAX(salary)` |

```sql
SELECT
    COUNT(*)          AS total_employees,
    COUNT(email)      AS employees_with_email,
    SUM(salary)       AS total_salary_cost,
    AVG(salary)       AS average_salary,
    MIN(salary)       AS lowest_salary,
    MAX(salary)       AS highest_salary
FROM employees;
```

---

### 2.2 GROUP BY

`GROUP BY` divides rows into groups and applies aggregate functions to **each group**.

```sql
-- Count employees per department
SELECT department_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id;

-- Average salary per department (with department name via JOIN)
SELECT d.department_name, AVG(e.salary) AS avg_salary
FROM employees e
INNER JOIN departments d ON e.department_id = d.department_id
GROUP BY d.department_name;
```

**Rule:** Every non-aggregate column in `SELECT` must appear in `GROUP BY`.

---

### 2.3 HAVING

`HAVING` filters **grouped results** — like `WHERE` but applied after aggregation.

```sql
-- Departments with more than 2 employees
SELECT department_id, COUNT(*) AS emp_count
FROM employees
GROUP BY department_id
HAVING COUNT(*) > 2;

-- Departments where average salary exceeds 75000
SELECT department_id, AVG(salary) AS avg_sal
FROM employees
GROUP BY department_id
HAVING AVG(salary) > 75000;
```

#### WHERE vs HAVING

| Aspect | WHERE | HAVING |
|--------|-------|--------|
| When applied | Before grouping | After grouping |
| Works on | Individual rows | Grouped results |
| Can use aggregate functions | No | Yes |

---

### 2.4 SQL Query Execution Order

Understanding **logical execution order** helps write correct queries:

```
1. FROM / JOIN      — Identify source tables and join them
2. WHERE            — Filter individual rows
3. GROUP BY         — Group the filtered rows
4. HAVING           — Filter groups
5. SELECT           — Select columns / compute expressions
6. DISTINCT         — Remove duplicates (if applicable)
7. ORDER BY         — Sort final results
8. LIMIT / OFFSET   — Restrict rows returned
```

---

### 2.5 Subqueries

A **subquery** is a query nested inside another query.

#### Scalar Subquery (returns one value)
```sql
-- Find employees earning more than the average salary
SELECT first_name, last_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);
```

#### Subquery in FROM (Derived Table / Inline View)
```sql
-- Average salary per department, then find departments above company average
SELECT dept_avg.department_id, dept_avg.avg_sal
FROM (
    SELECT department_id, AVG(salary) AS avg_sal
    FROM employees
    GROUP BY department_id
) AS dept_avg
WHERE dept_avg.avg_sal > 70000;
```

#### Subquery with IN
```sql
-- Find employees in departments located in 'New York'
SELECT first_name, last_name
FROM employees
WHERE department_id IN (
    SELECT department_id
    FROM departments
    WHERE location = 'New York'
);
```

#### Correlated Subquery
A subquery that references the **outer query** — executed once per row of the outer query.

```sql
-- Find employees who earn more than the average salary in their own department
SELECT e1.first_name, e1.last_name, e1.salary, e1.department_id
FROM employees e1
WHERE e1.salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.department_id = e1.department_id
);
```

---

### 2.6 Common Table Expressions (CTEs)

A **CTE** (`WITH` clause) creates a named temporary result set, making complex queries more readable.

```sql
-- Same as correlated subquery above, but cleaner with CTE
WITH dept_averages AS (
    SELECT department_id, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department_id
)
SELECT e.first_name, e.last_name, e.salary, da.avg_salary
FROM employees e
JOIN dept_averages da ON e.department_id = da.department_id
WHERE e.salary > da.avg_salary;
```

---

## Day 2 Summary

| Concept | Key Takeaway |
|---------|--------------|
| INNER JOIN | Only matching rows from both tables |
| LEFT JOIN | All rows from left + matched rows from right |
| FULL OUTER JOIN | All rows from both tables |
| Aggregate Functions | COUNT, SUM, AVG, MIN, MAX |
| GROUP BY | Aggregate per group |
| HAVING | Filter after grouping |
| Subquery | Nested query; scalar, IN, correlated |
| CTE | Named temporary result for readable complex queries |

---

## Day 2 Checklist
- [ ] Can I explain each type of JOIN and when to use it?
- [ ] Can I write a query joining 3 tables?
- [ ] Do I understand the difference between WHERE and HAVING?
- [ ] Can I write a correlated subquery?
- [ ] Can I use a CTE to simplify a complex query?
- [ ] Do I know the SQL logical execution order?

➡️ **Hands-on practice: [Day2-hands-on.sql](Day2-hands-on.sql)**  
➡️ **Next: [Day 3 — Advanced SQL Concepts](Day3-theory.md)**
