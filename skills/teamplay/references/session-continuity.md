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
| wait | Allow the active Coder one bounded window to reach a named checkpoint. |
| message/reuse | Send focused follow-up to the still-available Coder with the same key. |
| resume | Continue the same closed Coder with a compact packet and the same key. |
| redirect | Give one bounded same-session progress correction before takeover. |
| restart | Create a fresh Coder only at an explicit boundary. |
| takeover | End stalled child mutation and transfer the unchanged whole outcome to the Lead. |
| close | Release an active slot while retaining the agent ID until acceptance or replan settles the outcome. |

A fresh Coder is allowed only for a new independent outcome, a changed session
key after replan, or an unavailable prior agent before meaningful outcome work
begins. Persistent non-progress after one bounded redirect transfers the
unchanged whole outcome to the Lead; it does not create a replacement-Coder or
micro-packet boundary. A changed specification, authority, frozen contract, or
ownership boundary always returns to the Lead for replan before mutation.
Session reuse cannot preserve stale authority.

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

Run reports distinguish spawn, wait, message/reuse, resume, redirect, restart,
takeover, and close events, including the session key, agent identity, outcome,
and host-observed evidence or limitation.

Host token diagnostics use separate fields:

    input_cached
    input_uncached
    output
    reasoning

Each field is a host observation or unavailable. These counters describe
diagnostics only; they never imply provider billing, price, credits, or cost.
Record billing as not inferred unless an independently verified billing surface
is read back.

## LC-07: stalled Coder recovery and Lead takeover

Silence or delayed mutation is not immediate failure. Diff is a delivery signal,
not a liveness signal. Before declaring a stall, the Lead records one expected
checkpoint and one minutes-scale inactivity window, then inspects the Coder's
host status and recent agent-message, reasoning, tool-call/output, token, and
command activity before inspecting the actual repository diff. Use the runtime
inspector when rollout activity is available; it exposes timestamps and counts,
not prompt content.

`wait_agent` returning `timed_out: true` means only that the agent did not reach
a terminal status during that call. It is never by itself evidence of silence,
failure, or non-progress. `running` plus activity after the previous boundary is
usable progress even when no file has changed. Pre-mutation repository reading,
planning, and tool use count as activity. Set the wait window according to the
whole outcome and prefer minutes over repeated 60-second polls.

Waiting itself consumes no model tokens; token events occur only when the model
generates. Batch repeated waits inside one command loop so timeouts do not
multiply wake-ups, and treat a short timeout plus a running Coder as a reason to
wait again rather than to make a decision. Measured evidence: coordination for a
four-Coder run was about 1-2% of the total, and an early takeover's dominant
cost was the Lead implementing at its own rate, not the Coder's wasted tokens.

If there is still no activity, usable response, or evidenced progress across the
named inactivity window, send one redirect to the same agent ID with
`interrupt:false`. The redirect asks for progress toward the original whole
outcome or an explicit blocker by the next named boundary. It may name an
observable mutation checkpoint, but it must not prescribe keystrokes, split the
outcome by file or component, or create another Coder. `interrupt:true` is
forbidden when the only evidence is a wait timeout or absent diff; forced
interruption requires a known unsafe/wrong-direction action or explicit
authority revocation.

If the same Coder crosses a second evidenced inactivity window after that
non-interrupting redirect and still produces no activity, usable progress, or
blocker, record `CODER_STALLED`, stop or close its mutation authority, and
transfer the same locked whole outcome to the current main Lead. `running` with
recent activity forbids takeover. When the host cannot expose activity, liveness
is unproven; keep waiting or ask the user instead of closing a possibly active
Coder. A late child response cannot mutate concurrently after takeover.
Preserve and inspect valid partial work rather than discarding it merely because
the child stalled.

Lead takeover is an implementation-owner transition, not an automatic replan
or repair slot. Before editing, the Lead reopens the canonical specification and
records the applicable requirement and acceptance checklist. After editing, the
Lead still performs the separate requirement-by-requirement spec review,
engineering-integrity review, and acceptance QA on the real artifact. The
Lead's authorship, a clean diff, or passing Coder checks cannot substitute for
those gates.

If the Lead cannot safely finish within the locked authority, specification, or
available validation surface, return to `REPLAN` or `BLOCKED`. Never hide the
stall by spawning serial replacement Coders or shrinking the original outcome
into file, component, command, or exact-edit packets.
