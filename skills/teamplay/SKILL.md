---
name: teamplay
description: Save implementation cost by defaulting specification-locked coding to GPT-5.6 Luna max while the current main Codex agent retains specification, integration, final review, acceptance QA, and final Gate judgment. Teamplay never selects Sol; Terra xhigh is the maximum child route and explicit or evidenced post-Luna exception only. Use when the user invokes Teamplay, asks for cost-efficient Luna implementation, requests optional Fast children, or wants bounded parallel implementation.
version: 0.12.1
---

# Teamplay

Teamplay is cost-first: the current main agent is always Lead and the default
implementation Coder is Luna max. The Lead spends its existing context on the
specification, integration, final review, acceptance QA, and final Gate judgment;
Luna supplies lower-cost implementation throughput. Teamplay never creates a
Sol child. Terra xhigh is the maximum child route and is used only by explicit
user choice or an evidenced post-Luna capability exception.

## Read before routing

Always read:

- `references/execution-policy.md`
- `references/session-continuity.md` before assigning or continuing a
  mutating Coder;
- `references/spec-contract.md`
- `references/routing.md`

Read only when the stage needs them:

- `references/role-contracts.md` before selecting optional roles;
- `references/delivery-speed.md` for Fast, waves, early checks, or repair;
- `references/evidence-contract.md` before judging completion evidence;
- `references/qa-surfaces.md` before acceptance QA;
- `references/reporting.md` when closing the run.

Use `templates/spec-brief.md` for one bounded ordinary outcome and
`templates/spec-contract.md` for a Full Spec Lock. Use
`templates/continuation-packet.md`, `templates/lead-review.md`,
`templates/qa-packet.md`, and
`templates/final-report.md` at their named Lead stages.

## Fixed authority

- The current main conversation agent is Lead; never spawn another Lead.
- Keep the Lead's selected model, reasoning effort, and service tier unchanged.
- The Lead owns specification interpretation, route choice, integration, final
  code review, acceptance QA, final Gate judgment, conflict resolution, and
  completion verdict.
- The Lead may directly take over a stalled Coder's unchanged whole outcome
  after the lifecycle contract's wait and same-session redirect.
- Child Reviewer and QA roles are advisory only. There is no Gate child; the
  current main Lead performs the final Gate directly.
- Every Luna child uses max reasoning. Fast changes only the selected Luna
  child's service tier.
- Luna max is the default mutating Coder. Difficulty, ambiguity, criticality,
  and file count do not select an initial Sol Coder.
- Luna max has a 90% lower-bound audit floor, not a quota. Terra has zero
  allocation budget and no target share; it requires T1 or T2 for each outcome.
  Without T1 or T2, the current run is 100% Luna. Never create Terra to fill 10%.
- Sol is prohibited for every Teamplay child. Terra xhigh requires
  `T1 explicit_user_terra` or `T2 evidenced_luna_capability_blocker` from
  `references/routing.md`.

The Lead owns review, QA, and Gate because it alone retains the canonical user
conversation and locked specification, sees the integrated cross-outcome diff,
controls faithful QA surfaces and evidence-layer separation, and holds final
authority. A Coder's checks support review but cannot approve its own work. If
the Lead writes code after takeover, it reopens the pre-existing specification
checklist and keeps implementation, review, QA, and Gate as separate phases.

## Workflow

### 1. Establish the baseline

Read repository instructions and `CHANGELOG.md`, inspect branch/worktree state,
canonical product documents, relevant code, and available validation surfaces.
Preserve unrelated and user-owned changes. State the requested outcome and
observable success criteria.

### 2. Apply routing precedence

Use the exact R0-R3 order in `references/routing.md`:

1. authority;
2. specification readiness;
3. model;
4. writer pool.

Do not use a stronger model to bypass missing authority, an unresolved decision, or an
unfinished specification. A failed readiness check returns to the Lead; it does
not select Terra, and Sol is never available.

### 3. Lock the appropriate written specification

The Lead creates or confirms exactly one canonical Spec Brief or Full Spec Lock
before mutation. Record a stable spec revision and repository baseline.

The specification must be sufficient for the Lead to review each requirement
against the actual diff and execute requirement-linked QA. It locks decisions,
not keystrokes. Resolve material product ambiguity before delegation.

Hard, novel, cross-cutting, security-sensitive, concurrent, or migration work
may require a Full Spec Lock, but difficulty does not change the default Coder.
The Lead resolves consequential choices first, then delegates the locked whole
implementation outcome to Luna max.

### 4. Keep one Coder session for one outcome

Apply the lifecycle contract before spawning or continuing a Coder. Define one
independently integratable outcome, derive its stable session key from the spec
ID/revision, outcome ID, route, and owned surfaces, and keep one Coder identity
through implementation, directly coupled checks, Lead feedback, and bounded
in-spec repairs. A file, layer, exact code fragment, command, checklist item,
test failure, or repair is not a new outcome.

The initial assignment gets exactly one rendered execution capsule. For an
unchanged session key, use message/reuse or resume with the compact,
capsule-free continuation packet. Use redirect once for bounded non-progress.
A same session key keeps the prior Coder identity; it does not create a new
assignment for a focused check or repair.
Closing a completed child to release a concurrency slot is resource management,
not a restart boundary. Retain its agent ID and resume it if Lead review or QA
produces an in-spec repair.
Persistent non-progress after the redirect is a Lead takeover boundary, not a
replacement-Coder or micro-packet boundary. Create a fresh Coder only at a
documented restart boundary unrelated to a mid-outcome stall; record all spawn,
wait, message/reuse, resume, redirect, restart, takeover, and close events.

### 5. Select model and pool

Apply the cost-first rule and delegation-readiness checks in
`references/routing.md` without restating them. Luna is max in both Standard and
Fast roles and is the default initial implementation Coder. Never infer Terra from
task difficulty, scope, ambiguity, criticality, or the selected preset.

Never create a Sol child. Use Terra xhigh only for recorded
`T1 explicit_user_terra` or `T2 evidenced_luna_capability_blocker`. T2 requires
a real prior Luna attempt on the same locked whole outcome and concrete
requirement/check evidence. A stall is not T2 and continues to Lead takeover.

Use the smallest safe writer pool. Announce that Luna max is the economic
default, the selected model, any Terra exception and evidence, spec level, pool,
isolation, complete owned outcomes, and the Lead's final review/QA surface.

### 6. Render and delegate

Create one task capsule from `templates/task-packet.md`. Materialize the exact
canonical execution capsule with:

```bash
python3 skills/teamplay/scripts/render-task-packet.py \
  --policy skills/teamplay/references/execution-policy.md \
  --task <task-capsule.md>
```

Send the complete rendered stdout as the child assignment. A path-only policy
reference or manually copied capsule is invalid. Record the renderer's canonical
capsule hash and task hash in the run report.

Each mutating Coder receives one independently integratable outcome. A Luna
Coder that discovers a failed eligibility predicate returns the failed predicate
and preserves still-valid work instead of redesigning the product.

The task capsule is initial-assignment data. A same-session continuation uses
templates/continuation-packet.md and does not resend the execution capsule or
the full initial task.

### 7. Recover a stalled Coder without fragmenting the outcome

For silence or no evidenced mutation, first wait one bounded window tied to a
named expected checkpoint. At the boundary, inspect the actual repository diff
and latest host-observed agent state. Do not repeatedly poll, spawn a duplicate,
or infer failure from long reasoning alone.

If no usable progress exists, redirect the same agent ID once with the compact
continuation packet. Request progress toward the original whole outcome or an
explicit blocker by the next named boundary. An observable mutation checkpoint
is allowed; component, file, command, and exact-edit packets are not.

If the redirect also yields no usable progress or blocker, record
`CODER_STALLED`, stop the child's mutation authority, and let the current main
Lead directly finish the same locked whole outcome. Preserve valid partial work
and prevent a late child response from mutating concurrently. Before editing,
the Lead reopens the canonical specification and records the applicable
requirement and acceptance checklist. Lead takeover does not consume a repair
slot and does not waive later spec review or QA. If safe completion is not
possible under the locked contract, use `REPLAN` or `BLOCKED`.

### 8. Integrate and review personally

After a stable implementation result, the Lead inspects the actual changed-file
inventory and diff:

1. spec-conformance pass requirement by requirement;
2. engineering-integrity pass for correctness, regression, security, privacy,
   concurrency, compatibility, maintainability, and meaningful tests.

Separate required defects from optional improvements. Advisory findings are
inputs only; the Lead adjudicates them against the canonical specification.

### 9. Repair within the bounded state

Use `references/delivery-speed.md`. Lead review and Lead QA share one maximum of
two repair slots. One repair is the expected path. Replan when the same
requirement fails twice, a frozen boundary changes, or another repair would
exceed the shared budget.

### 10. Execute acceptance QA personally

Use `references/qa-surfaces.md`. The Lead executes or directly observes decisive
requirement-linked scenarios on the most faithful available surface. Keep
static, build, browser, Simulator, installed-app, physical-device, external,
deployment, and release evidence separate. A child may prepare evidence but
cannot issue the final QA verdict.

### 11. Perform the final Gate personally

After review and acceptance QA, the current main Lead checks complete
requirement coverage, evidence-layer sufficiency, residual risk, rollback and
recovery boundaries, external-state claims, and remaining authority limits.
Issue `COMPLETE`, a bounded repair, `REPLAN`, or `BLOCKED`. Do not spawn a Gate
child or treat an advisory verdict as this decision.

### 12. Close honestly

Use `references/reporting.md` and `templates/final-report.md`. Report the spec
revision, route, pool, implementation results, Lead review, Lead QA, advisory
findings, evidence limits, external/release state, and remaining authority
boundaries. Include lifecycle event counts and host token diagnostics with
cached, uncached, output, and reasoning values separated; never turn counters
into a billing claim. End every invocation with a Teamplay Run Report.

## Public presets

- `$teamplay`: cost-first route; Luna max Standard is the initial implementation
  default after the Lead locks readiness.
- `$teamplay-fast`: the same Luna-first route, with Fast applied only to eligible
  Luna children. It never makes Terra automatic.
- `$teamplay-deep`: require richer invariants and evidence while keeping Luna
  max as the default Coder. The word deep is not a T1 Terra request.
- `$teamplay-critical`: require threat, rollback, and evidence boundaries; add
  Lead-owned critical Gate checks after review and QA. Criticality is not a T1
  Terra request and the Lead remains final authority.

Natural-language controls may request a pool size, Fast, or Terra, but cannot
override authority, specification readiness, safe isolation, or final Lead
review and QA. A Sol child request is rejected by the fixed routing prohibition.
