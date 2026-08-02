# Cost-first routing policy

This is the sole normative source for Teamplay model selection, pool count,
writer independence, shared-surface ownership, and isolation.

## Economic default

Teamplay exists to reduce implementation cost without outsourcing product
authority or final quality judgment. The current main agent spends its existing
context on specification, integration, code review, and acceptance QA; the
default implementation Coder is GPT-5.6 Luna at max reasoning.

```text
DEFAULT_IMPLEMENTATION_CODER = Luna max
```

Task difficulty, breadth, novelty, ambiguity, cross-cutting scope, security
sensitivity, or the words `hard`, `deep`, and `critical` do not by themselves
select Sol. They tell the Lead to strengthen or finish the specification before
delegation. Once the outcome, consequential decisions, ownership, and
acceptance are locked, Luna max may own a large complete implementation slice.

## Current price evidence

Prices are volatile evidence, not routing constants. Official pages checked on
2026-08-03 listed these token rates:

| Surface | Luna input / cached / output | Terra input / cached / output | Ratio |
|---|---:|---:|---:|
| API, USD per 1M tokens | $1 / $0.10 / $6 | $2.50 / $0.25 / $15 | Luna is 1/2.5 |
| Codex, credits per 1M tokens | 25 / 2.5 / 150 | 62.5 / 6.25 / 375 | Luna is 1/2.5 |

Recheck the official model comparison and Codex rate-card pages
before making a current price claim. Fast may consume credits at a higher rate;
it remains an explicit child-local speed choice.

## R0-R3 precedence

1. `R0 authority`: unauthorized, destructive, external-state, login/CAPTCHA,
   user-only, release, purchase, account, or permission work is `BLOCKED`. A
   model change never creates authority.
2. `R1 specification`: the Lead locks a Spec Brief or Full Spec Lock. Product
   outcome, requirements, invariants, authority, consequential decisions, and
   acceptance must be explicit enough for implementation and later review/QA.
3. `R2 cost-first model`: choose Luna max by default. Terra xhigh requires one
   of the two explicit exception records below. Sol children are prohibited.
4. `R3 pool`: choose the smallest safe writer pool after the model decision.

## Delegation-readiness checks

L1-L6 are readiness checks for a mutating Coder, not automatic Terra selectors:

- `L1 requirements_closed`: no unresolved product interpretation can change an
  observable result.
- `L2 acceptance_executable`: requirement-linked checks or objective inspection
  criteria are named before coding.
- `L3 contracts_frozen`: public and cross-slice interfaces are unchanged or
  exact signatures, semantics, compatibility, and ownership are locked.
- `L4 decision_density_zero`: consequential choices have been resolved by the
  Lead; only equivalent local implementation choices remain.
- `L5 ordinary_risk`: no unresolved judgment remains over security-sensitive
  semantics, concurrency/lifecycle, migration/data integrity, non-local
  rollback, or irreversible/external state.
- `L6 bounded_ownership`: writable surfaces and context are bounded, no other
  child's uncommitted work is required, and validation is independent.

If a check fails before delegation, the Lead resolves it, strengthens the spec,
or returns `BLOCKED`; the failure does not select Terra. When all checks pass, use
`teamplay-coder`, or `teamplay-coder-fast` only when Fast was explicitly
selected. File count and perceived difficulty are not model signals.

If a Luna child discovers a false check, it preserves valid work and returns the
exact unresolved decision or blocker to the Lead. The Lead resolves the contract
and normally resumes the same Luna session.

## Terra xhigh exceptions and Sol prohibition

No Teamplay child may use GPT-5.6 Sol at any reasoning effort. This prohibition
applies to implementation, review, QA, Gate, rescue, and every public preset.
The user's already-selected main Lead is not rerouted by Teamplay.

Terra xhigh is the maximum allowed child route and remains an exception, not the
normal response to difficult work. A Terra Coder may be created only when one of
these records exists:

- `T1 explicit_user_terra`: the user directly asks for a Terra implementation
  Coder. Selecting `$teamplay-deep`, `$teamplay-critical`, or describing a task
  as hard is not an explicit Terra request.
- `T2 evidenced_luna_capability_blocker`: Luna has already attempted the same
  locked whole outcome and returned concrete evidence that it cannot complete a
  requirement within the frozen contract. The Lead records the failed
  requirement/check, preserved work, why clarification or same-Luna repair is
  insufficient, and why one Terra attempt is expected to cost less than further
  Luna retries or direct Lead completion.

Silence, slow reasoning, no mutation, a normal review defect, one failed test,
or a vague statement that the task is difficult does not satisfy T2. A stalled
Luna follows `session-continuity.md`: bounded wait, one same-ID redirect, then
Lead takeover. It never auto-routes to Terra or Sol.

When T1 or T2 is valid, use one `teamplay-coder-deep` configured as Terra xhigh
and record the exception in the task capsule and run report. Terra does not expand
authority or take specification, integration, final review, QA, or completion
ownership from the Lead. After the exception outcome is locked or completed,
subsequent mechanical outcomes return to Luna max.

## Writer pool

- One mutating Coder is the default.
- Auto may select two only for independent complete outcomes with frozen
  contracts, disjoint paths, no shared generated output/manifest/lockfile, no
  dependency on another child's uncommitted work, and independent checks.
- Three requires explicit user request and the same proof plus disjoint ownership
  or isolated worktrees.
- Never run more than three mutating Coders in one wave.
- Every shared mutable surface has exactly one Coder owner or belongs to the
  Lead's serial integration step.

A predetermined one-owner change may touch a manifest, lockfile, schema, or
generated artifact without becoming parallel or Full Lock work. The risk comes
from coordination and unresolved decisions, not filenames.
