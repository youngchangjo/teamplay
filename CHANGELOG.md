# Changelog

All notable changes to Teamplay are documented here.

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
