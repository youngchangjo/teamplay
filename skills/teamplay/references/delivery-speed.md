# Delivery speed contract

Teamplay optimizes for the shortest reliable path to a complete user-visible or
integratable outcome. More agents, smaller tasks, and more checkpoints are not
automatically better.

## Slice sizing

Assign one Coder a coherent vertical slice:

- a complete small fix including directly related tests, snapshots, docs, and
  configuration;
- a complete standard feature across UI, domain, data, integration, and tests
  where those layers are genuinely required;
- a complete deep goal across modules, invariants, migration, or concurrency
  boundaries defined by the approved plan.

Do not split work by file count, directory, framework layer, or arbitrary token
budget. Split only when outcomes are independently deliverable, ownership would
otherwise conflict, an isolated worktree enables safe parallelism, or a material
decision blocks the next slice.

Every implementation slice must end in an integratable state with its focused
tests and directly required supporting changes. Scaffolding alone is not a
completed slice unless scaffolding itself is the requested outcome.

## Coder autonomy

Within the approved outcome and constraints, the Coder may:

- inspect and edit every directly necessary path;
- follow established repository patterns without asking about routine details;
- make reversible, low-risk implementation assumptions and report them;
- run targeted checks during development and one batched completion check;
- finish tests, snapshots, docs, and configuration required by the outcome.

The Coder escalates only when a decision materially changes product behavior,
public interfaces, data ownership, security, irreversible effects, user-granted
authority, or the approved outcome.

## Fewer handoffs

- Skip Scout when the Coder can locate the implementation inside a known area.
- Run Scout and Researcher in parallel when both are truly needed.
- Skip Plan Challenger for clear, ordinary-risk work using established patterns.
- Review the stable completed slice, not each file or intermediate commit.
- Batch reviewer findings into one repair packet and use one focused re-review.
- Run dedicated QA only at the major gates in `qa-surfaces.md`.
- Do not poll active agents aggressively or request progress prose that does not
  change the next decision.

## Parallel implementation

Default to one writer in a shared worktree. Use multiple Coders only for
independently deliverable vertical slices with disjoint ownership or isolated
worktrees. Parallelism that creates merge or coordination work is not a speedup.

## Speed without weakened evidence

Faster delivery does not authorize skipping required review, safety boundaries,
or final evidence. It changes when work is grouped and when gates run:

```text
coherent implementation slice
→ one independent review
→ one batched repair if needed
→ focused re-review
→ one major QA gate
→ optional high-risk Gate
```
