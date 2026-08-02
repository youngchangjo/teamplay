# Teamplay Coder continuation packet

Use this compact packet only when the same Coder session key remains valid.
It carries the delta since the last event; it is not a new task capsule.

~~~yaml
continuation:
  spec_id:
  spec_revision:
  outcome_id:
  route:
  owned_surfaces: []
  session_key:
  prior_agent_id:
  event: message/reuse | resume | redirect
  state: implementation | focused_checks | lead_feedback | repair
  continuation_reason:
  expected_checkpoint:
  wait_boundary_reached:
  observed_progress:
  lead_feedback: []
  requested_result:
  failed_requirement_ids: []
  invalidated_checks: []
  acceptance_reruns: []
  repair_cycle: 0 | 1 | 2
  stop_if: []
~~~

Rules:

- The session key is the spec ID/revision, outcome ID, route, and owned
  surfaces. An unchanged key keeps the same Coder identity.
- The initial assignment already carried the one canonical execution capsule.
  This packet contains zero execution capsule copies and does not resend the
  full initial task.
- Use message/reuse while the Coder is available, resume for the same closed
  Coder, and redirect at most once after one named bounded wait and an actual
  diff/agent-state inspection show no usable progress.
- A redirect may request an observable mutation checkpoint or explicit blocker,
  but it keeps the original whole outcome. Do not turn a file, component,
  command, or exact edit into a replacement assignment.
- Closing for capacity retains the prior agent ID and never authorizes a fresh
  Coder by itself.
- If the redirect also yields no usable progress, record `CODER_STALLED`, stop
  child mutation, and transfer the unchanged whole outcome to the Lead. Do not
  send another continuation or spawn a replacement Coder for the stall.
- A changed key, changed authority, frozen contract, ownership boundary, or
  unresolved predicate returns to the Lead for replan. Do not encode restart as
  a continuation event.
- Keep Lead review and QA repair state in the shared maximum-two budget.
