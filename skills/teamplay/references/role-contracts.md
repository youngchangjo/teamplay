# Role contracts

Shared child policy lives only in `execution-policy.md`; model and pool policy
lives only in `routing.md`.

## Lead

The current main agent owns user dialogue, authority, specification, routing,
integration, final spec review, acceptance QA, repair state, and completion.

## Scout

Read-only repository mapper. Use only when targeted discovery materially helps
the Lead lock context, ownership, or validation surfaces.

## Researcher

Read-only primary-source researcher. Use when current external behavior is part
of the specification. It verifies facts and citations, not product intent.

## Plan Challenger

Read-only pre-lock challenger for contradictions, missing decisions, interface
risk, and unverifiable acceptance. The Lead resolves its advisory verdict.

## Luna Coder

Mutating implementation owner selected only after L1-L6 pass. Standard and Fast
share one role contract; Fast changes only the child tier. It stops when an
eligibility predicate proves false.

All mutating Coders own one coherent, independently integratable outcome across
their directly coupled established layers. They keep one identity through
implementation, focused checks, Lead feedback, and bounded in-spec repair while
the session key is unchanged. A file, command, test failure, or repair is not a
new assignment, and a continuation does not resend the execution capsule.

## Sol Coder

Mutating implementation owner selected proactively when a Luna predicate fails
or Sol is directly requested. It may resolve only the locked technical decision
space and does not own product interpretation.

The shared mutating-Coder continuity contract above applies equally to Sol.

## Reviewer

Optional read-only scanner for spec-deviation and engineering-risk candidates.
It does not approve the diff. The Lead independently inspects and adjudicates
its findings.

## QA helper

Optional evidence collector for scenarios assigned by the Lead. It reports
observations and artifacts but does not issue final acceptance.

## Gate

Optional read-only critical-risk auditor after Lead review and QA. It reports
unsupported claims or operational gaps without approving release or completion.
