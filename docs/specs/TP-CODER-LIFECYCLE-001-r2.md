# Spec Brief: stalled Coder recovery and Lead takeover

## Identity

- Spec ID and revision: `TP-CODER-LIFECYCLE-001`, revision 2
- Repository baseline: `44277f7`
- Implementation owner: current main agent; Teamplay is not invoked to maintain
  its own package
- Spec level: `brief`
- Coder count: zero for this maintenance change

## Outcome and requirement anchors

- One completion sentence: Teamplay waits for a named progress checkpoint,
  redirects the same stalled Coder once, then lets the current main Lead finish
  the unchanged whole outcome and still perform specification-based review and
  QA instead of spawning replacement Coders or micro-splitting the work.
- `LC-01 outcome_granularity`: One independently integratable outcome includes
  all directly coupled implementation and checks; files and components are not
  replacement assignments.
- `LC-02 session_continuity`: An unchanged session key keeps one Coder identity
  through normal implementation, feedback, checks, and in-spec repair.
- `LC-03 restart_boundary`: A mid-outcome stall does not authorize a replacement
  Coder. Restart remains limited to a new outcome, changed key after replan, or
  prior-agent unavailability before meaningful work begins.
- `LC-04 lean_continuation`: Same-session recovery uses the compact continuation
  packet and never resends the canonical execution capsule or full task.
- `LC-05 scheduling`: The Lead waits one bounded window for a named checkpoint,
  inspects actual diff and agent state, and avoids reflexive polling or duplicate
  writers.
- `LC-06 evidence`: Reports distinguish wait and takeover from message, resume,
  redirect, restart, and close, and record `CODER_STALLED` honestly.
- `LC-07 stall_recovery`: One failed same-ID redirect transfers the unchanged
  whole outcome to the Lead. Lead takeover reopens the locked requirement and
  acceptance checklist before implementation and preserves separate review/QA.
- `LC-08 private_route`: The local-only `teamplay_deepseek` wrapper inherits the
  same recovery path while retaining its exact model, max effort, and private
  distribution boundary.

## Scope and non-goals

- Writable public surfaces: Teamplay lifecycle, workflow, delivery, reporting,
  templates, docs, version, changelog, fixtures, and validator.
- Writable private surface: installed local `teamplay_deepseek` skill, spec,
  changelog, report, and validator.
- Non-goals: changing Luna/Sol routing, pool limits, Luna max, child-local Fast,
  the DeepSeek model ID, publicizing DeepSeek, pricing, or repair limits.

## Observable acceptance

- Silence first produces one bounded wait tied to an expected checkpoint.
- The wait boundary requires inspection of both real repository diff and latest
  host-observed agent state.
- No progress produces at most one redirect to the same agent ID and same whole
  outcome.
- A second no-progress boundary produces `CODER_STALLED` and Lead takeover, not
  another Coder, file/component packet, or hidden repair slot.
- Child mutation authority ends before Lead takeover; a late child response
  cannot write concurrently.
- The Lead records the locked requirement/acceptance checklist before editing,
  then separately records spec review, engineering review, and acceptance QA.
- Public bundle/installed validation and local private static/full validation
  pass without a new subagent invocation.

## Frozen contracts and invariants

- The current main conversation agent remains the only Lead.
- Every Luna implementation child remains max; Fast remains child-local.
- Initial child assignments contain one canonical execution capsule;
  continuation messages contain none.
- Review and QA share at most two in-spec repair slots; a stall and Lead takeover
  consume neither.
- A changed spec, authority, route, frozen contract, or ownership boundary
  replans before mutation.

## Validation

- `./scripts/validate.sh --bundle`
- `./scripts/install.sh`
- `./scripts/validate.sh --installed`
- `git diff --check`
- Shell and Python parsing performed by the validator
- Static lifecycle fixtures for wait, redirect, takeover, micro-packet rejection,
  and post-takeover specification review/QA
- Local `teamplay_deepseek` static and full preflight after public installation

## Unresolved items requiring user authority

- None.
