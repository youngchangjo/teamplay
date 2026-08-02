# Coder session continuity

This is the public lifecycle contract for a mutating Teamplay Coder. It
complements the canonical execution capsule; it does not replace or duplicate
that capsule.

## LC-01: one coherent outcome

An outcome is an independently integratable behavior or milestone. Its scope
includes every directly coupled established layer: implementation, tests,
fixtures, documentation, and configuration that are required for the result.

Do not create a new outcome, Coder, or assignment for a file, layer, exact code
fragment, command, checklist item, focused check, Lead feedback packet, or
bounded in-spec repair. A Coder returns one coherent result for the outcome.

## LC-02: stable session identity

Derive one session key from this ordered tuple:

    spec ID / revision + outcome ID + route + owned surfaces

Route includes the selected model, reasoning effort, and service tier. Owned
surfaces are the normalized surface list recorded in the task capsule. An
unchanged key reuses the same Coder identity through implementation, directly
coupled checks, Lead feedback, and in-spec repairs.

The Lead records the key and the host-observed agent identity with every
lifecycle event. A child cannot change the key, outcome, or ownership.

## LC-03: lifecycle events and restart boundaries

The event names below are distinct and are recorded in order:

| Event | Meaning |
|---|---|
| spawn | Create the one Coder for the initial assignment. |
| message/reuse | Send focused follow-up to the still-available Coder with the same key. |
| resume | Continue the same closed Coder with a compact packet and the same key. |
| redirect | Give one bounded progress correction before considering a restart. |
| restart | Create a fresh Coder only at an explicit boundary. |
| close | Release an active slot while retaining the agent ID until acceptance or replan settles the outcome. |

A fresh Coder is allowed only for a new independent outcome, a changed session
key after replan, an unavailable prior agent, or evidenced non-progress that
persists after one bounded redirect. A changed specification, authority,
frozen contract, or ownership boundary always returns to the Lead for replan
before mutation. Session reuse cannot preserve stale authority.

The Lead does not reflexively poll or spawn a duplicate while the same Coder is
active. Wait or resume is tied to a named expected event, result, or host
condition.

Closing a child to release capacity does not authorize a replacement. Resume
the same identity for an in-spec Lead review or QA repair. Retire the identity
only after the outcome is accepted, replanned to a changed key, or proven
unavailable.

## LC-04: compact continuation

An existing Coder receives the continuation template at
templates/continuation-packet.md. It contains only the delta since the last
event, the requested result, affected checks, and bounded stop conditions.

It does not contain the canonical execution capsule, a second copy of the
initial task, or a replacement global policy. A continuation with a missing or
changed session key is invalid and must return to the Lead for replan.

The initial assignment contains exactly one canonical execution capsule.
Same-session continuation contains zero execution capsule copies.

## LC-05: scheduling and repair

Implementation, directly coupled checks, Lead feedback, and in-spec repairs
remain one outcome and one Coder identity while the key is unchanged. Review
and QA still use the shared maximum-two repair budget. A repair that changes
the key, ownership, authority, or a frozen contract is a replan, not a
continuation.

Parallel Coders remain limited to independent outcomes with frozen contracts,
disjoint ownership, no dependency on another child's uncommitted work, and
independent checks. Parallelism never justifies duplicate work on one outcome.

## LC-06: lifecycle and token diagnostics

Run reports distinguish spawn, message/reuse, resume, redirect, restart, and
close events, including the session key, agent identity, outcome, and
host-observed evidence or limitation.

Host token diagnostics use separate fields:

    input_cached
    input_uncached
    output
    reasoning

Each field is a host observation or unavailable. These counters describe
diagnostics only; they never imply provider billing, price, credits, or cost.
Record billing as not inferred unless an independently verified billing surface
is read back.
