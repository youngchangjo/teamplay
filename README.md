# Teamplay

Adaptive multi-model engineering teams for Codex.

Teamplay is a Codex skill and a set of custom agent presets that assemble the
smallest useful engineering team for each task. It does not spawn every role on
every run. A Sol team lead classifies the work, delegates bounded assignments,
and combines independent implementation, review, and QA evidence.

## Team

| Role | Model | Reasoning | Used when |
|---|---|---:|---|
| `teamplay-lead` | GPT-5.6 Sol | high | Every Teamplay run |
| `teamplay-scout` | GPT-5.6 Luna | low | The relevant code or surface is unclear |
| `teamplay-researcher` | GPT-5.6 Terra | medium | Current official docs, standards, or upstream behavior matters |
| `teamplay-plan-challenger` | GPT-5.6 Terra | high | Requirements or the plan need an independent challenge |
| `teamplay-coder-fast` | GPT-5.6 Luna | max | A small, clear, low-risk change fits established patterns |
| `teamplay-coder` | GPT-5.6 Terra | high | A normal product feature spans a few files or established layers |
| `teamplay-coder-deep` | GPT-5.6 Sol | max | Complex, cross-cutting, security, concurrency, data, or migration work |
| `teamplay-reviewer` | GPT-5.6 Terra | high | A code diff needs independent review |
| `teamplay-qa` | GPT-5.6 Luna | high | Build, test, runtime, UI, or integration proof is possible |
| `teamplay-gate` | GPT-5.6 Sol | high | Security, data, payment, migration, deployment, or release risk is material |

The default route is adaptive:

```text
Small fix       Lead -> Fast Coder -> Reviewer
Normal feature  Scout? -> Lead -> Standard Coder -> Reviewer -> QA
External API    Researcher -> Lead -> Standard Coder -> Reviewer -> QA
Ambiguous work  Scout? -> Lead -> Plan Challenger -> Standard/Deep Coder -> Reviewer -> QA
High risk       Scout?/Researcher? -> Lead -> Plan Challenger -> Deep Coder -> Reviewer -> QA -> Gate
Read-only ask   Lead, with Scout, Researcher, or Challenger only when useful
```

Ten roles are installed, but a normal run activates only three to five. The
catalog is a routing menu, not a fixed ceremony.

## Why custom agent presets?

Codex sessions may expose only a subset of models through direct model
overrides. Agent presets in `~/.codex/agents/` can bind a role to an available
model and reasoning level. Teamplay uses that mechanism to make the roster
explicit and reproducible.

## Install

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

## Usage

Choose an entry point and describe the outcome. No trailing mode argument is
required:

```text
$teamplay Fix the token refresh race and verify the regression.
$teamplay-fast Update this copy and its snapshot.
$teamplay-deep Refactor the synchronization pipeline and verify it thoroughly.
$teamplay-critical Perform this data migration with every evidence gate.
```

Entry points:

| Skill | Preset | Behavior |
|---|---|---|
| `$teamplay` | auto | Select the smallest useful roster |
| `$teamplay-fast` | fast | Prefer Luna max Fast Coder and bounded review |
| `$teamplay-deep` | deep | Favor discovery, challenge, deeper implementation, review, and QA |
| `$teamplay-critical` | critical | Require Deep Coder, focused review, QA, and Gate for mutations |

Natural-language constraints can still override or narrow the router:

```text
$teamplay Review the plan only; do not implement.
$teamplay Implement this, but skip runtime QA because the device is unavailable.
$teamplay Treat this migration as high risk and require the final gate.
```

The Fast preset escalates instead of forcing an unsafe completion when it finds
security, data, migration, destructive, or irreversible risk. Deep does not
silently downgrade to Fast. Critical reports blocked or partial when a required
evidence surface is unavailable rather than weakening the gate.

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
│   ├── teamplay-lead.toml
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

The current release is `0.3.0`. Before publishing it publicly, test installation
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
