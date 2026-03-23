# SQL Study Plan

## Overview
This section covers **SQL (Structured Query Language)** from scratch.  
Study commitment: **2 hours per day for 3 days**.

Every day includes both **theory** and a **hands-on SQL file** you can run directly in your local IDE or SQL client (MySQL, PostgreSQL, SQLite, or any RDBMS).

---

## 3-Day Study Schedule

| Day | Topics Covered | Files |
|-----|----------------|-------|
| [Day 1](Day1-theory.md) | Databases, RDBMS, SELECT, WHERE, ORDER BY, basic DDL/DML | [Theory](Day1-theory.md) · [Hands-On SQL](Day1-hands-on.sql) |
| [Day 2](Day2-theory.md) | JOINs, Subqueries, Aggregations, GROUP BY, HAVING | [Theory](Day2-theory.md) · [Hands-On SQL](Day2-hands-on.sql) |
| [Day 3](Day3-theory.md) | Indexes, Transactions, Views, Stored Procedures, Normalization | [Theory](Day3-theory.md) · [Hands-On SQL](Day3-hands-on.sql) |

---

## How to Run the Hands-On Files

### Option A — MySQL / MariaDB
```bash
mysql -u root -p < Day1-hands-on.sql
```

### Option B — PostgreSQL
```bash
psql -U postgres -f Day1-hands-on.sql
```

### Option C — SQLite (no installation needed)
```bash
sqlite3 study.db < Day1-hands-on.sql
```

### Option D — IDE / GUI Tools
- **MySQL Workbench** — Open the `.sql` file and click Run.
- **DBeaver** — Open file → Execute SQL Script.
- **TablePlus / DataGrip / pgAdmin** — Open and run the `.sql` file.

> All SQL files are written using **standard ANSI SQL** and are compatible with MySQL 8+, PostgreSQL 13+, and SQLite 3.

---

## Resources
- [Day 1 — Database Basics & Core Queries](Day1-theory.md)
- [Day 2 — JOINs, Aggregations & Subqueries](Day2-theory.md)
- [Day 3 — Advanced SQL Concepts](Day3-theory.md)
- [Top 30 Interview Questions & Answers](interview-questions.md)
