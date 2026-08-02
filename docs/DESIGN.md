# Teamplay 0.11 design rationale

Teamplay is a specification-first manager pattern with model-aware
implementation. The current main agent keeps product authority, integration,
final diff review, acceptance QA, and completion. Luna or Sol owns one bounded
implementation outcome.

## Why the 0.9 harness changed

Version 0.9 correctly moved review and QA back to the Lead, but it overfit three
areas:

- Luna was described by outcome size without qualifying ambiguity or remaining
  decision density;
- Sol was available only after a Luna failure;
- safety, ownership, evidence, and final-authority clauses were repeated in the
  core skill, references, templates, and role prompts.

OpenAI's current GPT-5.6 guidance describes Sol as the frontier choice for
demanding, ambiguous, multi-step work and Luna as the efficient high-volume
choice for clear, repeatable work. It also recommends lean prompts that state a
policy once. Multi-agent guidance favors independent bounded work and warns
against shared mutable writers.

The user's product policy remains stricter than generic effort guidance: every
Luna child runs at max.

## Authority before model

The route is:

```text
R0 authority -> R1 specification -> R2 model -> R3 pool
```

This order prevents a powerful model from being treated as authority. Sol cannot
perform an unapproved external or destructive action, and no model starts while
a user-authority decision remains unresolved.

## Decision density, not file count

Luna eligibility is an all-pass semantic gate. The behavior, acceptance,
contracts, consequential choices, risk, and ownership must already be bounded.
The Coder can still span every directly required established layer.

Sol is proactive when consequential technical judgment remains. It can resolve
only the technical decision space named by the Lead; the Lead still owns product
intent. This avoids paying for a predictable Luna failure while preserving Luna
for broad mechanical implementation that benefits from its lower cost.

## Coherent outcomes and persistent sessions

Version 0.11 makes outcome granularity explicit. One outcome is an
independently integratable behavior or milestone with its directly coupled
implementation, checks, fixtures, docs, and configuration. Splitting one
outcome by file, command, test, or repair creates coordination noise without
adding useful independence.

The Coder session key is the spec ID/revision, outcome ID, route, and owned
surfaces. While that key is unchanged, one Coder identity owns implementation,
coupled checks, Lead feedback, and bounded in-spec repairs. This keeps context
and responsibility continuous without changing Lead authority.

## Restart boundaries and continuation

The first assignment contains exactly one rendered execution capsule. A
same-session follow-up uses a compact continuation packet containing only the
delta, requested result, invalidated checks, and stop conditions. It deliberately
does not copy the capsule or resend the full initial task.

A new Coder is justified only by a new independent outcome, a changed key after
replan, an unavailable prior agent, or evidenced non-progress after one bounded
redirect. A spec, authority, frozen-contract, or ownership change is a replan
boundary. The scheduler waits for named conditions and avoids reflexive polling
or duplicate work.

Closing a completed child can release a concurrency slot, but it does not create
a new assignment boundary. Teamplay retains the agent identity and resumes it
for an in-spec repair until the outcome is accepted or replanned.

## Lifecycle diagnostics

Run reports distinguish spawn, message/reuse, resume, redirect, restart, and
close events. Host token diagnostics preserve cached input, uncached input,
output, and reasoning as separate observations. They describe execution
diagnostics, not provider billing or cost.

## Two specification levels

A Spec Brief supplies enough written authority for one ordinary outcome and for
the Lead's final review/QA without adding a matrix or per-file recipe.

A Full Spec Lock adds coordination controls only when the work shape requires
them: multiple writers, shared contracts or ownership, critical semantics,
migration/recovery, cross-environment QA, or non-local rollback.

The trigger is risk created by coordination, not the presence of a filename such
as `Package.resolved` or a lockfile. One owner can make a predetermined shared
artifact update under a Brief.

## Single-source execution policy

The canonical execution capsule is delimited in one reference file. A renderer
extracts it and assembles a spawn prompt with one task capsule. Validation checks
delimiter count and normalized SHA-256 equality against the source.

This is stronger and shorter than repeating paraphrased rules:

- source drift becomes detectable;
- a child receives policy text rather than an unread path;
- role prompts contain only model-specific judgment and stops;
- task capsules contain only variable assignment data.

## Writer pool

The default is one mutating writer. Two are automatic only for genuinely
independent outcomes. Three requires explicit intent and isolation. This matches
the practical value of focused contexts while accounting for Codex's warning
that parallel write-heavy work can increase conflicts and coordination.

Routing is the sole normative owner of pool and parallel rules. Delivery-speed
guidance may discuss scheduling but cannot redefine eligibility.

## Fast

Standard and Fast Luna use the same model, max effort, specification, and result
contract. Fast adds child-local service-tier and feature settings. The Lead and
Sol remain unchanged.

Pricing is observational context, not policy. Version 0.10 records the official
source and date when discussing the 2026-08-01 Luna reduction but does not embed
current prices in routing logic.

## Review, QA, and repair

The Lead's spec-conformance pass occurs before engineering-integrity judgment.
This prevents a code-only review from redefining the product.

Acceptance QA remains a direct Lead responsibility. Child checks and advisory
QA evidence are inputs, not the final verdict. Proof layers remain separate.

Review and QA share two repair slots. A late QA failure cannot silently create a
third allowance. Repeated failure of one requirement or a changed frozen
boundary means the plan was wrong and must be revised.

## Verifiable lean-harness target

Teamplay preserves the 0.9 prompt-pressure baseline. Version 0.11 must show:

- one global policy block in each assembled prompt;
- no copied global block in Coder TOMLs;
- shorter role instructions for Standard, Fast, and Sol;
- at least 25% fewer non-task policy characters per representative route;
- one session identity across implementation, coupled checks, feedback, and
  bounded repair;
- explicit restart boundaries and capsule-free continuation;
- distinct lifecycle events and non-billing token diagnostics;
- no loss of authority, requirement coverage, Lead review, Lead QA, or evidence
  separation.

Static TOML proves configured intent only. Live Standard, Fast, and Sol canaries
need host-observed model, effort, and tier metadata; otherwise runtime identity
is `NOT_PROVEN`.

## Sources checked

- [GPT-5.6 guidance](https://developers.openai.com/api/docs/guides/latest-model)
- [OpenAI Multi-agent](https://developers.openai.com/api/docs/guides/responses-multi-agent)
- [GPT-5.6 Luna](https://developers.openai.com/api/docs/models/gpt-5.6-luna)
- [GPT-5.6 Sol](https://developers.openai.com/api/docs/models/gpt-5.6-sol)
- [Codex subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents)
- [Codex speed](https://learn.chatgpt.com/docs/agent-configuration/speed)
- [Codex rate card](https://help.openai.com/en/articles/20001106-codex-rate-card)
