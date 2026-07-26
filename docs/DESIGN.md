# Teamplay design rationale

Teamplay is a manager-style Codex orchestration skill. The current main agent
owns the user conversation, acts as Lead, and performs final synthesis; Lead is
never spawned as a subagent. Narrow specialist agents perform bounded work. The
installed roster is intentionally larger than the active roster so routing can
match the actual task without spawning an agent swarm.

## Selection principles

1. Start with the lead and add a role only for concrete work.
2. Prefer parallel read-heavy work over parallel writes.
3. Give each child a minimal local contract instead of parent-level workflow
   philosophy.
4. Use one writer in a shared worktree by default.
5. Select implementation capability by failure cost and breadth, not file count
   alone.
6. Keep implementation, review, QA, gate, and release evidence separate.
7. Use task-focused review axes instead of accumulating overlapping personas.

## Entry points

Teamplay exposes four skill names instead of requiring a trailing mode option:

- `$teamplay`: automatic routing;
- `$teamplay-fast`: small, clear, low-risk work;
- `$teamplay-deep`: complex implementation or thorough investigation;
- `$teamplay-critical`: high-risk work with mandatory evidence gates.

The three preset skills are thin wrappers. Each loads the same core Teamplay
skill and supplies one `requested_preset`, so routing and safety logic remain in
one maintained source. Fast may escalate for safety, Deep does not silently
downgrade to Fast, and Critical cannot convert a missing required surface into a
pass.

## Model rationale

- The Lead keeps the model and reasoning effort selected for the current main
  session. Sol high is recommended for demanding orchestration, but Teamplay
  does not override the user's main-model choice.
- Luna low handles bounded local discovery.
- Terra medium handles current external research where source evaluation matters.
- Luna max handles small, well-specified implementation efficiently.
- Terra high is the standard implementation and review tier.
- Sol max is reserved for deep implementation where failure is expensive.
- Luna high executes procedural QA on explicit scenarios.
- Sol high performs an independent final gate for material risk.

Reasoning effort scales work within a model; it does not make a smaller model
universally stronger than a larger tier. Teamplay therefore treats Luna max as
the fast bounded implementation lane, not the default for all coding.

## Research basis

- [OpenAI Codex Subagents](https://learn.chatgpt.com/docs/agent-configuration/subagents)
  recommends narrow custom agents, bounded prompts, parallel read-heavy work,
  and caution with parallel writes.
- [OpenAI practical guide to building agents](https://cdn.openai.com/business-guides-and-resources/a-practical-guide-to-building-agents.pdf)
  recommends starting with a single agent and using a manager pattern when
  specialization materially helps.
- [OpenAI Symphony](https://openai.com/index/open-source-codex-orchestration-symphony/)
  emphasizes task dependencies, isolated workspaces, evidence, and objectives
  over rigid agent state machines.
- [GPT-5.6 model guidance](https://developers.openai.com/api/docs/guides/latest-model)
  positions Sol for demanding work, Terra for balanced capability and cost, and
  Luna for efficient high-volume work.
- Community reports consistently value read-only exploration, focused review,
  and explicit task packets, while warning about token burn, aggressive polling,
  unclear delegation prompts, and conflicting parallel writers.

Community experience is anecdotal rather than benchmark evidence. Teamplay's
model routing should eventually be evaluated on representative repositories
using completion rate, reviewer defects, rework count, elapsed time, and token
usage.

## Runtime limitations

- Custom agent discovery can vary across Codex surfaces and versions. Restart or
  open a new task after installation and run `scripts/validate.sh --installed`.
- Lead does not depend on custom-agent discovery because it is the current main
  agent. Only the nine specialist presets need to be discovered after install.
- A valid TOML file proves configuration syntax, not which model actually ran.
  Route using the registered agent type and runtime metadata where available;
  do not trust model self-identification in prose.
- Parent permission and sandbox overrides may take precedence over custom agent
  defaults. Read-only role instructions remain a second safety layer.
- Teamplay does not create isolated worktrees itself. The lead must keep one
  writer or use a runtime-provided isolated worktree before parallel writes.
