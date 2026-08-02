# Evidence contract

Evidence states do not imply later states:

1. `specified`: canonical spec revision and requirement anchors exist.
2. `implemented`: owned changes and Coder checks exist.
3. `lead_reviewed`: the Lead inspected the real diff against the spec and
   engineering risks.
4. `lead_qa_observed`: the Lead executed or directly observed the named surface.
5. `advisory_audited`: an optional child returned additional findings.
6. `externally_verified`: deployment, store, release, or another external state
   was read back independently.

## Requirement evidence

For each requirement record the spec anchor, implementation surfaces, exact
check or scenario, target identity, expected and actual observable, artifact,
evidence state, verdict, and limitation.

Use:

- `PASS`: requested evidence exists on the named surface;
- `FAIL`: the observed result violates the requirement;
- `PARTIAL`: some required evidence exists;
- `BLOCKED`: a named prerequisite prevented observation;
- `NOT_APPLICABLE`: the requirement does not need that evidence class;
- `NOT_PROVEN`: configuration or behavior may be correct but the requested
  evidence surface is unavailable.

## Identity and invalidation

Evidence names the branch/SHA, build or artifact identity, surface, and time.
Invalidate affected evidence after executable inputs, frozen contracts, target
identity, or the observed behavior changes. Static TOML proves configuration,
not the model or tier that actually ran. Child echoes are not runtime identity
evidence.

Lifecycle evidence is orchestration evidence, not product or runtime proof.
Reports distinguish spawn, message/reuse, resume, redirect, restart, and close
with the session key and host-observed identity or an honest limitation. Host
token diagnostics keep input_cached, input_uncached, output, and reasoning
separate; they never establish provider billing or cost.
