# Teamplay

**Give Codex one task. Teamplay builds the right AI engineering team for it.**

Your current main Codex agent stays in charge as the Teamplay Lead. It chooses
the best GPT-5.6 specialist for each part of a coding task. You describe the
outcome once. Teamplay decides who should investigate, write code, review the
diff, run QA, or check a high-risk release.

## Why use Teamplay?

A single coding agent often has to search the repository, make a plan, edit the
code, review its own work, and run every test in one long context. That can make
the conversation noisy and the review less independent.

Teamplay separates those jobs:

- your current main agent acts as **Lead** and chooses the smallest useful team;
- a **Coder** matched to the task difficulty makes the change;
- an independent **Reviewer** checks the real diff;
- **QA** verifies tests, builds, UI, devices, or integrations when applicable;
- a **Gate** is added only for security, data, migration, deployment, or release
  risk.

You do not need to select individual agents or know which model should do each
step.

## Start in 30 seconds

```bash
git clone https://github.com/youngchangjo/teamplay.git
cd teamplay
./scripts/install.sh
```

Restart Codex or open a new task, then use:

```text
$teamplay Add a search filter and verify that it works.
```

If you are unsure which level to choose, always start with `$teamplay`.

## Choose a level

| Use this | Best for | What Teamplay does | Example |
|---|---|---|---|
| **`$teamplay`** | Most tasks; you are not sure | Automatically chooses the smallest useful team | `$teamplay Add export to CSV.` |
| **`$teamplay-fast`** | Copy, config, snapshots, or a small clear bug | Uses the fast Luna coder and a bounded review; escalates if risk appears | `$teamplay-fast Fix this button label.` |
| **`$teamplay-deep`** | Difficult bugs, refactors, architecture, or several connected modules | Investigates first, challenges the plan when needed, then performs deeper implementation, review, and QA | `$teamplay-deep Refactor the sync pipeline.` |
| **`$teamplay-critical`** | Auth, privacy, payment, data migration, deployment, release, or destructive work | Requires deep implementation, focused review, QA, and a final evidence gate | `$teamplay-critical Migrate production user data.` |

There is no separate “standard” command. `$teamplay` normally chooses the
standard Terra coder for ordinary product work and selects another lane only
when the task calls for it.

Safety rules still apply:

- Fast escalates instead of forcing an unsafe quick result.
- Deep never silently downgrades itself to Fast.
- Critical reports `PARTIAL` or `BLOCKED` when required evidence is unavailable;
  it does not pretend that a missing device, deployment, or release check passed.

## What happens after your prompt?

```text
Your request
    ↓
Lead understands the goal and risk
    ↓
Only the needed specialists are selected
    ↓
Coder → independent Reviewer → QA → optional final Gate
    ↓
One combined result with clear evidence and remaining blockers
```

The main agent remains Lead and nine specialist subagent roles are available. A
normal task uses only two to four specialists. Read-heavy work can run in
parallel; code writing stays with one agent by default to avoid shared-worktree
conflicts.

## Specialist roster

The Lead is not a subagent preset. It is the current main Codex agent using the
model and reasoning level you already selected for the session. For demanding
orchestration, Sol high is recommended but not required.

| Role | Model | Reasoning | Used when |
|---|---|---:|---|
| `teamplay-scout` | GPT-5.6 Luna | low | The relevant code or surface is unclear |
| `teamplay-researcher` | GPT-5.6 Terra | medium | Current official docs, standards, or upstream behavior matters |
| `teamplay-plan-challenger` | GPT-5.6 Terra | high | Requirements or the plan need an independent challenge |
| `teamplay-coder-fast` | GPT-5.6 Luna | max | A small, clear, low-risk change fits established patterns |
| `teamplay-coder` | GPT-5.6 Terra | high | A normal product feature spans a few files or established layers |
| `teamplay-coder-deep` | GPT-5.6 Sol | max | Complex, cross-cutting, security, concurrency, data, or migration work |
| `teamplay-reviewer` | GPT-5.6 Terra | high | A code diff needs independent review |
| `teamplay-qa` | GPT-5.6 Luna | high | Build, test, runtime, UI, or integration proof is possible |
| `teamplay-gate` | GPT-5.6 Sol | high | Security, data, payment, migration, deployment, or release risk is material |

## Why custom agent presets?

Codex sessions may expose only a subset of models through direct model
overrides. Agent presets in `~/.codex/agents/` can bind a role to an available
model and reasoning level. Teamplay uses that mechanism to make the roster
explicit and reproducible.

## Installation details

Run from the repository root:

```bash
./scripts/install.sh
```

The installer writes only Teamplay-owned paths:

```text
~/.codex/agents/teamplay-*.toml
~/.codex/skills/teamplay/
```

Restart Codex or open a new task after installation so the agent registry is
discovered again.

Validate the distribution bundle before or after installation:

```bash
./scripts/validate.sh
./scripts/validate.sh --installed
```

### Manual installation

```bash
mkdir -p ~/.codex/agents ~/.codex/skills/teamplay
cp agents/teamplay-*.toml ~/.codex/agents/
for skill in teamplay teamplay-fast teamplay-deep teamplay-critical; do
  mkdir -p "$HOME/.codex/skills/$skill"
  cp -R "skills/$skill/." "$HOME/.codex/skills/$skill/"
  cp LICENSE "$HOME/.codex/skills/$skill/LICENSE"
done
```

## Extra control

You can add normal-language constraints without using configuration syntax:

```text
$teamplay Review the plan only; do not implement.
$teamplay Implement this, but skip runtime QA because the device is unavailable.
$teamplay Treat this migration as high risk and require the final gate.
```

Explicit constraints narrow the requested work, but they do not grant permission
for releases, deletion, purchases, account changes, or other external actions.

## Operating principles

- The lead states assumptions and success criteria before implementation.
- Every child receives a minimal self-contained task packet: exact task, inputs,
  ownership, constraints, acceptance criteria, and required output.
- Agents share one worktree and must preserve unrelated user changes.
- At most four child threads run concurrently; at most three may be read-only.
- One writer is the default. Multiple coders require isolated worktrees or
  independent assignments with disjoint path ownership.
- The reviewer reads the real diff and does not implement fixes.
- High-risk review may use multiple `teamplay-reviewer` instances with separate
  task-focused axes instead of adding permanent reviewer personas.
- QA verifies executable behavior and does not silently repair product code.
- The lead uses bounded waits with backoff and does not aggressively poll agents.
- Implementation claims, review findings, QA results, and release approval are
  separate evidence layers.
- Push, merge, release, account changes, purchases, and destructive actions
  remain user-authorized operations.

## Repository layout

```text
teamplay/
├── VERSION
├── LICENSE
├── README.md
├── CHANGELOG.md
├── docs/
│   └── DESIGN.md
├── agents/
│   ├── teamplay-scout.toml
│   ├── teamplay-researcher.toml
│   ├── teamplay-plan-challenger.toml
│   ├── teamplay-coder-fast.toml
│   ├── teamplay-coder.toml
│   ├── teamplay-coder-deep.toml
│   ├── teamplay-reviewer.toml
│   ├── teamplay-qa.toml
│   └── teamplay-gate.toml
├── skills/teamplay/
│   ├── SKILL.md
│   ├── references/
│   │   ├── routing.md
│   │   ├── role-contracts.md
│   │   └── evidence-contract.md
│   └── templates/
│       ├── task-packet.md
│       ├── research-packet.md
│       ├── review-packet.md
│       └── qa-packet.md
├── skills/teamplay-fast/
│   └── SKILL.md
├── skills/teamplay-deep/
│   └── SKILL.md
├── skills/teamplay-critical/
│   └── SKILL.md
└── scripts/
    ├── install.sh
    └── validate.sh
```

## Optional concurrency setting

Teamplay enforces a four-child policy in its lead instructions. You can also
set a matching runtime ceiling manually without letting the installer modify
your global configuration:

```toml
[agents]
max_concurrent_threads_per_session = 4
```

## Distribution notes

The current release is `0.4.0`. Before publishing it publicly, test installation
on a clean Codex profile. Model availability, reasoning levels, custom agent
discovery, and sandbox behavior are runtime capabilities. Run the installed
validation and a small read-only smoke task on each supported Codex surface.

See [DESIGN.md](docs/DESIGN.md) for the selection rationale and known runtime
tradeoffs, and [CHANGELOG.md](CHANGELOG.md) for release history.

## Scope

Teamplay orchestrates Codex subagents. It does not provide a remote job queue,
separate Git worktrees, CI hosting, or permission to perform external release
operations.

## License

Teamplay is available under the [MIT License](LICENSE).
