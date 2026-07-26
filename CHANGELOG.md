# Changelog

All notable changes to Teamplay are documented here.

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
