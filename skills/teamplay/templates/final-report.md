# Teamplay Run Report

```markdown
## Teamplay Run Report

### Run

- Entry point: `$teamplay | $teamplay-fast | $teamplay-deep | $teamplay-critical`
- Resolved preset: `auto | fast | deep | critical`
- Overall status: `COMPLETE | PARTIAL | BLOCKED | FAILED`
- Lead: `current main agent`
- Lead model: `<runtime-confirmed value | runtime metadata not exposed>`
- Lead reasoning: `<runtime-confirmed value | runtime metadata not exposed>`
- Saved report: `<path | inline only>`

### Team used

| Instance | Registered agent type | Model provenance | Assignment | Why selected | Result |
|---|---|---|---|---|---|
| 1 | `teamplay-coder` | configured: `gpt-5.6-terra`, high | ... | ... | ... |

If no child ran:

| Instance | Registered agent type | Model provenance | Assignment | Why selected | Result |
|---|---|---|---|---|---|
| — | None | — | Main Lead handled directly | Delegation added no useful separation | ... |

### Flow

`Lead → Scout + Researcher → Coder → Reviewer → QA → Gate`

- Escalations: ...
- Retries or repair loops: ...
- Implementation slices: ...
- Avoidable handoffs: ...
- Whole assigned outcome completed in one pass: `yes | no` — ...

### Delivery

- Outcome: ...
- Changed paths: ...
- Artifacts: ...

### Evidence

- Implementation: `PASS | FAIL | PARTIAL | BLOCKED | NOT_APPLICABLE` — ...
- Review: `PASS | FAIL | PARTIAL | BLOCKED | NOT_APPLICABLE` — ...
- QA/runtime: `PASS | FAIL | PARTIAL | BLOCKED | NOT_APPLICABLE` — ...
- QA gate: `<gate name | not run>`
- QA execution count: `<runtime-confirmed count>`
- Reused/invalidated evidence: ...
- Interactive surfaces: `<in-app Browser | Chrome | Computer Use app | Simulator | device | none>`
- Visual evidence: `<screenshot/artifact paths | not applicable>`
- Surface limitations: ...
- Gate: `PASS | FAIL | PARTIAL | BLOCKED | NOT_APPLICABLE` — ...
- Release/external: `PASS | FAIL | PARTIAL | BLOCKED | NOT_APPLICABLE` — ...

### Omissions and limits

- Roles not used: ...
- Unverified surfaces: ...
- User-authorized next actions: ...

### Routing observations

- Observable model or routing behavior: ...
- Suggested future Teamplay adjustment: ...
- Delivery speed observation: `<slice sizing, handoff count, review loops, QA gate frequency>`
- Runtime duration/tokens: `<runtime value | not exposed>`
```
