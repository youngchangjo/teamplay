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

For UI work, QA actively uses the in-app Browser for web flows and Computer Use
for native apps, Simulator windows, and system UI. It captures visible
before/after evidence instead of stopping at a successful build. To keep normal
development fast, dedicated QA runs only at a meaningful milestone or final
gate—not after every small edit.

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

Every run ends with a **Teamplay Run Report**. It tells you which specialists
were used, their configured models and reasoning levels, why they were selected,
how work moved through implementation, review, and QA, and what should be tuned
next time. If no subagent was needed, the report says that too.

Example:

```text
Teamplay Run Report
Preset: deep · Status: COMPLETE
Team: Scout (Luna low) → Deep Coder (Sol max) → Reviewer (Terra high) → QA (Luna high)
Result: 4 files changed · review passed after 1 repair · 12 tests passed
Routing note: Deep Coder was selected because the change crossed concurrency boundaries.
```

## Specialist roster

The Lead is not a subagent preset. It is the current main Codex agent using the
model and reasoning level you already selected for the session. For demanding
orchestration, Sol high is recommended but not required.

| Role | Model | Reasoning | Used when |
|---|---|---:|---|
| `teamplay-scout` | GPT-5.6 Luna | low | The relevant code or surface is unclear |
| `teamplay-researcher` | GPT-5.6 Terra | medium | Current official docs, standards, or upstream behavior matters |
| `teamplay-plan-challenger` | GPT-5.6 Terra | high | Requirements or the plan need an independent challenge |
| `teamplay-coder-fast` | GPT-5.6 Luna | max | Owns one complete small, clear, low-risk outcome |
| `teamplay-coder` | GPT-5.6 Terra | high | Owns one complete product vertical slice across required layers |
| `teamplay-coder-deep` | GPT-5.6 Sol | max | Owns one complete complex, cross-cutting, security, concurrency, data, or migration goal |
| `teamplay-reviewer` | GPT-5.6 Terra | high | A code diff needs independent review |
| `teamplay-qa` | GPT-5.6 Luna | high | Build, test, in-app Browser, Computer Use, runtime, UI, device, or integration proof is possible |
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

## Faster delivery

Teamplay assigns outcomes, not tiny file-by-file chores.

- One Coder owns a complete vertical slice, including every directly required
  UI, domain, data, integration, test, documentation, and configuration change.
- Routine adjacent files and conventional implementation choices do not require
  another Lead handoff.
- Scout is skipped when the Coder can discover the code inside a known area.
- Plan Challenger is skipped for clear, ordinary-risk work using established
  patterns.
- Reviewer checks the stable completed slice once and batches findings into one
  repair packet.
- Dedicated Browser, Computer Use, Simulator, device, and integration QA runs at
  a major gate rather than after every small edit.

The intended cadence is:

```text
complete implementation slice
→ independent review
→ one batched repair when needed
→ focused re-review
→ one major QA gate
→ optional critical Gate
```

Teamplay still uses one writer by default in a shared worktree. Multiple Coders
are used only for independently deliverable slices with disjoint ownership or
isolated worktrees; coordination overhead is not treated as speed.

## Run reports

The final report always separates configured model routing from runtime proof.
An agent's own statement about its model is not accepted as evidence. When the
runtime does not expose the main model, the report says `runtime metadata not
exposed` instead of guessing.

Each report includes:

- entry point, resolved preset, and overall status;
- every agent instance, configured model and effort, assignment, reason, and
  result;
- handoff order, parallel work, escalation, retries, and repair loops;
- changed paths, artifacts, review, QA, gate, and release evidence;
- omitted roles, unverified surfaces, and user-authorized next actions;
- observable routing notes that can guide later Teamplay improvements.

The report always appears inline in the final response. When you provide a
report path or the task already has an evidence directory, Teamplay also saves a
copy there; it does not add report files to unrelated repositories by default.

## Interactive QA

Teamplay does not treat “the build passed” as proof that a UI works.

It also does not run expensive UI QA after every change. The Lead starts QA at
one of these larger gates:

- an integrated feature is stable;
- a complete user-visible flow is ready;
- the branch is ready to merge;
- a release candidate is ready;
- critical work needs final evidence before Gate.

During implementation, Coders still run narrow unit tests, lint, typecheck, and
targeted smoke checks. Related Browser, Computer Use, Simulator, device, and
integration scenarios are then bundled into one QA gate run.

- Web apps and browser flows use `browser:control-in-app-browser`, preferring the
  in-app Browser when available and no different browser was explicitly chosen.
- Native macOS apps, iOS Simulator windows, installed apps, and system dialogs
  use purpose-built tools first and `computer-use:computer-use` for visible UI
  interaction and screenshots.
- QA records the URL or app, exact actions, expected and actual visible state,
  screenshots or equivalent artifacts, and what the selected surface cannot
  prove.
- Passing evidence for an unchanged target may be reused. After a repair, QA
  reruns affected failed scenarios first instead of repeating every expensive
  scenario automatically.
- Browser simulation, native Simulator, installed app, physical device,
  deployment, and release evidence remain separate finish lines.
- Consequential UI actions still follow confirmation and user-authorization
  rules; QA never purchases, publishes, creates credentials, accepts legal
  terms, or permanently deletes data just to finish a scenario.

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
│   │   ├── evidence-contract.md
│   │   ├── reporting.md
│   │   ├── qa-surfaces.md
│   │   └── delivery-speed.md
│   └── templates/
│       ├── task-packet.md
│       ├── research-packet.md
│       ├── review-packet.md
│       ├── qa-packet.md
│       └── final-report.md
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

The current release is `0.8.0`. Before publishing it publicly, test installation
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
