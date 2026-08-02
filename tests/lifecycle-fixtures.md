# Teamplay 0.11 lifecycle fixtures

These static fixtures test lifecycle semantics separately from model routing and
from runtime or billing proof.

## LF-01 — Coherent outcome

One behavior includes its directly coupled implementation, focused checks,
fixtures, docs, and configuration. A file or command is not a separate outcome.
Expected: one outcome and one Coder identity.

## LF-02 — Same-key coupled work

Implementation, directly coupled checks, Lead feedback, and an in-spec repair
retain the spec revision, outcome ID, route, and owned-surface session key.
Expected: message/reuse or resume; same Coder identity.

## LF-03 — Capsule boundary

The initial assignment has exactly one canonical execution capsule. A
continuation packet has zero capsule copies and does not resend the full task.
Expected: one initial capsule; zero continuation capsules.

## LF-04 — Bounded progress redirect

The same Coder receives one redirect for evidenced non-progress before any
restart decision. Expected: redirect is distinct from restart.

## LF-05 — Explicit restart boundary

A fresh Coder is allowed only for a new independent outcome, a changed key after
replan, an unavailable prior agent, or persistent non-progress after redirect.
Expected: restart is blocked for a file, command, check, or ordinary wait.

## LF-06 — Scheduling

The Lead waits for a named result or host condition and does not reflexively
poll or duplicate active work. Parallel Coders remain limited to independent
outcomes with frozen contracts and independent checks.
Expected: no duplicate same-outcome spawn.

## LF-07 — Lifecycle diagnostics

Reports distinguish spawn, message/reuse, resume, redirect, restart, and close.
Host diagnostics separately record input_cached, input_uncached, output, and
reasoning, and do not infer provider billing.
Expected: all event names and four token fields are present.
