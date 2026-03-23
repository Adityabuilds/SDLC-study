# Day 2 — Agile, Scrum, Kanban, DevOps & CI/CD (2 Hours)

## Hour 1: Agile & Scrum

### 1.1 What Is Agile?

**Agile** is an iterative approach to software development that emphasizes:
- Delivering **working software frequently** (every 1–4 weeks).
- **Collaboration** between cross-functional teams and customers.
- **Responding to change** over following a rigid plan.

Agile is guided by the **Agile Manifesto (2001)**, which defines 4 core values:

| Agile Values | Description |
|-------------|-------------|
| **Individuals and interactions** over processes and tools | People are more important than strict workflows |
| **Working software** over comprehensive documentation | Functional software > piles of paperwork |
| **Customer collaboration** over contract negotiation | Constant feedback loop with stakeholders |
| **Responding to change** over following a plan | Embrace changing requirements, even late |

#### 12 Agile Principles (Key Ones)
1. Deliver working software **frequently** (weeks, not months).
2. **Welcome changing requirements**, even late in development.
3. Business people and developers must **work together daily**.
4. **Sustainable pace** — teams should be able to maintain the pace indefinitely.
5. **Continuous attention** to technical excellence enhances agility.
6. **Simplicity** — maximizing the amount of work not done.

---

### 1.2 Scrum Framework

**Scrum** is the most popular Agile framework. It organizes work into **Sprints** — fixed-length iterations (usually 1–4 weeks).

#### Scrum Roles

| Role | Responsibility |
|------|----------------|
| **Product Owner (PO)** | Owns the Product Backlog; prioritizes features based on business value |
| **Scrum Master** | Facilitates Scrum events; removes impediments; serves the team |
| **Development Team** | Self-organizing cross-functional team that builds the product |

#### Scrum Artifacts

| Artifact | Description |
|----------|-------------|
| **Product Backlog** | Ordered list of all features, enhancements, and fixes (maintained by PO) |
| **Sprint Backlog** | Subset of Product Backlog items selected for the current Sprint |
| **Increment** | The potentially shippable product at the end of each Sprint |

#### Scrum Events (Ceremonies)

| Event | When | Duration | Purpose |
|-------|------|----------|---------|
| **Sprint Planning** | Start of Sprint | Max 8 hrs (4-week Sprint) | Select backlog items; define Sprint Goal |
| **Daily Scrum (Stand-up)** | Every day | 15 minutes | What did I do? What will I do? Blockers? |
| **Sprint Review** | End of Sprint | Max 4 hrs | Demo working software to stakeholders |
| **Sprint Retrospective** | After Sprint Review | Max 3 hrs | Inspect team process; plan improvements |

#### Scrum Flow
```
Product Backlog
      ↓ (Sprint Planning)
Sprint Backlog
      ↓ (2-week Sprint with Daily Scrums)
Potentially Shippable Increment
      ↓ (Sprint Review + Retrospective)
Repeat
```

---

### 1.3 Kanban

**Kanban** is another Agile methodology focused on **visualizing workflow** and **limiting Work in Progress (WIP)**.

#### Core Principles
1. **Visualize the workflow** — Use a Kanban board (To Do → In Progress → Done).
2. **Limit WIP** — Prevent overloading team members.
3. **Manage flow** — Optimize the speed and smoothness of work.
4. **Continuous improvement** — Regularly inspect and adapt.

#### Kanban vs Scrum

| Aspect | Scrum | Kanban |
|--------|-------|--------|
| Iterations | Fixed Sprints (1–4 weeks) | Continuous flow, no sprints |
| Roles | Defined (PO, SM, Dev Team) | No mandatory roles |
| WIP limits | Not explicit | Explicit WIP limits |
| Best for | Feature development | Ongoing maintenance / support |
| Change | Between Sprints | Anytime |

---

## Hour 2: DevOps & CI/CD

### 2.1 What Is DevOps?

**DevOps** is a **culture and practice** that brings together Development (Dev) and Operations (Ops) teams to shorten the software delivery cycle and improve reliability.

#### Core DevOps Principles (CALMS)

| Principle | Description |
|-----------|-------------|
| **Culture** | Break down silos; shared responsibility for delivery and uptime |
| **Automation** | Automate repetitive tasks (testing, deployment, monitoring) |
| **Lean** | Eliminate waste; focus on delivering value |
| **Measurement** | Measure everything — performance, failures, cycle time |
| **Sharing** | Share knowledge, tools, and feedback across teams |

#### DevOps Lifecycle
```
Plan → Code → Build → Test → Release → Deploy → Operate → Monitor → (back to Plan)
```

---

### 2.2 CI/CD Pipeline

**CI/CD** stands for **Continuous Integration** and **Continuous Delivery/Deployment**.

#### Continuous Integration (CI)
- Developers **merge code frequently** (multiple times per day) to a shared branch.
- Every merge triggers an **automated build and test** process.
- Goal: Catch integration bugs **early**.
- Tools: Jenkins, GitHub Actions, GitLab CI, CircleCI, Travis CI.

#### Continuous Delivery (CD)
- Code that passes CI is **automatically prepared for release** to staging/production.
- Deployment to production is a **manual trigger** (human approval).
- Goal: Ensure software is **always in a deployable state**.

#### Continuous Deployment
- Goes one step further — every change that passes all tests is **automatically deployed to production** with no human approval.
- Requires very high confidence in test coverage.
- Used by companies like Netflix, Amazon, Facebook.

#### CI/CD Pipeline Stages
```
Code Commit
     ↓
Source Control (Git)
     ↓
Build (Compile/Package)
     ↓
Unit Tests
     ↓
Code Quality Analysis (SonarQube)
     ↓
Integration Tests
     ↓
Staging Deployment
     ↓
Acceptance Tests / QA
     ↓
Production Deployment (Manual → CD; Automatic → Continuous Deployment)
     ↓
Monitor & Alert
```

---

### 2.3 Key DevOps Tools

| Category | Tools |
|----------|-------|
| Version Control | Git, GitHub, GitLab, Bitbucket |
| CI/CD | Jenkins, GitHub Actions, GitLab CI, CircleCI |
| Containerization | Docker, Podman |
| Orchestration | Kubernetes (K8s), Docker Swarm |
| Infrastructure as Code | Terraform, Ansible, CloudFormation |
| Monitoring | Prometheus, Grafana, Datadog, New Relic |
| Logging | ELK Stack (Elasticsearch, Logstash, Kibana) |

---

### 2.4 Agile + DevOps Together

Agile defines **what** to build and **how** teams collaborate.  
DevOps defines **how** to build, deploy, and operate software reliably.

```
Agile (Team practices) + DevOps (Technical practices) = Fast, Reliable, Quality Software
```

---

## Day 2 Summary

| Concept | Key Takeaway |
|---------|--------------|
| Agile | Iterative, customer-focused, embrace change |
| Scrum | Sprints, 3 roles, 3 artifacts, 4 ceremonies |
| Kanban | Visualize flow, limit WIP, continuous delivery |
| DevOps | Dev + Ops culture; automate everything |
| CI | Frequent code integration with automated tests |
| CD | Always-deployable code; automated release pipeline |

---

## Day 2 Checklist
- [ ] Can I explain the 4 Agile values?
- [ ] Can I describe each Scrum role, artifact, and event?
- [ ] Do I know the difference between Scrum and Kanban?
- [ ] Can I explain what DevOps is and the CALMS framework?
- [ ] Can I draw a CI/CD pipeline from memory?
- [ ] Do I know the difference between Continuous Delivery and Continuous Deployment?

➡️ **Next: [Day 3 — Testing, QA & Project Management](Day3.md)**
