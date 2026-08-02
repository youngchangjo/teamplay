# Delivery and repair cadence

Pool count, writer independence, and isolation are defined only in
`routing.md`. This file covers Fast economics, scheduling, early checks, and the
shared repair state.

## Fast

Fast changes supported-model speed and consumption, not intelligence, scope, or
evidence. It applies only to `teamplay-coder-fast`; the Lead, Standard Luna, and
Terra exception Coder retain their current tiers. Sol children are prohibited.

Pricing and credit rates are volatile. When economics affect a routing decision,
record the official source, observation date, API-versus-Codex basis, and whether
a ratio is quoted or derived. Do not embed current prices in routing logic.

## Scheduling

- Start one implementation wave after the specification is ready.
- Run an early targeted check when it can prevent invalid downstream work.
- Integrate and inspect a stable outcome instead of reviewing partial noise.
- Do not start a new mutating wave faster than the Lead can integrate it.
- Keep implementation, coupled checks, Lead feedback, and in-spec repairs on
  the same Coder identity while the session key is unchanged.
- Use message/reuse or resume for an unchanged key. Redirect once for bounded
  non-progress after waiting for a named result or host condition and inspecting
  the actual diff and agent state; do not reflexively poll or duplicate active
  work.
- Closing a child may free a concurrency slot, but it does not create a fresh
  assignment boundary. Retain and resume the same agent ID for in-spec repair.
- If the redirect still yields no usable progress or blocker, record
  `CODER_STALLED` and transfer the unchanged whole outcome to the Lead. Do not
  create file/component packets or a serial replacement Coder.
- Restart only for a new independent outcome, a changed key after replan, or an
  unavailable prior agent before meaningful outcome work begins.
- Lead takeover reopens the locked requirement and acceptance checklist before
  editing. It is not a repair slot and never waives separate spec review or QA.

## Shared repair budget

Lead review and Lead QA share at most two repair slots:

```text
IMPLEMENTED -> LEAD_REVIEW

LEAD_REVIEW pass -> LEAD_QA
LEAD_REVIEW bounded failure -> next available REPAIR slot

REPAIR_1 -> focused Lead re-review -> LEAD_QA when review passes
REPAIR_2 -> focused Lead re-review -> LEAD_QA when review passes

LEAD_QA pass -> COMPLETE
LEAD_QA bounded failure -> next available REPAIR slot -> Lead re-review -> Lead QA

Any failure after REPAIR_2 -> REPLAN/BLOCKED
Any second failure of the same requirement -> REPLAN
Any frozen-contract, ownership, authority, or spec change -> REPLAN
```

One repair remains the expected path. A repair is bounded only when it stays
inside the same spec revision, ownership, and authority. Each repair packet
names failed requirement IDs, observed evidence, owner, permitted files,
invalidated checks, and exact reruns. Do not create a separate hidden repair
allowance for QA failures.
