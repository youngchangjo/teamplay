# Specification levels

The current main Lead owns canonical product interpretation. Every mutating
Teamplay run has one written, revision-identified Spec Brief or Full Spec Lock.

## Spec Brief

Use `templates/spec-brief.md` for one bounded outcome when no Full Spec Lock
trigger applies. It records:

- identity, baseline, route, and L1-L6 results or Sol signal;
- outcome and stable requirement anchors;
- writable ownership and non-goals;
- canonical local context and resolved assumptions;
- observable acceptance and evidence;
- frozen contracts and invariants;
- allowed local judgment and escalation;
- exact validation.

Every Brief names one coherent independently integratable outcome and its
session key inputs: spec ID/revision, outcome ID, route, and owned surfaces.
The Brief may allow one Coder to span directly coupled code, checks, fixtures,
docs, and configuration. A file or check is not an outcome by itself.

A Brief intentionally omits a requirement matrix, dependency graph, risk
register, per-file recipe, and prescribed implementation sequence.

## Full Spec Lock

Use `templates/spec-contract.md` when any of these apply:

- two or more mutating Coders or any parallel writer;
- ordered cross-owner integration;
- a contract, schema, manifest, lockfile, generated artifact, shared surface, or
  ownership boundary creates coordination, compatibility, integrity, ordering,
  or shared-owner risk;
- unresolved or novel cross-cutting architecture;
- security-sensitive semantics, concurrency/lifecycle, migration, data
  integrity, compatibility, recovery, or non-local rollback;
- coordinated multi-environment acceptance;
- authorized external, deployment, release, destructive, account, or permission
  work;
- direct user request.

Merely touching a named artifact does not trigger Full Lock when one Coder owns
the predetermined bounded result, no consequential decision remains, and
validation is independent.

Full Lock adds a decision log, requirement matrix, frozen cross-slice contracts,
dependency/integration order, shared ownership, rollback/recovery, evidence
invalidation, and cross-slice Lead review/QA plan.

## Readiness and change control

- Unresolved user-authority items must be empty before mutation.
- Coders may resolve only the local judgment explicitly allowed by the spec.
- A product, authority, frozen-contract, or ownership change returns to the Lead.
- When canonical intent changes, increment the spec revision and invalidate
  affected implementation and evidence before resuming.
- Sol may resolve only the technical decision space the Lead explicitly delegates;
  product behavior and final interpretation remain with the Lead.

The Lead reviews the actual diff against requirement anchors and executes the
acceptance scenarios described in the applicable template. A child summary does
not change the specification or establish conformance.
