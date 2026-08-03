# Teamplay lifecycle fixtures

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
takeover decision. Expected: redirect is distinct from takeover and restart.

## LF-05 — Explicit restart boundary

A fresh Coder is allowed only for a new independent outcome, a changed key after
replan, or an unavailable prior agent before meaningful work begins. Persistent
non-progress after redirect transfers the whole outcome to the Lead.
Expected: restart is blocked for a stall, file, command, check, or ordinary
wait.

## LF-06 — Scheduling

The Lead waits for a named result or host condition and does not reflexively
poll or duplicate active work. Parallel Coders remain limited to independent
outcomes with frozen contracts and independent checks.
Expected: no duplicate same-outcome spawn.

## LF-07 — Lifecycle diagnostics

Reports distinguish spawn, wait, message/reuse, resume, redirect, restart,
takeover, and close. Host diagnostics separately record input_cached,
input_uncached, output, and reasoning, and do not infer provider billing.
Expected: all event names and four token fields are present.

## LF-08 — Named wait before stall

An active HTML Coder has not responded or mutated the target yet. The Lead
records the expected whole-outcome checkpoint and one bounded wait condition,
waits without repeated polling, then inspects the actual diff and agent state.
Expected: one wait; no duplicate Coder and no component/file packet.

## LF-09 — Same-session redirect, then Lead takeover

The wait boundary shows no usable response or evidenced progress. The Lead
redirects the same agent ID once toward the original whole outcome or an
explicit blocker. The next named boundary is also empty.
Expected: `CODER_STALLED`; child mutation stops; the Lead takes over the same
whole outcome; no restart, replacement Coder, or micro-packet.

## LF-10 — Spec-based review after takeover

Before direct implementation, the Lead reopens and records the locked
requirement and acceptance checklist. After implementation, the Lead performs a
separate spec-conformance review, engineering-integrity review, and acceptance
QA against the real artifact.
Expected: Lead authorship and passing implementation checks are not accepted as
review or QA evidence by themselves.

## LF-11 — Wait timeout while Coder is active

`wait_agent` times out after 60 seconds with no terminal result and the diff is
empty. The Coder rollout shows recent reasoning, tool calls, token events, and
host status `running`. Expected: active progress; continue waiting. No redirect,
interrupt, stall verdict, close, or Lead takeover.

## LF-12 — Non-interrupting liveness redirect

The Coder has no activity, response, blocker, or diff across a named
minutes-scale inactivity window. Expected: one same-ID redirect with
`interrupt:false`. A wait timeout or empty diff by itself does not satisfy this
fixture.

## LF-13 — Takeover requires two evidenced inactivity windows

After LF-12, a second named inactivity window also has no activity, progress, or
blocker. Expected: `CODER_STALLED` and Lead takeover are allowed. If status is
`running` with recent activity, or activity visibility is unavailable, takeover
is forbidden; wait or ask the user.
