# Lead acceptance QA worksheet

```yaml
authority: current-main-lead
qa_gate: integrated-feature | user-visible-milestone | pre-merge | pre-release | critical-final-evidence
gate_reason:
canonical_spec:
  paths: []
  revision:
outcome_id:
session_key:
coder_identity:
target:
  repository:
  branch:
  sha:
  build:
  url:
  app:
  simulator_or_device:
scenarios:
  - id:
    requirement_id:
    criterion:
    surface:
    surface_kind:
    setup: []
    actions: []
    expected_observable:
    actual_observable:
    lead_verdict: PASS | FAIL | PARTIAL | BLOCKED | NOT_APPLICABLE
    artifact_paths: []
    surface_limitations:
prior_evidence:
  reusable: []
  invalidated: []
lead_qa_verdict: PASS | FAIL | PARTIAL | BLOCKED
execution_count:
missing_prerequisites: []
```

If an advisory QA helper is used, record its candidate evidence separately.
The Lead must still execute or directly observe every decisive scenario.
