# Changelog

All notable changes to Teamplay are documented here.

## 0.11.0 — 2026-08-02

- Status: `complete`; public lifecycle policy, bundle/installed validation, and
  local private-route synchronization pass.
- Point-in-time regression evidence: one spec revision produced ten serial
  DeepSeek Coder spawn/close cycles, ten follow-up messages, and 43 waits while
  file, exact-edit, test, and repair steps were treated as new assignments.
- Corrected the default to preserve one Coder session for one coherent outcome and
  its focused checks and bounded repairs; use a compact continuation message and
  create a fresh Coder only at an explicit restart boundary.
- Added the public continuity contract for one independently integratable
  outcome, a stable session key, same-session Lead feedback and repairs, and
  finite evidence-based restart boundaries.
- Defined close as concurrency-slot management rather than a replacement-Coder
  boundary; an in-spec repair resumes the retained agent ID.
- Added a capsule-free continuation packet, lifecycle event reporting, and
  host token diagnostics that keep cached, uncached, output, and reasoning
  counters separate without inferring provider billing.
- Replaced micro-instruction fields with a requested-result continuation and
  validator coverage that rejects `exact_next_action`.
- Added versioned 0.11 fixtures and results for continuity, restart, rendering,
  and lifecycle diagnostics.
- Validation evidence: `./scripts/validate.sh --bundle` and `--installed`, local
  `teamplay_deepseek` static and full preflight, shell parsing, and
  `git diff --check` pass. Installed public skill bytes match the bundle.
- Runtime limitation: no new lifecycle canary was run; existing DeepSeek route
  entitlement evidence remains valid but does not by itself prove same-ID
  continuation behavior. No push, merge, or release was performed.
- Canonical specification:
  `docs/specs/TP-CODER-LIFECYCLE-001-r1.md`.

## 0.10.0 — 2026-08-02

- Status: `partial`; local implementation, bundle/install validation, renderer
  checks, and main-agent static routing classification are complete. Fresh-task
  live Coder identities and external implementation conformance remain pending.
- Kept every Luna implementation child on GPT-5.6 Luna max and preserved
  child-local Fast without changing the Lead.
- Replaced rescue-only Sol with proactive Sol max routing when consequential
  technical judgment remains or the user directly requests Sol.
- Added R0-R3 routing precedence so authority and written-spec readiness are
  resolved before model and writer-pool selection.
- Added semantic Luna L1-L6 eligibility based on closed requirements,
  executable acceptance, frozen contracts, zero consequential decision density,
  ordinary risk, and bounded ownership.
- Split the written specification into a compact Spec Brief and coordination-
  or risk-triggered Full Spec Lock.
- Added one canonical delimited execution capsule plus a production renderer
  that reports capsule, task, and rendered-prompt SHA-256 values.
- Removed repeated global policy from Coder roles and replaced the nine-field
  output with a compact six-field envelope.
- Unified Lead review and Lead QA under one maximum-two repair budget with
  explicit replanning triggers.
- Added the required Fast feature flag, 14 routing fixtures, Standard/Fast/Sol
  render fixtures, and the saved 0.9 prompt-pressure baseline.
- Updated public documentation against current OpenAI GPT-5.6, subagent, Fast,
  and pricing guidance. Latest direct model docs observed Luna at 1/25 of Sol
  token price after the 2026-08-01 reduction; prices remain non-normative.
- GPT-5.6 Sol Pro architect result: `PLAN APPROVE` after three bounded packets in
  one reused ChatGPT conversation.
- Validation evidence: `./scripts/validate.sh --bundle` and `--installed`, TOML
  parsing, script syntax, renderer delimiter/hash equality, `git diff --check`,
  and 14/14 Lead routing classifications pass. Non-task policy characters fell
  by 37.5% Standard, 37.7% Fast, and 37.6% Sol from the saved 0.9 baseline.
- Limitations and next gate: `LC-STD`, `LC-FAST`, and `LC-SOL` remain
  `NOT_PROVEN` until a new Codex task loads 0.10 and exposes host-observed run
  metadata. GPT Pro `IMPLEMENTATION_CONFORMANCE` review is pending. No commit,
  push, merge, or release was performed.

## 0.9.0 — 2026-08-02

- Made the current main agent the sole owner of canonical specification lock,
  final code review, acceptance QA execution, and completion verdicts.
- Added a requirement coverage contract with stable specification anchors,
  non-goals, invariants, frozen interfaces, and requirement-linked QA evidence.
- Changed the Standard Coder from Terra high to Luna max and expanded both Luna
  Coder presets to large, independently integratable vertical slices.
- Reinterpreted `$teamplay-fast` as agent-local Fast service tier for Luna
  implementation children without reducing scope, reasoning, review, or QA.
- Added an automatic one-or-two Coder pool and an explicit maximum-three mode
  guarded by independent outcomes, frozen interfaces, and safe isolation.
- Kept the Sol Coder as an explicit rescue lane only after a demonstrated Luna
  capability blocker or direct user request.
- Demoted Reviewer, QA, and Gate children to optional advisory helpers that
  cannot issue final review, QA, completion, or release verdicts.
- Added specification, Lead review, and Lead QA templates and expanded the final
  report with pool configuration and requirement coverage.
- Updated bundle and installed-copy validation for Teamplay 0.9.0.
- Validation evidence: `./scripts/validate.sh --bundle`,
  `./scripts/validate.sh --installed`, `git diff --check`, and shell syntax checks
  for both scripts pass; the installed copy matches the bundle byte for byte.
- Validation limitation: the `skill-creator` quick validator is not present in
  the installed skill package, and the current task retains the pre-install
  agent registry until Codex refreshes it.
- Next gate: restart Codex or open a new task, then verify a Standard and Fast
  dry run report the new large-slice, spec-first contracts and that Fast applies
  only to the Luna child.

## 0.8.0 — 2026-07-26

- Expanded Coder ownership from file-sized tasks to complete user-visible or
  integratable vertical slices.
- Allowed Coders to handle every directly required layer, test, snapshot,
  document, and configuration file within the approved outcome.
- Reduced routine Lead handoffs by letting Coders resolve reversible low-risk
  details from repository conventions.
- Skipped Scout and Plan Challenger when they do not materially unblock clear,
  ordinary-risk work.
- Moved review to stable completed slices and batched findings into one repair
  packet and focused re-review.
- Added `references/delivery-speed.md`, expanded task and review packets, and
  added slice and handoff observations to the final report.

## 0.7.0 — 2026-07-26

- Moved dedicated QA execution to named major gates instead of running it after
  every edit, commit, or small repair.
- Defined integrated-feature, user-visible-milestone, pre-merge, pre-release,
  and critical-final-evidence QA gates.
- Kept unit tests, lint, typecheck, and narrow smoke checks with Coders for fast
  implementation feedback.
- Added scenario coalescing, exact target identity, focused failure reruns, and
  valid evidence reuse to reduce repeated Browser, Computer Use, Simulator,
  device, and integration work.
- Added QA gate name, execution count, reused evidence, and invalidated evidence
  to packets and final reports.

## 0.6.0 — 2026-07-26

- Made QA actively use `browser:control-in-app-browser` for web and browser
  flows, preferring the in-app Browser when appropriate.
- Added `computer-use:computer-use` for native macOS UI, iOS Simulator windows,
  installed apps, and system dialogs after purpose-built surfaces.
- Added interactive before/after state, action sequence, screenshot, console,
  network, and surface-limitation evidence requirements.
- Kept browser simulation, native Simulator, installed app, physical device,
  deployment, and release proof as separate finish lines.
- Added `references/qa-surfaces.md` and expanded QA and final-report packets.

## 0.5.0 — 2026-07-26

- Added a mandatory Teamplay Run Report to every invocation, including
  read-only, failed, blocked, and no-subagent runs.
- Added registered agent type, configured model and reasoning provenance,
  assignment, selection reason, result, handoff flow, evidence, omissions, and
  routing observations to the final report contract.
- Prohibited model self-identification, guessed token usage, and hidden
  chain-of-thought from being presented as operational evidence.
- Added `references/reporting.md` and `templates/final-report.md` for consistent
  reports that can support later routing improvements.

## 0.4.0 — 2026-07-26

- Reworked the top of the README around three beginner questions: why to use
  Teamplay, how to start, and which level to choose.
- Added plain-language level comparisons, concrete examples, safety behavior,
  and a simple end-to-end workflow before the technical agent roster.
- Moved Teamplay Lead ownership to the current main conversation agent.
- Removed the `teamplay-lead` custom subagent preset and its extra nested handoff.
- Kept the user's selected main model and reasoning effort; Sol high is now a
  recommendation rather than a hard-wired Lead configuration.
- Added an exact installer migration that removes only the obsolete
  `~/.codex/agents/teamplay-lead.toml` file from earlier versions.

## 0.3.0 — 2026-07-26

- Added `$teamplay-fast`, `$teamplay-deep`, and `$teamplay-critical` as thin
  preset entry skills.
- Kept `$teamplay` as the automatic default with no trailing mode syntax.
- Added mandatory safety escalation for Fast, no silent Fast downgrade for
  Deep, and evidence-layer requirements for Critical.
- Updated installation and validation to cover all four skill directories and
  their installed MIT license copies.
- Preserved one core orchestration implementation to avoid duplicated routing
  logic across shortcut skills.

## 0.2.0 — 2026-07-26

- Changed the default lead from GPT-5.6 Sol xhigh to Sol high.
- Added `teamplay-researcher` with Terra medium for current primary-source
  research.
- Split implementation into three adaptive tiers:
  - `teamplay-coder-fast`: Luna max;
  - `teamplay-coder`: Terra high;
  - `teamplay-coder-deep`: Sol max.
- Added read-only sandbox defaults to Scout, Researcher, Plan Challenger,
  Reviewer, and Gate.
- Limited default concurrency to four children, three read-only children, and
  one writer in a shared worktree.
- Added task-focused parallel review lanes without multiplying reviewer
  personas.
- Added bounded wait and polling guidance.
- Added design rationale, research packet, distribution validation, and
  installed-copy validation.
- Added the MIT License.

## 0.1.0 — 2026-07-26

- Initial adaptive Teamplay skill.
- Added Lead, Scout, Plan Challenger, Coder, Reviewer, QA, and Gate roles.
- Added routing, role, evidence, and packet contracts.
- Added local installation script.
