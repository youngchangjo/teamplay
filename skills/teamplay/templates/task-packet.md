# Teamplay task capsule

This task-variable capsule follows the canonical execution capsule. Render both
with `scripts/render-task-packet.py`; do not copy global policy here.

```yaml
assignment:
  role: teamplay-coder | teamplay-coder-fast | teamplay-coder-deep
  instance:
  spec:
    path:
    id:
    revision:
    baseline_sha:
    level: brief | full
  outcome_id:
  session_key:
  initial_assignment: true
  route:
    economic_default: Luna max
    model: gpt-5.6-luna | gpt-5.6-terra
    reasoning_effort: max | xhigh
    service_tier: standard | fast
    readiness:
      L1:
      L2:
      L3:
      L4:
      L5:
      L6:
    terra_exception: none | T1 explicit_user_terra | T2 evidenced_luna_capability_blocker
    terra_exception_evidence:
    sol_child_selected: false
  pool:
    size:
    wave:
    isolation:
  requirements: []
  outcome:
  owned_surfaces: []
  shared_surface_owner:
  frozen_contracts: []
  allowed_local_judgment: []
  required_checks: []
  task_specific_stops: []
  repair_cycle: 0 | 1 | 2
```

Expected result fields are supplied by the canonical execution capsule.

For same-session follow-up, use templates/continuation-packet.md. Do not place
the canonical execution capsule or a full initial task inside a continuation.
