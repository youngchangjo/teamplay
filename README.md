# Teamplay

Teamplay lets the current main Codex agent keep product judgment, integration,
final specification review, and acceptance QA while GPT-5.6 Luna or Sol owns a
bounded implementation outcome.

Version 0.11 is model-aware and lifecycle-bounded:

- Luna is always max and handles work whose behavior and contracts are decided;
- Sol is selected before coding when consequential technical judgment remains;
- one ordinary outcome uses a compact Spec Brief;
- parallel or coordination-heavy work uses a Full Spec Lock;
- shared child policy is rendered once from one canonical source;
- one Coder is default, auto may choose two, and three requires an explicit
  request plus proven isolation;
- Reviewer, QA, and Gate children remain advisory;
- one coherent outcome includes its directly coupled implementation, checks,
  fixtures, docs, and configuration;
- one unchanged session key reuses one Coder identity through implementation,
  Lead feedback, and bounded in-spec repair;
- the current main Lead reviews the actual diff against the written spec and
  personally performs final QA.

## Install

```bash
git clone https://github.com/youngchangjo/teamplay.git
cd teamplay
./scripts/install.sh
```

Restart Codex or open a new task to refresh custom-agent registration.

## Entry points

| Command | Route |
|---|---|
| `$teamplay` | Luna max Standard when L1-L6 pass; otherwise authorized/spec-ready Sol max |
| `$teamplay-fast` | Same route, with child-local Fast only when Luna is selected |
| `$teamplay-deep` | Stronger invariants and evidence; same model route |
| `$teamplay-critical` | Threat- and rollback-aware spec; optional advisory Gate |

Examples:

```text
$teamplay Implement the written export Spec Brief.
$teamplay-fast Use two Luna coders for these independent locked outcomes.
$teamplay Use Sol for this bounded but ambiguous lifecycle defect.
```

## Routing order

Teamplay always evaluates:

```text
R0 authority -> R1 specification -> R2 model -> R3 writer pool
```

Unauthorized or unresolved user-authority work is blocked before model choice.
Sol is not an escape hatch for missing authority.

### Luna max

Luna is selected only when all six predicates pass:

- requirements are closed;
- acceptance is executable;
- contracts are frozen;
- consequential decision density is zero;
- remaining risk is ordinary;
- ownership and validation are bounded.

File count is not a routing signal. A mechanical 30-file propagation can fit
Luna; a two-file concurrency or ownership decision can require Sol.

### Sol max

Sol is selected proactively when a Luna predicate fails or the user directly
requests Sol, provided authority and specification readiness pass. Typical
signals are unresolved technical architecture, consequential interfaces,
security/auth/payment/permission semantics, concurrency and lifecycle,
migration/data integrity, rollback/recovery, or an ambiguous cross-component
defect.

Sol remains an implementation child. It does not take final product
interpretation, review, QA, or completion ownership from the Lead.

## Specification levels

### Spec Brief

Use [spec-brief.md](skills/teamplay/templates/spec-brief.md) for one bounded
outcome. It records requirement anchors, ownership, frozen contracts, observable
acceptance, allowed local judgment, and exact validation without a full matrix
or per-file recipe.

### Full Spec Lock

Use [spec-contract.md](skills/teamplay/templates/spec-contract.md) for parallel
writers, cross-owner coordination, consequential shared contracts, critical
risk, migration/recovery, or coordinated QA. Touching a lockfile or manifest by
itself does not force Full Lock when one Coder owns a predetermined result.

## Writer pool

| Size | Rule |
|---:|---|
| 1 | Default; shared mutable work also stays with one owner |
| 2 | Auto only for independent outcomes with frozen contracts and independent checks |
| 3 | Explicit user request plus disjoint ownership or isolated worktrees |

Never use a fourth mutating Coder in one wave. Every shared mutable surface has
one Coder owner or belongs to the Lead's serial integration step.

## Roles

| Role | Configuration | Purpose |
|---|---|---|
| Current main Lead | Current session unchanged | Spec, route, integration, final review, QA |
| `teamplay-coder` | Luna max | Clear locked implementation outcome |
| `teamplay-coder-fast` | Luna max + Fast | Same contract, accelerated child tier |
| `teamplay-coder-deep` | Sol max | Consequential technical judgment inside a locked decision space |
| `teamplay-scout` | Luna low, read-only | Targeted repository discovery |
| `teamplay-researcher` | Terra medium, read-only | Current primary-source verification |
| `teamplay-plan-challenger` | Terra high, read-only | Pre-lock contradiction challenge |
| `teamplay-reviewer` | Terra high, read-only | Advisory spec and engineering findings |
| `teamplay-qa` | Luna high | Advisory evidence collection |
| `teamplay-gate` | Sol high, read-only | Advisory critical-risk audit |

## One execution capsule

Shared authority, ownership, evidence, and escalation policy lives only in
[execution-policy.md](skills/teamplay/references/execution-policy.md). The Lead
uses [render-task-packet.py](skills/teamplay/scripts/render-task-packet.py) to
prepend the exact delimited policy block to a task capsule. The renderer reports
capsule, task, and rendered-prompt SHA-256 values.

Custom Coder prompts remain role-specific. They do not copy the global policy.
Validation requires one exact capsule in the assembled prompt and rejects
path-only or manually duplicated policy.

The lifecycle rules are documented in
[session-continuity.md](skills/teamplay/references/session-continuity.md);
the canonical execution capsule remains the only shared child-policy block.

## One outcome, one Coder session

An outcome is an independently integratable behavior or milestone, including
every directly coupled established layer. A file, command, checklist item,
focused check, Lead feedback packet, or repair is not a new outcome.

The session key is the spec ID and revision, outcome ID, route, and owned
surfaces. An unchanged key keeps the same Coder identity for implementation,
coupled checks, Lead feedback, and in-spec repair. The initial assignment has
one canonical execution capsule. A same-session continuation uses the compact
[continuation packet](skills/teamplay/templates/continuation-packet.md) and
contains no capsule copy or full-task resend.

The only restart boundaries are a new independent outcome, a changed key after
replan, an unavailable prior agent, or evidenced non-progress that persists
after one bounded redirect. Spec, authority, frozen-contract, and ownership
changes always return to the Lead before mutation. Scheduling waits for named
conditions and does not reflexively poll or duplicate active work.

Closing a completed child may free a concurrency slot, but it does not create a
new assignment. Teamplay retains the agent ID and resumes the same Coder for an
in-spec Lead review or QA repair.

Lifecycle reports distinguish spawn, message/reuse, resume, redirect, restart,
and close. Host diagnostics keep input_cached, input_uncached, output, and
reasoning counters separate; counters are diagnostics and never billing proof.

## Review, QA, and repairs

The Lead performs two review passes on the real diff:

1. requirement-by-requirement spec conformance;
2. engineering integrity and regression risk.

The Lead then executes or directly observes requirement-linked acceptance QA.
Review and QA share at most two repair slots; one is the normal expectation. A
second failure of the same requirement, a frozen-boundary change, or a third
repair request forces replanning.

## Fast and current economics

The Fast role contains both:

```toml
service_tier = "fast"

[features]
fast_mode = true
```

Fast affects only the Luna child. It does not lower intelligence or change the
Lead.

Prices are not routing constants. For context, direct official model Markdown
checked on 2026-08-02 listed Luna API input/cached/output at
`$0.20/$0.02/$1.20` per million tokens versus Sol at `$5/$0.50/$30`, a derived
`1/25` ratio. The current Codex rate card reported Luna `5/0.5/30` versus Sol
`125/12.5/750` credits, also `1/25`. Recheck before making a current cost claim:
[Luna model](https://developers.openai.com/api/docs/models/gpt-5.6-luna),
[Sol model](https://developers.openai.com/api/docs/models/gpt-5.6-sol),
[Codex rate card](https://help.openai.com/en/articles/20001106-codex-rate-card).

Lower cost supports Luna delegation only after its eligibility predicates pass.

## Validate

```bash
./scripts/validate.sh --bundle
./scripts/install.sh
./scripts/validate.sh --installed
```

The suite parses all role TOML, verifies Luna/Sol max and Fast-only settings,
renders Standard/Fast/Sol fixture prompts, checks exact capsule hashes, audits
duplicates, enforces prompt-pressure reduction, and checks installed bytes.

Routing fixtures are in [routing-fixtures.md](tests/routing-fixtures.md), with
0.11 continuity fixtures and results in tests/lifecycle-fixtures.md and
tests/lifecycle-results-v0.11.md. Live
runtime identity must come from host or agent-registry metadata. When unavailable,
the honest result is `NOT_PROVEN`, not a child-reported PASS.

## Authority

Teamplay does not itself authorize commits, pushes, merges, releases, external
writes, purchases, account/permission changes, or destructive actions.
