# Advisory review packet

```yaml
role: teamplay-reviewer
authority: advisory-only
context_policy: fresh
fork_turns: none
review_focus: spec-deviation | correctness-regression | security-concurrency | general
canonical_spec:
  paths: []
  revision:
  complete_spec_available: true
assigned_requirement_ids: []
baseline:
  repository:
  base_sha:
  head_sha:
changed_paths: []
diff_source:
before_state:
after_state_check:
runtime_identity_evidence:
lead_questions: []
verification_evidence: []
required_output:
  - advisoryStatus
  - specDeviationCandidates
  - engineeringRiskCandidates
  - optionalImprovements
  - inspectedDiff
  - evidenceChecked
  - limitations
```

The packet is invalid if it contains only a code diff or prose goal summary.
The reviewer must be able to inspect the complete locked specification and the
actual accumulated diff. Its verdict is advisory evidence, never Lead approval
or final Gate authority.
