# Routing

## Public entry points

| Skill | Requested preset | Contract |
|---|---|---|
| `$teamplay` | `auto` | Select the smallest useful roster |
| `$teamplay-fast` | `fast` | Prefer Fast Coder; escalate at higher-risk boundaries |
| `$teamplay-deep` | `deep` | Favor discovery, challenge, focused review, and faithful QA |
| `$teamplay-critical` | `critical` | Require Deep Coder, review, QA, and Gate for mutations |

Shortcut skills must load the core Teamplay skill. They do not duplicate the
orchestration workflow.

In every route, `Lead` means the current main conversation agent. Teamplay never
spawns a Lead subagent.

## Decision table

| Signal | Add role | Reason |
|---|---|---|
| Relevant files or symbols are unknown | Scout | Establish a precise change surface |
| Current docs, standards, upstream source, or version behavior matters | Researcher | Verify external facts with primary sources |
| Requirements have competing interpretations | Plan Challenger | Expose the decision before mutation |
| Several layers or interfaces will change | Plan Challenger | Test the slice and interface boundaries |
| Small, clear, low-risk change in existing patterns | Fast Coder | Minimize latency and cost without broadening scope |
| Normal product feature across established layers | Standard Coder | Balance implementation quality, speed, and cost |
| Cross-cutting, security, concurrency, data, or migration work | Deep Coder | Use frontier reasoning for expensive failure modes |
| Meaningful code changed | Reviewer | Inspect the actual diff independently |
| Tests, build, runtime, UI, or device surface exists | QA | Verify observable behavior |
| Security, privacy, auth, payment, or data integrity risk | Gate | Re-audit completion evidence |
| Migration, deployment, release, deletion, or irreversible action | Gate | Prevent evidence layers from being conflated |

## Common routes

### Read-only explanation

Lead only. Add Scout for repository discovery, Researcher for current external
facts, or Plan Challenger when the user wants an independent critique.

### One-spot change

Lead -> Fast Coder -> Reviewer. Add QA if a relevant test or runtime scenario
exists.

### Normal feature

Scout or Researcher when needed -> Lead -> Standard Coder -> Reviewer -> QA.

### Ambiguous or cross-cutting feature

Scout and/or Researcher -> Lead -> Plan Challenger -> Standard or Deep Coder ->
Reviewer -> QA.

### High-risk change

Scout and/or Researcher -> Lead -> Plan Challenger -> Deep Coder -> focused
Reviewer lane(s) -> QA -> Gate.

## Parallelism

Safe parallel work:

- independent discovery questions;
- external research and local code discovery;
- at most three independent read-only discovery, research, triage, or review
  assignments;
- coders with explicit, disjoint owned paths or isolated worktrees;
- preparation of QA scenarios while implementation proceeds, provided QA does
  not claim execution until the target state is stable.

Keep sequential:

- challenge before plan approval;
- implementation before diff review;
- repairs before focused re-review;
- stable implementation before runtime QA;
- review and QA before final gate.

Concurrency limits:

- no more than four active child threads by default;
- no more than three concurrent read-only children;
- one writer by default;
- never parallelize overlapping write ownership in a shared worktree.

Waiting policy:

- wait on mailbox updates instead of repeatedly reading full child transcripts;
- back off bounded waits when state is unchanged;
- do not declare a running child failed because one wait timed out;
- interrupt only for a real scope change, unsafe behavior, or explicit user
  override.

## Stop conditions

Stop delegation and ask the user when:

- two plausible interpretations would produce materially different products;
- the requested action needs credentials, purchasing, publication, or account
  authority not already provided;
- a destructive target is not exact;
- overlapping worktree changes cannot be safely separated;
- a required physical or external verification surface is unavailable and the
  user asked for that exact finish line.
