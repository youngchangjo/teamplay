# Continuation packet fixture: 0.11.1 stalled-Coder redirect

continuation:
  spec_id: TP-CODER-LIFECYCLE-001
  spec_revision: 2
  outcome_id: public-package
  route: Luna max Standard
  owned_surfaces: VERSION, CHANGELOG.md, README.md, docs/, skills/teamplay, scripts/validate.sh, tests/
  session_key: TP-CODER-LIFECYCLE-001@2 / public-package / Luna max Standard / owned-public-surfaces
  prior_agent_id: TP-CODER-LIFECYCLE-001-PUBLIC
  event: redirect
  state: implementation
  continuation_reason: named wait boundary reached with no usable response or evidenced mutation
  expected_checkpoint: progress toward the original whole outcome or an explicit blocker
  wait_boundary_reached: true
  observed_progress: none in actual diff or latest host-observed agent state
  lead_feedback: []
  requested_result: produce observable progress toward the original whole outcome or return an explicit blocker by the next named boundary
  failed_requirement_ids: []
  invalidated_checks: []
  acceptance_reruns: []
  repair_cycle: 0
  stop_if: [session key changes, ownership overlap, frozen contract changes]

This fixture contains zero execution capsule copies and no full initial task.
Allowed same-key packet events remain message/reuse, resume, and redirect.
It preserves the whole outcome and does not prescribe a file, component,
command, exact edit, or replacement Coder. If the redirect still has no usable
progress, the next event is `CODER_STALLED` plus Lead takeover, not another
continuation.
