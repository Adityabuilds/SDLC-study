# Day 3 — Software Testing, QA & Project Management (2 Hours)

## Hour 1: Software Testing & Quality Assurance

### 1.1 What Is Software Testing?

**Software Testing** is the process of evaluating software to identify defects and ensure it meets specified requirements.

**Goal:** Ensure the software is:
- **Correct** — Does what it's supposed to do.
- **Reliable** — Works consistently under expected conditions.
- **Secure** — Free from vulnerabilities.
- **Performant** — Responds within acceptable time limits.

---

### 1.2 Types of Testing

#### By Level (Testing Pyramid)

```
            /‾‾‾‾‾‾‾‾‾‾‾‾\
           /   E2E Tests   \       ← Slow, expensive, high confidence
          /‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\
         / Integration Tests \     ← Test component interactions
        /‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\
       /      Unit Tests      \    ← Fast, cheap, test small units
      /‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾\
```

| Test Level | What It Tests | Who Writes It |
|-----------|---------------|---------------|
| **Unit Testing** | Individual functions/methods in isolation | Developers |
| **Integration Testing** | Interaction between modules/services | Developers / QA |
| **System Testing** | Entire application as a whole | QA Team |
| **Acceptance Testing (UAT)** | Business requirements from user perspective | Business / Client |
| **Regression Testing** | Ensure new changes don't break existing functionality | QA / Automation |
| **Performance Testing** | Speed, scalability, stability under load | QA / DevOps |
| **Security Testing** | Vulnerabilities, authentication, data leaks | Security Team |

---

#### By Approach

| Approach | Description | Tools |
|----------|-------------|-------|
| **Black-Box Testing** | Test without knowing internal code; focus on input/output | Selenium, Cypress |
| **White-Box Testing** | Test internal code structure, logic, branches | JUnit, pytest |
| **Grey-Box Testing** | Partial knowledge of internals | OWASP ZAP |
| **Exploratory Testing** | Unscripted, creative testing to find unexpected bugs | Manual |
| **Smoke Testing** | Quick sanity check after a new build | Any framework |
| **Sanity Testing** | Narrow regression test for a specific fix | Any framework |

---

### 1.3 Test-Driven Development (TDD)

**TDD** is a development practice where you write **tests before writing code**.

#### TDD Cycle (Red-Green-Refactor)
```
1. RED   — Write a failing test (test for feature that doesn't exist yet)
2. GREEN — Write the minimum code to make the test pass
3. REFACTOR — Improve the code without breaking the test
4. Repeat
```

#### Benefits of TDD
- Forces clear thinking about **requirements first**.
- Results in **higher test coverage** naturally.
- Produces **simpler, more modular** code.
- Acts as living **documentation** of code behavior.

---

### 1.4 Quality Assurance vs Quality Control

| Aspect | Quality Assurance (QA) | Quality Control (QC) |
|--------|------------------------|----------------------|
| **Focus** | Process (prevent defects) | Product (find defects) |
| **When** | Throughout development | During/after development |
| **Nature** | Proactive | Reactive |
| **Example** | Code reviews, process audits | Testing the final product |

---

### 1.5 Defect Life Cycle

```
New → Assigned → Open → Fixed → Retest → Closed
                                  ↓ (if still failing)
                               Reopened → Assigned again...
```

| Status | Description |
|--------|-------------|
| **New** | Bug reported for the first time |
| **Assigned** | Developer assigned to investigate |
| **Open** | Developer actively working on it |
| **Fixed** | Code fix implemented |
| **Retest** | QA verifies the fix |
| **Closed** | Bug confirmed fixed |
| **Reopened** | Bug reappears or wasn't truly fixed |
| **Deferred** | Postponed to a later release |
| **Rejected** | Not considered a valid defect |

---

## Hour 2: Project Management Concepts

### 2.1 Project Management in SDLC

Software projects need structured management to deliver **on time**, **within budget**, and **with required quality**.

---

### 2.2 Key Project Management Concepts

#### Work Breakdown Structure (WBS)
A hierarchical decomposition of the total work to accomplish the project objectives.
- Breaks the project into **manageable chunks**.
- Each level provides more **detail and specificity**.

#### Gantt Chart
- Visual timeline showing tasks, durations, dependencies, and milestones.
- Helps track **project schedule**.

#### Critical Path Method (CPM)
- Identifies the **longest sequence of dependent tasks** — the critical path.
- Delays on the critical path **directly delay the project**.
- Non-critical tasks have **float/slack** (can be delayed without affecting the end date).

---

### 2.3 Estimation Techniques

| Technique | Description |
|-----------|-------------|
| **Story Points** | Relative complexity measure used in Scrum |
| **Planning Poker** | Team consensus-based estimation game |
| **T-Shirt Sizing** | XS, S, M, L, XL sizing of tasks |
| **PERT** | Optimistic + Most Likely + Pessimistic estimates averaged |
| **Three-Point Estimation** | Similar to PERT; accounts for uncertainty |
| **Function Point Analysis** | Measure based on user-facing functionality |

---

### 2.4 Risk Management

| Step | Description |
|------|-------------|
| **Identify** | List all potential risks (technical, personnel, schedule, budget) |
| **Analyze** | Assess probability and impact of each risk |
| **Prioritize** | Focus on high-probability + high-impact risks first |
| **Plan Response** | Mitigate, avoid, transfer, or accept risks |
| **Monitor** | Track risks throughout the project lifecycle |

#### Risk Response Strategies
- **Avoid** — Change plan to eliminate the risk.
- **Mitigate** — Reduce likelihood or impact.
- **Transfer** — Shift risk to third party (insurance, outsourcing).
- **Accept** — Acknowledge and monitor; take action only if it occurs.

---

### 2.5 Change Management

In SDLC, **Change Management** controls how changes to requirements, design, or scope are handled.

**Change Control Process:**
```
Change Request → Impact Analysis → Approval/Rejection → Implementation → Verification
```

Key concept: **Scope Creep** — The gradual, uncontrolled expansion of project scope.  
Prevention: Clear requirements, Change Control Board (CCB), formal change request process.

---

### 2.6 Key SDLC Metrics

| Metric | What It Measures |
|--------|-----------------|
| **Velocity** | Story points completed per Sprint |
| **Defect Density** | Defects per KLOC (thousand lines of code) |
| **Lead Time** | Time from request to deployment |
| **Cycle Time** | Time from work-start to deployment |
| **MTTR** | Mean Time To Recovery (from an incident) |
| **Code Coverage** | % of code exercised by automated tests |
| **Burn-Down Chart** | Remaining work vs time in a Sprint |

---

## Day 3 Summary

| Concept | Key Takeaway |
|---------|--------------|
| Testing Levels | Unit → Integration → System → UAT |
| TDD | Write test first (Red-Green-Refactor) |
| QA vs QC | Process vs Product; Proactive vs Reactive |
| Defect Lifecycle | New → Assigned → Open → Fixed → Closed |
| Project Management | WBS, Gantt, CPM, Estimation, Risk Management |
| SDLC Metrics | Velocity, Defect Density, Lead Time, MTTR |

---

## Day 3 Checklist
- [ ] Can I name all testing levels and explain each?
- [ ] Do I understand the TDD Red-Green-Refactor cycle?
- [ ] Can I explain the difference between QA and QC?
- [ ] Can I trace a defect through its full lifecycle?
- [ ] Do I understand the Critical Path Method?
- [ ] Can I explain at least 4 risk response strategies?

➡️ **Now test yourself: [Top 30 SDLC Interview Questions](interview-questions.md)**
