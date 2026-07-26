# QA task packet

```yaml
role: teamplay-qa
objective:
qa_gate: integrated-feature | user-visible-milestone | pre-merge | pre-release | critical-final-evidence
gate_reason:
target:
  repository:
  branch:
  sha:
  url:
  app:
  simulator_or_device:
preferred_surface: auto | in-app-browser | chrome | computer-use | simulator | physical-device | cli | api
required_skills:
  - browser:control-in-app-browser
  - computer-use:computer-use
acceptance_criteria: []
scenarios:
  - id:
    criterion:
    surface:
    surface_kind:
    invocation:
    actions: []
    expected:
evidence_directory:
prior_evidence:
  reusable: []
  invalidated: []
required_output:
  - overallStatus
  - scenarioResults
  - artifactPaths
  - interactionEvidence
  - visualEvidence
  - surfaceLimitations
  - qaGate
  - testedTarget
  - reusedEvidence
  - invalidatedEvidence
  - executionCount
  - blockers
  - missingPrerequisites
```
