# Top 30 SDLC Interview Questions & Answers

---

## Fundamentals

### Q1. What is SDLC?
**Answer:**  
SDLC (Software Development Life Cycle) is a structured process that defines the steps required to plan, design, develop, test, deploy, and maintain software systems. It provides a systematic approach to producing high-quality software within time and budget constraints.

**Explanation:** Think of SDLC as the blueprint for building software — just like architects use blueprints before construction, developers use SDLC to ensure every phase is planned and executed correctly.

---

### Q2. What are the phases of SDLC?
**Answer:**  
The 7 phases are:
1. **Planning** — Define scope, feasibility, resources.
2. **Requirements Analysis** — Gather and document what the system must do.
3. **System Design** — Architect the solution (HLD + LLD).
4. **Implementation (Coding)** — Developers write the code.
5. **Testing** — Verify correctness and find defects.
6. **Deployment** — Release software to production.
7. **Maintenance** — Ongoing support, patches, and improvements.

**Explanation:** These phases answer: *What are we building? How will we build it? Is it working? Can we ship it?*

---

### Q3. What is the difference between a process and a methodology in SDLC?
**Answer:**  
- A **process** is a set of steps to accomplish a task (e.g., the generic SDLC phases).
- A **methodology** is a specific framework for executing those processes (e.g., Waterfall, Agile, Scrum).

**Explanation:** The SDLC process is *what* you do; the methodology is *how* you do it.

---

### Q4. What is the Waterfall model?
**Answer:**  
Waterfall is a **sequential, linear** SDLC model where each phase must be fully completed before the next begins. Phases: Requirements → Design → Implementation → Testing → Deployment → Maintenance.

**Explanation:** It's like building a house — you lay the foundation before the walls, and walls before the roof. Going back is expensive and disruptive.

---

### Q5. What are the advantages and disadvantages of the Waterfall model?
**Answer:**  
**Advantages:** Simple to understand, clear milestones, well-documented, good for stable requirements.  
**Disadvantages:** Inflexible to change, testing happens late, no working software until the end, high risk for complex projects.

**Explanation:** Waterfall works best when you know exactly what you're building from day one. It fails when requirements evolve.

---

### Q6. What is the V-Model?
**Answer:**  
The **V-Model** (Verification and Validation) extends Waterfall by pairing each development phase with a corresponding testing phase. Requirements → System Testing, Design → Integration Testing, Coding → Unit Testing.

**Explanation:** The "V" shape shows that testing is planned alongside development — validation happens at each level, not just at the end.

---

### Q7. What is Agile?
**Answer:**  
Agile is an **iterative, incremental** approach to software development. It values individuals and interactions, working software, customer collaboration, and responding to change. Work is done in short cycles (iterations) delivering working software frequently.

**Explanation:** Instead of delivering one giant release after 12 months, Agile delivers small working increments every 2–4 weeks, incorporating feedback continuously.

---

### Q8. What are the 4 core values of the Agile Manifesto?
**Answer:**
1. **Individuals and interactions** over processes and tools.
2. **Working software** over comprehensive documentation.
3. **Customer collaboration** over contract negotiation.
4. **Responding to change** over following a plan.

**Explanation:** The right side of each value still matters, but the left side is *more* important. Agile doesn't mean no documentation — it means don't let documentation block delivery.

---

### Q9. What is Scrum?
**Answer:**  
Scrum is an Agile framework using **fixed-length iterations called Sprints** (1–4 weeks). It has 3 roles (Product Owner, Scrum Master, Dev Team), 3 artifacts (Product Backlog, Sprint Backlog, Increment), and 4 events (Sprint Planning, Daily Scrum, Sprint Review, Retrospective).

**Explanation:** Scrum gives structure to Agile principles — it defines *who* does *what*, *when*, and *how* to inspect and adapt continuously.

---

### Q10. What is the difference between a Product Backlog and a Sprint Backlog?
**Answer:**  
- **Product Backlog:** Master list of all features, enhancements, and fixes for the entire product, maintained by the Product Owner.
- **Sprint Backlog:** Subset of the Product Backlog selected for a specific Sprint, plus the plan to achieve the Sprint Goal.

**Explanation:** Product Backlog = everything we *could* build. Sprint Backlog = everything we *will* build this Sprint.

---

## Agile & Scrum Deep-Dive

### Q11. What is the role of a Scrum Master?
**Answer:**  
The Scrum Master is a **servant-leader** who facilitates Scrum events, removes impediments (blockers), coaches the team on Scrum practices, and shields the team from external interruptions.

**Explanation:** The Scrum Master is not a project manager. They don't assign tasks — they ensure the team can work effectively by removing obstacles.

---

### Q12. What is a Sprint Retrospective?
**Answer:**  
A Sprint Retrospective is a meeting held at the end of each Sprint where the team inspects their **process** (not the product) and creates a plan for improvement. Teams discuss: What went well? What didn't? What will we improve?

**Explanation:** The retrospective is about *how the team works together*, not about the product. It drives continuous process improvement.

---

### Q13. What is the difference between Scrum and Kanban?
**Answer:**  
Scrum uses **fixed Sprints**, defined roles, and structured ceremonies. Kanban uses **continuous flow** with no Sprints, no mandatory roles, and WIP (Work in Progress) limits as the primary control mechanism.

**Explanation:** Scrum is great for feature development with regular releases; Kanban suits ongoing maintenance or support teams with unpredictable, continuous work.

---

### Q14. What is a Definition of Done (DoD)?
**Answer:**  
A **Definition of Done** is a shared understanding of what "complete" means for a piece of work. It may include: code written, unit tests passing, code reviewed, integrated, documentation updated, deployed to staging.

**Explanation:** DoD prevents misunderstandings about whether work is truly finished. "Done" means everyone agrees it's done — not just coded.

---

### Q15. What is Story Point estimation?
**Answer:**  
Story Points are a **relative unit of measure** for the effort/complexity of user stories. Teams assign points using Fibonacci-like sequences (1, 2, 3, 5, 8, 13…) based on complexity, not hours.

**Explanation:** A 5-point story is roughly twice as complex as a 3-point story. Points measure *effort and uncertainty*, not calendar time, making estimation more reliable.

---

## DevOps & CI/CD

### Q16. What is DevOps?
**Answer:**  
DevOps is a **culture, mindset, and set of practices** that brings Development and Operations teams together to deliver software faster and more reliably. Core principles: Automation, Collaboration, Continuous Improvement, Measurement (CALMS).

**Explanation:** Before DevOps, Dev teams threw code "over the wall" to Ops. DevOps breaks this silo — both teams share responsibility for the entire delivery pipeline.

---

### Q17. What is Continuous Integration (CI)?
**Answer:**  
CI is the practice of **merging code changes frequently** (multiple times per day) into a shared repository. Each merge triggers an automated build and test pipeline to catch integration errors early.

**Explanation:** Without CI, developers work on isolated branches for weeks and then face painful "merge hell." CI keeps everyone in sync and catches bugs while they're still small.

---

### Q18. What is the difference between Continuous Delivery and Continuous Deployment?
**Answer:**  
- **Continuous Delivery:** Every passing build is *ready* to deploy to production, but deployment requires a manual human approval.
- **Continuous Deployment:** Every passing build is *automatically* deployed to production with no human intervention.

**Explanation:** Continuous Delivery = push a button. Continuous Deployment = it ships itself. Most enterprises use Continuous Delivery to maintain a human approval gate for compliance.

---

### Q19. What is Infrastructure as Code (IaC)?
**Answer:**  
IaC is the practice of **managing and provisioning infrastructure** (servers, networks, databases) through code/configuration files rather than manual processes. Tools: Terraform, Ansible, CloudFormation.

**Explanation:** With IaC, you can recreate your entire cloud environment from code in minutes. It makes infrastructure **version-controlled, repeatable, and auditable**.

---

## Testing

### Q20. What is the difference between Unit Testing and Integration Testing?
**Answer:**  
- **Unit Testing:** Tests the **smallest piece of code** (a function or method) in complete isolation using mocks/stubs for dependencies.
- **Integration Testing:** Tests how **multiple components interact** with each other (e.g., service + database, API + external service).

**Explanation:** Unit tests answer "Does this function work?" Integration tests answer "Do these pieces work *together*?"

---

### Q21. What is Regression Testing?
**Answer:**  
Regression testing is **re-running existing tests** after a code change to ensure that previously working functionality has not been broken by the new changes.

**Explanation:** Every bug fix or new feature risks breaking something else. Regression testing is the safety net that catches these unintended side effects.

---

### Q22. What is User Acceptance Testing (UAT)?
**Answer:**  
UAT is the **final phase of testing** where actual end-users or clients test the software to confirm it meets their business requirements before going live.

**Explanation:** UAT answers the business question: "Does this software do what I *asked* for?" It's the last defense before production.

---

### Q23. What is Test-Driven Development (TDD)?
**Answer:**  
TDD is a development approach where **tests are written before the production code**. The cycle is: Red (write failing test) → Green (write minimum code to pass) → Refactor (improve code without breaking tests).

**Explanation:** TDD forces developers to think about requirements and edge cases *before* coding. The result is code that's inherently testable and better designed.

---

### Q24. What is the difference between QA and QC?
**Answer:**  
- **QA (Quality Assurance):** Process-oriented. Focuses on *preventing* defects through process improvements, code reviews, and standards.
- **QC (Quality Control):** Product-oriented. Focuses on *finding* defects through testing the actual software.

**Explanation:** QA is about building the right process. QC is about finding problems in the product. QA prevents; QC detects.

---

## Risk, Estimation & Project Management

### Q25. What is scope creep?
**Answer:**  
Scope creep is the **uncontrolled expansion of project scope** — adding features, requirements, or work beyond what was originally agreed, without adjusting timeline, budget, or resources.

**Explanation:** A project originally scoped for 10 features balloons to 25 features without adjusting the deadline. This leads to missed deadlines and budget overruns. Prevented by strict change control.

---

### Q26. What is the Critical Path in project management?
**Answer:**  
The **Critical Path** is the longest sequence of dependent tasks that determines the **minimum project duration**. Any delay in a critical path task directly delays the project end date.

**Explanation:** If building a house takes 6 months, the critical path might be: Foundation → Frame → Roof → Electrical. Delaying any of these delays the entire project.

---

### Q27. What is the difference between Risk Mitigation and Risk Avoidance?
**Answer:**  
- **Risk Avoidance:** Change the project plan to **eliminate the risk entirely** (e.g., use a proven technology instead of an experimental one).
- **Risk Mitigation:** Reduce the **likelihood or impact** of the risk (e.g., add extra testing for a high-risk module).

**Explanation:** Avoidance removes the risk; mitigation makes it less damaging if it occurs. Both are valid strategies depending on cost and feasibility.

---

### Q28. What is a Burn-Down Chart?
**Answer:**  
A burn-down chart is a **visual representation** of remaining work (Y-axis) versus time (X-axis) in a Sprint. It shows whether the team is on track to complete all Sprint Backlog items by the Sprint end.

**Explanation:** A healthy burn-down shows a steady downward slope toward zero by day 14 of a 2-week Sprint. A flat or rising line signals the team is behind schedule.

---

### Q29. What is MTTR and why does it matter?
**Answer:**  
**MTTR (Mean Time To Recovery)** is the average time it takes to restore a service after a failure. Low MTTR = fast recovery = high system reliability.

**Explanation:** For high-availability systems (e.g., banking, e-commerce), every minute of downtime costs money and trust. MTTR is a key DevOps and SRE metric for measuring operational effectiveness.

---

### Q30. What is the difference between a waterfall and an Agile SDLC approach in terms of handling changing requirements?
**Answer:**  
- **Waterfall:** Requirements are locked upfront. Changes after the design phase are extremely costly and disruptive because all subsequent phases need rework.
- **Agile:** Welcomes changing requirements at any time. The backlog is regularly reprioritized; new requirements can be added to future Sprints without disrupting ongoing work.

**Explanation:** The core tension is *predictability vs. flexibility*. Waterfall offers predictability when requirements are stable; Agile offers flexibility when requirements evolve — which is most real-world projects.

---

*Review all 3 days to solidify these answers before your interview!*
