# PRD to Plan

Break a PRD into a structured plan file with staged vertical slices (tracer bullets).

## Process

### 1. Locate the PRD

Ask the user for the PRD (GitHub issue number/URL, file path, or pasted content).

If the PRD is a GitHub issue and not already in your context window, fetch it with `gh issue view <number>` (with comments).

### 2. Explore the codebase (optional)

If you have not already explored the codebase, do so to understand the current state of the code.

### 3. Draft vertical slices

Break the PRD into **tracer bullet** slices grouped into sequential **stages**. Each slice is a thin vertical cut through ALL integration layers end-to-end, NOT a horizontal slice of one layer.

Slices may be 'HITL' or 'AFK'. HITL slices require human interaction, such as an architectural decision or a design review. AFK slices can be implemented and merged without human interaction. Prefer AFK over HITL where possible.

<vertical-slice-rules>
- Each slice delivers a narrow but COMPLETE path through every layer (schema, API, UI, tests)
- A completed slice is demoable or verifiable on its own
- Prefer many thin slices over few thick ones
</vertical-slice-rules>

Group slices into **stages**. A stage is a set of slices that can be worked on in parallel (no intra-stage dependencies). Stages are ordered: all slices in stage N must complete before stage N+1 begins.

Always create a final stage containing a single QA slice with a detailed manual QA plan for all items that require human verification. This QA slice should be HITL.

### 4. Quiz the user

Present the proposed breakdown as a staged list. For each stage, show:

- **Stage number and name**
- For each slice in the stage:
  - **Title**: short descriptive name
  - **Type**: HITL / AFK
  - **User stories covered**: which user stories from the PRD this addresses

Ask the user:

- Does the granularity feel right? (too coarse / too fine)
- Are the stage groupings correct? (could any slices move earlier or later?)
- Should any slices be merged or split further?
- Are the correct slices marked as HITL and AFK?

Iterate until the user approves the breakdown.

### 5. Write the plan file

Once the user approves, write a plan file using the template below. Place it at a sensible location — prefer the project root (e.g., `PLAN.md`) or ask the user where they want it.

<plan-template>
# Plan: <plan title>

> Source PRD: <link or reference to the PRD>

## Stage 1: <stage name>

*All slices in this stage can be worked on in parallel.*

### 1.1 — <slice title> [AFK]

**What to build**

A concise description of this vertical slice. Describe the end-to-end behavior, not layer-by-layer implementation. Reference specific sections of the PRD rather than duplicating content.

**Acceptance criteria**

- [ ] Criterion 1
- [ ] Criterion 2
- [ ] Criterion 3

**User stories addressed**

- User story 3
- User story 7

---

### 1.2 — <slice title> [HITL]

...

---

## Stage 2: <stage name>

*Depends on: Stage 1*

### 2.1 — <slice title> [AFK]

...

---

## Stage N: QA & Verification [HITL]

*Depends on: all previous stages*

### N.1 — Manual QA

**QA plan**

- [ ] Verify ...
- [ ] Verify ...

</plan-template>

Do NOT close or modify the parent PRD issue (if one exists).
