# Continuation packet fixture: 0.11

continuation:
  spec_id: TP-CODER-LIFECYCLE-001
  spec_revision: 1
  outcome_id: public-package
  route: Luna max Standard
  owned_surfaces: VERSION, CHANGELOG.md, README.md, docs/DESIGN.md, skills/teamplay, scripts/validate.sh, tests/
  session_key: TP-CODER-LIFECYCLE-001@1 / public-package / Luna max Standard / owned-public-surfaces
  prior_agent_id: TP-CODER-LIFECYCLE-001-PUBLIC
  event: resume
  state: lead_feedback
  continuation_reason: apply one in-spec Lead review repair without changing the outcome
  lead_feedback: [finish versioned results and rerun assigned checks]
  requested_result: resolve the named review finding and return the outcome to its accepted checks
  failed_requirement_ids: [LC-04]
  invalidated_checks: []
  acceptance_reruns: [./scripts/validate.sh --bundle, git diff --check]
  repair_cycle: 0
  stop_if: [session key changes, ownership overlap, frozen contract changes]

This fixture intentionally contains zero execution capsule copies, no execution
capsule delimiters, and no full initial task copy.
Allowed same-key events are message/reuse, resume, and one bounded redirect.
Closing for capacity retains the prior agent ID and does not authorize a fresh
Coder.
