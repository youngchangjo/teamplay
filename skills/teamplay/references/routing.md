# Routing policy

This is the sole normative source for Teamplay model eligibility, pool count,
writer independence, shared-surface ownership, and isolation.

## R0-R3 precedence

1. `R0 authority`: out-of-authority, destructive, external-state, login/CAPTCHA,
   user-only, release, purchase, account, or permission work is `BLOCKED`. Sol is
   not a fallback for unauthorized work.
2. `R1 specification`: the Lead locks a Spec Brief or Full Spec Lock. Product
   outcome, requirements, invariants, authority, and delegated technical decision
   space must be explicit. Unresolved user-authority items must be empty.
3. `R2 model`: within authority and with a ready spec, select Luna max or Sol max.
4. `R3 pool`: select the smallest safe writer pool after model selection.

## Consequential decision

A consequential decision is a choice whose alternatives can materially change:

- user-visible or externally observable behavior;
- a public, cross-component, or cross-slice interface;
- persistence, schema, protocol, compatibility, migration, or recovery;
- security, privacy, authentication, authorization, permissions, payments, or
  cryptographic semantics;
- concurrency, ordering, lifecycle ownership, cancellation, retry, or state;
- external effects, deployment, rollback, release, or component ownership.

Private naming, helper extraction, equivalent local organization, fixtures, and
other observationally equivalent choices are not consequential.

## Luna max eligibility

Route to Luna max only when every predicate passes:

- `L1 requirements_closed`: no unresolved product interpretation can change an
  observable result.
- `L2 acceptance_executable`: requirement-linked checks or objective inspection
  criteria are named before coding.
- `L3 contracts_frozen`: public and cross-slice interfaces are unchanged or
  exact signatures, semantics, compatibility, and ownership are locked.
- `L4 decision_density_zero`: no consequential implementation decision remains;
  a repository precedent is named or only equivalent local choices remain.
- `L5 ordinary_risk`: no judgment remains over security-sensitive semantics,
  concurrency/lifecycle, migration/data integrity, non-local rollback, or
  irreversible/external state.
- `L6 bounded_ownership`: writable surfaces and context are bounded, no other
  child's uncommitted work is required, and validation is independent.

When all pass and Sol was not directly requested, use `teamplay-coder`. Use
`teamplay-coder-fast` only when Fast is selected. File breadth is not a routing
signal. Record L1-L6 in the task capsule.

If a Luna child discovers a false predicate, it stops with that predicate, the
consequential decision, current changes, and still-valid evidence.

## Sol max eligibility

Route to `teamplay-coder-deep` before mutation when any L1-L6 predicate fails or
the user directly requests Sol, provided R0 and R1 pass. Do not run Luna first
merely to justify Sol.

Direct Sol signals include unresolved technical architecture, novel
cross-cutting behavior, consequential public contracts, security/privacy/auth/
payment/permission judgment, concurrency or lifecycle correctness, migration or
data integrity, compatibility/rollback/recovery, consequential performance or
reliability trade-offs, and ambiguous cross-component defects.

Default to one mutating Sol Coder. Sol never expands authority or takes final
spec, review, QA, integration, or completion ownership from the Lead. After the
Lead locks a Sol-resolved contract, independent mechanical follow-on work may
return to Luna.

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
from coordination and consequential decisions, not filenames.
