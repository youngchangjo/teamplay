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

Default mutating implementation owner selected after L1-L6 readiness passes.
Standard and Fast share one role contract; Fast changes only the child tier. It
stops when a readiness check proves false.

All mutating Coders own one coherent, independently integratable outcome across
their directly coupled established layers. They keep one identity through
implementation, focused checks, Lead feedback, and bounded in-spec repair while
the session key is unchanged. A file, command, test failure, or repair is not a
new assignment, and a continuation does not resend the execution capsule.

## Terra exception Coder

Maximum-strength Teamplay child, fixed at Terra xhigh. It is selected only when
the user directly requests Terra or a prior Luna attempt provides the concrete
capability-blocker evidence required by routing.md. Difficulty and a failed
readiness check are not enough. It does not own product interpretation.

The shared mutating-Coder continuity contract above applies equally to Terra.
No Teamplay role may select Sol at any effort.

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
