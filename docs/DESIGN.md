# Teamplay 0.12 design rationale

Teamplay is a cost-first manager pattern. The current main agent keeps product
authority, specification, integration, final diff review, acceptance QA, and
completion. Luna max owns implementation by default.

## Economic premise

The main conversation already carries product context and remains responsible
for quality. Creating another frontier child for implementation duplicates
expensive judgment context. Teamplay instead uses the main Lead to close
decisions and a lower-cost Luna max child to produce the locked result.

Official pages checked on 2026-08-03 showed Luna at 20% and Terra at 50% of Sol
for every API and Codex input/cached/output category. Prices are volatile
evidence rather than routing constants, but this cost relationship is the reason
Luna is the default.

Max reasoning is retained. The economy comes from model selection, broad
outcome ownership, session reuse, and avoiding duplicate agents—not from
weakening reasoning or final evidence.

The 90% Luna figure is a lower-bound audit alarm, not a target mix. Terra has
zero allocation budget and no reserved percentage; each Terra outcome requires
its own T1 or T2 authorization. Without a valid exception, a run routes every
implementation outcome to Luna. Falling below the floor triggers an audit of
overly broad exceptions, never an attempt to fill a Terra percentage.

For equal token volumes, all-Luna child implementation is estimated at 80%
lower token cost than all-Sol, while Terra is 50% lower. Illustrative Luna/Terra
token mixes yield 77-80% child savings, but Terra keeps zero allocation budget.
Whole-workflow savings are lower because the main Lead's specification, review,
QA, and Gate cost remains unchanged. These are estimates, not billing claims.

## No Sol children

Teamplay 0.12 prohibits GPT-5.6 Sol for every child role and preset. The highest
child configuration is Terra xhigh. This applies to Coder, Reviewer, QA, and
rescue paths. Final Gate is a phase performed by the current main Lead, not a
child role. Teamplay does not alter the user's already-selected main Lead.

The prohibition removes an easy failure mode: broad words such as “difficult,”
“deep,” “critical,” or “ambiguous” can no longer produce an expensive initial
Sol Coder.

## Luna-first routing

The route is:

```text
R0 authority
-> R1 Lead locks specification and consequential decisions
-> R2 Luna max by default
-> R3 smallest safe writer pool
```

L1-L6 are delegation-readiness checks, not stronger-model selectors. A failed
check sends work back to the Lead to resolve, specify, or block. Once the
observable behavior, interfaces, lifecycle, ownership, risk decisions, and
acceptance are locked, Luna can implement a large cross-layer outcome.

Task size and file count are not model signals. One coherent Luna outcome may
include every directly coupled implementation, test, fixture, document, and
configuration surface.

## Terra xhigh exception

Terra xhigh is allowed only for:

- `T1`: a direct user request for a Terra implementation child;
- `T2`: concrete evidence from a real Luna attempt that the same locked whole
  outcome exceeds Luna's capability and that another Luna repair or Lead
  takeover is less economical.

Difficulty is not T1. A failed readiness check, silence, slow reasoning, no
mutation, one failed test, or a normal review defect is not T2. Stalled Luna
work follows the lifecycle recovery path and transfers to the Lead rather than
escalating models.

## Specification before delegation

A Spec Brief supplies requirement anchors, frozen behavior, ownership,
acceptance, and validation for one bounded outcome. A Full Spec Lock adds
decision records, cross-slice contracts, rollback, and coordinated evidence when
the work shape requires them.

Hard work generally changes specification depth, not model choice. The Lead
resolves consequential architecture, security, concurrency, migration, and
lifecycle decisions before Luna mutates code.

## Writer pool

One mutating Luna is the default. Two are automatic only for complete independent
outcomes with frozen contracts, disjoint ownership, and independent checks.
Three requires explicit user intent and isolation. Shared mutable surfaces have
one owner or remain a serial Lead integration step.

Parallelism improves throughput only when outcomes are genuinely independent.
It never justifies duplicate work or splitting one feature by file, component,
command, test, or exact edit.

## Persistent outcome ownership

The Coder session key is the spec ID/revision, outcome ID, route, and owned
surfaces. While unchanged, one Coder identity owns implementation, focused
checks, Lead feedback, and bounded repair.

The first assignment contains one rendered execution capsule. Continuations
carry only the delta and never resend the capsule or full task. This preserves
context and avoids repeated input cost.

## Stall recovery

Silence is a bounded recovery state:

```text
named wait -> inspect diff/agent state -> same-ID redirect
-> CODER_STALLED -> stop child mutation -> Lead takeover
```

A stall cannot satisfy T2 and never creates Terra or Sol. The original whole
outcome remains intact. The Lead prevents late concurrent child mutation,
reopens the locked requirement checklist, implements the remainder, and still
runs separate review and QA.

## Review, QA, Gate, and repair

The Lead first reviews specification conformance, then engineering integrity,
then executes or directly observes requirement-linked acceptance QA. It finally
performs the Gate over requirement coverage, evidence layers, residual risk,
rollback, external state, and completion claims. Child checks and advisory
findings cannot approve completion, and no Gate child exists.

This ownership is deliberate. The main Lead alone holds the canonical user
conversation and specification, sees the integrated cross-outcome diff, controls
the faithful QA surfaces, separates static/runtime/external/release evidence,
and retains authority for completion. A Coder is therefore not allowed to
self-review its implementation into acceptance. If the Lead takes over coding
after a stall, it still reopens the pre-existing specification checklist and
runs review, QA, and Gate as distinct evidence phases.

Review and QA share two in-spec repair slots. A repeated failure of one
requirement or changed frozen boundary means the plan must be revised rather
than adding hidden retries or stronger agents.

## Fast

Fast remains Luna-only and child-local. It changes speed and consumption, not
model intelligence, scope, reasoning effort, specification, review, or QA.
Because Fast may consume credits at a higher rate, it is selected explicitly.

## Verifiable contract

Version 0.12 validation requires:

- Luna max as the declared economic and initial implementation default, with
  every Luna child fixed at max reasoning;
- no `gpt-5.6-sol` in any Teamplay agent TOML;
- Terra xhigh as the maximum child configuration;
- no automatic Terra selection from difficulty, presets, or failed readiness;
- T1/T2 evidence for every Terra implementation route;
- one global policy block per initial assignment and none in continuations;
- one Coder identity per coherent outcome and bounded Lead takeover on stall;
- final specification review, engineering review, QA, Lead-owned Gate, and
  evidence separation;
- no distributed or installed `teamplay-gate` role;
- installed skill and role bytes matching the bundle.

Static configuration proves configured intent only. Live model identity and
runtime behavior remain host-observed evidence.

## Sources checked

- [GPT-5.6 model guidance](https://developers.openai.com/api/docs/guides/latest-model)
- [GPT-5.6 model comparison](https://developers.openai.com/api/docs/models/compare)
- [GPT-5.6 Luna](https://developers.openai.com/api/docs/models/gpt-5.6-luna)
- [Codex rate card](https://help.openai.com/en/articles/20001106-codex-rate-card)
- [Codex subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents)
- [Codex speed](https://learn.chatgpt.com/docs/agent-configuration/speed)
