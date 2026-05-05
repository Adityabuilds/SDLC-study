# SDLC-study
Comprehensive study plan for **SDLC** (Software Development Life Cycle) and **SQL** from scratch.

---

## Study Plan

| Discipline | Directory | Description |
|-----------|-----------|-------------|
| **SDLC** | [`/SDLC`](SDLC/) | 3-day plan · 2 hours/day · Top 30 interview Q&As |
| **SQL** | [`/SQL`](SQL/) | 3-day plan · 2 hours/day · Theory + hands-on SQL files · Top 30 interview Q&As |
| **Scenario A** | [`/ScenarioA`](ScenarioA/) | Construct 3D case study — network topology diagram, DMZ/web server zone, authentication & privilege analysis |

---

## Scenario A — Construct 3D (Cyber Security Case Study)

📁 [`ScenarioA/`](ScenarioA/)

| Document | Description |
|----------|-------------|
| [Network Topology Diagram](ScenarioA/network-topology.md) | Mermaid diagram (draw.io-compatible) showing all network zones including the **Web Server Zone (DMZ)**, perimeter firewall, internal LAN, analytics server, and cloud services |

### Web Server Zone — Quick Answer

> **Where is the Web Server zone?**
> The Web Server is in the **DMZ (Demilitarised Zone)** — the public-facing network segment
> inside the local data centre, located **behind the perimeter firewall** and **in front of the
> internal firewall**. It is reachable from the internet on **HTTPS port 443 only**.
> All other internal systems are isolated behind the internal firewall.

See [`ScenarioA/network-topology.md`](ScenarioA/network-topology.md) for the full labelled diagram and zone descriptions.

---

## SDLC — Software Development Life Cycle

📁 [`SDLC/`](SDLC/)

| Day | Topics |
|-----|--------|
| [Day 1](SDLC/Day1.md) | SDLC phases, Waterfall model, V-Model |
| [Day 2](SDLC/Day2.md) | Agile, Scrum, Kanban, DevOps, CI/CD |
| [Day 3](SDLC/Day3.md) | Software Testing, QA, Project Management |
| [Interview Q&A](SDLC/interview-questions.md) | Top 30 SDLC interview questions with detailed answers |

---

## SQL — Structured Query Language

📁 [`SQL/`](SQL/)

| Day | Theory | Hands-On SQL |
|-----|--------|-------------|
| [Day 1](SQL/Day1-theory.md) | Databases, RDBMS, SELECT, WHERE, ORDER BY, DDL/DML | [Day1-hands-on.sql](SQL/Day1-hands-on.sql) |
| [Day 2](SQL/Day2-theory.md) | JOINs, Aggregations, GROUP BY, HAVING, Subqueries, CTEs | [Day2-hands-on.sql](SQL/Day2-hands-on.sql) |
| [Day 3](SQL/Day3-theory.md) | Indexes, Transactions, Views, Window Functions, Stored Procedures, Normalization | [Day3-hands-on.sql](SQL/Day3-hands-on.sql) |
| [Interview Q&A](SQL/interview-questions.md) | Top 30 SQL interview questions with detailed answers | — |

### Running the SQL Files
```bash
# SQLite (no installation needed)
sqlite3 study.db < SQL/Day1-hands-on.sql

# MySQL
mysql -u root -p < SQL/Day1-hands-on.sql

# PostgreSQL
psql -U postgres -f SQL/Day1-hands-on.sql
```

All SQL files use standard ANSI SQL and are compatible with **MySQL 8+**, **PostgreSQL 13+**, and **SQLite 3**.
