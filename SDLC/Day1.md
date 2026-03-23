# Day 1 — SDLC Fundamentals (2 Hours)

## Hour 1: What Is SDLC and Why It Matters

### 1.1 Definition
The **Software Development Life Cycle (SDLC)** is a structured process that defines the tasks required to build, deploy, and maintain software. It provides a framework to plan, create, test, and deliver software in a systematic, cost-effective, and high-quality manner.

### 1.2 Why SDLC Matters
- Provides a **clear roadmap** for development teams.
- Helps manage **time, cost, and quality** simultaneously.
- Reduces project **risks** through structured planning.
- Improves **communication** between stakeholders and developers.
- Enables easier **maintenance and future enhancements**.

---

## 1.3 The Core Phases of SDLC

Every SDLC model, regardless of methodology, passes through these fundamental phases:

### Phase 1 — Planning
- Define the **scope** and **purpose** of the project.
- Identify stakeholders and their requirements.
- Conduct a **feasibility study** (technical, financial, legal).
- Create a project timeline and allocate resources.
- **Output:** Project Charter, Feasibility Report, Resource Plan.

### Phase 2 — Requirements Analysis
- Gather **functional requirements** (what the system should do).
- Gather **non-functional requirements** (performance, security, scalability).
- Conduct stakeholder interviews, workshops, surveys.
- Document requirements in a **Software Requirements Specification (SRS)**.
- **Output:** SRS Document, Use Case Diagrams.

### Phase 3 — System Design
- Translate requirements into a **blueprint** for the system.
- **High-Level Design (HLD):** Overall system architecture, technology stack, databases, servers.
- **Low-Level Design (LLD):** Detailed module design, database schemas, algorithms.
- **Output:** Architecture Design Document, Database Schema, UI Wireframes.

### Phase 4 — Implementation (Coding)
- Developers write code based on design documents.
- Follow **coding standards** and guidelines.
- Use **version control** (Git) to track changes.
- **Output:** Source Code, Unit Tests.

### Phase 5 — Testing
- Verify that the software meets requirements.
- Types include: Unit, Integration, System, User Acceptance Testing (UAT).
- Identify and fix **defects/bugs**.
- **Output:** Test Plans, Test Cases, Bug Reports.

### Phase 6 — Deployment
- Release the software to the **production environment**.
- May be phased (pilot, canary, blue-green deployment).
- **Output:** Deployed Application, Deployment Documentation.

### Phase 7 — Maintenance
- Monitor software performance post-release.
- Fix **post-production bugs**.
- Release **updates and patches**.
- **Output:** Maintenance Logs, Updated Software.

---

## Hour 2: SDLC Models — Waterfall & V-Model

### 2.1 The Waterfall Model

The **Waterfall model** is the oldest and most straightforward SDLC model. Phases flow sequentially — like water flowing downward.

```
Planning → Requirements → Design → Implementation → Testing → Deployment → Maintenance
```

#### Key Characteristics
- Each phase must be **100% complete** before the next begins.
- No going back to a previous phase once it's done (or very costly to do so).
- Heavy documentation at every stage.

#### Advantages
| Advantage | Description |
|-----------|-------------|
| Simple & structured | Easy to understand and manage |
| Clear milestones | Progress is easily measurable |
| Well-documented | Easy to hand off between teams |
| Best for fixed requirements | When requirements are well-understood upfront |

#### Disadvantages
| Disadvantage | Description |
|--------------|-------------|
| Inflexible | Hard to accommodate changing requirements |
| Late testing | Bugs found late are expensive to fix |
| No working software until late | Customers see nothing until end |
| Poor for complex projects | Not suited for projects with unknowns |

#### When to Use Waterfall
- Requirements are **well-defined and stable**.
- Short projects with **predictable** outcomes.
- Government or defense projects with **strict documentation** needs.
- Example: Building a payroll system with fixed government rules.

---

### 2.2 The V-Model (Verification and Validation Model)

The **V-Model** extends Waterfall by pairing each development phase with a corresponding **testing phase**, forming a "V" shape.

```
Requirements Analysis  ←→  Acceptance Testing
    System Design       ←→  System Testing
    Architectural Design ←→  Integration Testing
    Module Design       ←→  Unit Testing
                [Coding at the bottom]
```

#### Key Characteristics
- Testing is planned **in parallel** with each development phase.
- Verification (are we building it right?) paired with Validation (are we building the right thing?).
- Testing activities start early, reducing defect cost.

#### Advantages
- Early detection of design flaws.
- Test planning begins from day one.
- Clear, traceable requirements → test cases.

#### Disadvantages
- Still sequential; no iteration.
- Not suited for projects with evolving requirements.
- Expensive if requirements change.

---

### 2.3 Comparison: Waterfall vs V-Model

| Aspect | Waterfall | V-Model |
|--------|-----------|---------|
| Testing approach | After coding ends | Parallel to development |
| Cost of defects | High (found late) | Lower (found earlier) |
| Flexibility | Low | Low |
| Documentation | Heavy | Very heavy |
| Best use case | Well-defined projects | Safety-critical systems (medical, aviation) |

---

## Day 1 Summary

| Concept | Key Takeaway |
|---------|--------------|
| SDLC | Structured process to build quality software |
| 7 Phases | Planning → Requirements → Design → Coding → Testing → Deployment → Maintenance |
| Waterfall | Sequential, rigid, great for stable requirements |
| V-Model | Pairs each dev phase with a testing phase |

---

## Day 1 Checklist
- [ ] Can I name and describe all 7 SDLC phases?
- [ ] Do I understand the difference between functional and non-functional requirements?
- [ ] Can I explain the Waterfall model with its pros and cons?
- [ ] Can I draw the V-Model diagram from memory?
- [ ] Do I know when to choose Waterfall vs V-Model?

➡️ **Next: [Day 2 — Agile, Scrum & DevOps](Day2.md)**
