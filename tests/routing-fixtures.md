# Teamplay routing fixtures

Each fixture is classified by the Lead before any child runs. Route, spec level,
and pool must match exactly.

## DR-01 — Exact documentation correction

Prompt: Apply supplied exact copy to one document and run its existing lint.
Expected: Luna max Standard; Spec Brief; one writer.

## DR-02 — Broad mechanical propagation

Prompt: Propagate a fully locked API signature across 30 named files with fixed
compatibility behavior and existing compile/tests.
Expected: Luna max Standard; Spec Brief; one writer. File count does not select
Terra, and Sol is prohibited.

## DR-03 — Established UI pattern

Prompt: Implement a complete UI outcome using named existing components, fixed
fixtures, frozen navigation, and screenshot criteria.
Expected: Luna max Standard; Spec Brief; one writer.

## DR-04 — Two disjoint adapters

Prompt: Implement two independent adapters in disjoint directories with no
shared manifest, generated output, contract, or integration dependency.
Expected: two Luna max Coders; Full Spec Lock; two writers.

## DR-05 — Explicit isolated three

Prompt: User explicitly requests three independent generators in isolated
worktrees; each has its own checks and no shared output.
Expected: three Luna max Coders; Full Spec Lock; never a fourth writer.

## DR-06 — One owner for shared lockfile

Prompt: Apply two predetermined dependency pins that share one root lockfile;
one Coder owns the complete install and test result.
Expected: Luna max Standard; Spec Brief; one writer.

## DR-07 — New authentication design

Prompt: Choose among materially different session, permission, and ownership
designs inside a locked product outcome.
Expected: no Coder until the Lead chooses and locks the design; then Luna max,
Full Spec Lock, one writer. Difficulty does not select Terra or Sol.

## DR-08 — Lifecycle race

Prompt: Fix a race spanning cancellation, retry, persistence, and lifecycle
ownership while preserving named observable behavior.
Expected: Lead locks lifecycle invariants and acceptance; then Luna max, Full
Spec Lock, one writer.

## DR-09 — Persistent migration

Prompt: Implement a schema migration with backward compatibility, integrity,
rollback, and recovery decisions.
Expected: Lead locks migration, rollback, and recovery decisions; then Luna max,
Full Spec Lock, one writer.

## DR-10 — Bounded ambiguous defect

Prompt: Diagnose a known observable failure inside one component where the root
cause is unknown but public behavior and ownership are frozen.
Expected: Luna max; Spec Brief; one writer. Ambiguous diagnosis alone does not
select Terra or Sol.

## DR-11 — Fast child only

Prompt: `$teamplay-fast` for a clear mechanical change whose L1-L6 all pass.
Expected: Luna max Fast child; Spec Brief; one writer; Lead unchanged.

## DR-12 — Complete rendered context

Prompt: Render each production fixture through the canonical renderer.
Expected: one exact capsule block; source hash match; no Coder-TOML copy.

## DR-13 — Two bounded repairs

Prompt: Lead review and later Lead QA each find an in-spec defect on different
requirements.
Expected: original model route; shared REPAIR_1 and REPAIR_2; re-review and QA.

## DR-14 — Replan boundary

Prompt: The same requirement fails twice, a frozen interface changes, or a
third repair would be required.
Expected: REPLAN or BLOCKED; no automatic third repair.

## DR-15 — Explicit Terra exception

Prompt: User explicitly requests one Terra implementation Coder for a locked
outcome and accepts the higher cost.
Expected: Terra xhigh; T1 recorded; one writer; no Sol child.

## DR-16 — Evidenced post-Luna capability blocker

Prompt: Luna attempted the locked whole outcome and returned a concrete failed
requirement/check plus valid partial work. The Lead records why clarification,
same-Luna repair, and direct takeover are less economical than one Terra retry.
Expected: Terra xhigh; T2 evidence recorded; same whole outcome; one writer; no
Sol child. A stall or vague difficulty report would not pass.

## DR-17 — Lead-owned critical Gate

Prompt: A critical Luna implementation has passed Lead specification review and
acceptance QA. Decide whether requirement coverage, residual risk, rollback,
external state, and evidence support completion.
Expected: the current main Lead performs the final Gate directly; no Gate child
is created; verdict is COMPLETE, repair, REPLAN, or BLOCKED.

## DR-18 — Ninety-percent Luna floor, zero Terra budget

Prompt: A normal run contains several specification-locked implementation
outcomes and none has T1 or T2 evidence.
Expected: 100% of this run's implementation outcomes use Luna max. The broader
90% Luna figure is only a lower-bound audit alarm. Terra has zero allocation
budget; do not create Terra to fill 10%, balance models, or claim cumulative
floor compliance without meaningful observed history.

## Live canaries

- `LC-STD`: DR-01 through Standard Luna max.
- `LC-FAST`: DR-11 through Fast Luna max with the Lead unchanged.
- `LC-TERRA`: DR-15 through Terra xhigh with T1 evidence.
- `LC-NO-SOL`: inspect every installed Teamplay role and reject any Sol model.
- `LC-NO-GATE`: inspect bundle and installation and reject a `teamplay-gate`
  child role.

Runtime identity must come from host, CLI, or agent-registry metadata. When that
surface is unavailable, record `NOT_PROVEN`; a child echo is not proof.
