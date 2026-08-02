# Spec Brief: Coder outcome and session continuity

## Identity

- Spec ID and revision: `TP-CODER-LIFECYCLE-001`, revision 1
- Repository baseline: `3ac50b6` plus the preserved, uncommitted Teamplay 0.10
  package update
- Implementation owner: current main agent; Teamplay was not invoked to make
  this package change
- Spec level: `brief`
- Coder count: zero for this maintenance change

## Outcome and requirement anchors

- One completion sentence: Teamplay delegates one coherent implementation
  outcome to one persistent Coder session and reuses that session for dependent
  follow-up and bounded repair instead of spawning a new Coder per file, command,
  checklist item, or test failure.
- `LC-01 outcome_granularity`: An outcome is an independently integratable
  behavior or milestone and includes its directly coupled established code,
  tests, fixtures, docs, and configuration.
- `LC-02 session_continuity`: The session key is spec ID/revision, outcome ID,
  route, and owned surfaces. An unchanged key reuses the same agent ID through
  implementation, focused checks, Lead review feedback, and in-spec repair.
- `LC-03 restart_boundary`: A fresh Coder is allowed only for a new independent
  outcome, a changed session key after replan, an unavailable prior agent, or
  evidenced non-progress that persists after one bounded redirect.
- `LC-04 lean_continuation`: An existing Coder receives a compact continuation
  packet. The canonical execution capsule and full initial task are not resent.
- `LC-05 scheduling`: Parallel Coders remain limited to independent outcomes;
  the Lead avoids duplicate work and reflexive wait polling.
- `LC-06 evidence`: Run reports distinguish spawn, message/reuse, resume,
  redirect, restart, and close events. Host token counters separate cached,
  uncached, output, and reasoning values and never imply provider billing.
- `LC-07 private_route`: The local-only `teamplay_deepseek` wrapper inherits and
  explicitly reinforces the same lifecycle while retaining its exact model,
  max effort, and private distribution boundary.

## Scope, ownership, and non-goals

- Writable public surfaces: Teamplay skill/reference/template documentation,
  package docs/version/changelog, validation script, routing fixtures/results,
  and render fixtures.
- Writable private surface: installed local `teamplay_deepseek` skill and its
  local run evidence.
- Shared-surface owner: current main agent for the public package and local
  private synchronization.
- Non-goals: changing Luna/Sol eligibility, the three-writer cap, Luna max,
  child-local Fast, Lead authority, publicizing DeepSeek, or changing prices.

## Canonical context

- Point-in-time regression evidence: one Itssle run created and closed ten
  DeepSeek Coders for one spec revision while splitting theme, components,
  exact edits, tests, repairs, shell, and shell tests into serial tasks. Host
  counters recorded about 2.39M cumulative input tokens, about 2.22M cached.
- Current host collaboration supports messaging an existing agent and resuming
  a closed agent; completion does not require a fresh spawn.
- OpenAI multi-agent guidance favors independent bounded work, notes that more
  subagents can increase token usage, and provides follow-up work on an existing
  agent without deleting its context.
- OpenAI GPT-5.6 guidance recommends lean prompts, one statement per policy,
  persisted reasoning while goals stay stable, and representative evals.

## Observable acceptance

- `LC-01` inspection: no public policy treats a file, layer, exact code fragment,
  command, checklist item, or repair as a new outcome by itself.
- `LC-02` inspection: initial spawn and same-key continuation/resume behavior are
  explicit and keep one agent ID.
- `LC-03` inspection: restart conditions are finite, evidence-based, and do not
  silently preserve stale authority or ownership.
- `LC-04` inspection: a compact continuation template exists and does not copy
  the canonical execution capsule.
- `LC-05` inspection: scheduling forbids reflexive polling and duplicate Lead
  implementation while preserving independent parallelism.
- `LC-06` inspection: report template captures lifecycle counts and honest token
  diagnostics.
- `LC-07` inspection: the local DeepSeek wrapper contains the continuity rule,
  remains local-only, and still pins the exact route at max.

## Frozen contracts and invariants

- The current main conversation agent remains the only Lead and personally
  reviews the actual diff against the written spec and performs acceptance QA.
- Every Luna implementation child remains max. Fast remains child-local.
- Initial child assignments contain exactly one source-identical canonical
  execution capsule; continuation messages contain none.
- Review and QA continue to share at most two in-spec repair slots.
- A spec, authority, route, frozen-contract, or ownership change replans before
  mutation; session reuse never bypasses that boundary.

## Allowed local judgment and escalation

- Observationally equivalent wording, template layout, fixture naming, and
  validation implementation are allowed.
- Return to the Lead if the compact continuation requires a second global policy
  source, if prompt-pressure regression exceeds the existing limit, or if local
  DeepSeek synchronization would change provider/model identity.

## Validation

- `./scripts/validate.sh --bundle`
- `./scripts/install.sh`
- `./scripts/validate.sh --installed`
- `git diff --check`
- Shell and Python parsing performed by the validator
- Static lifecycle and routing fixtures, including same-session repair and fresh
  restart boundaries
- Static local DeepSeek validation after the public Teamplay copy is installed;
  no subagent invocation is required for this maintenance change

## Unresolved items requiring user authority

- None.
