---
name: teamplay
description: Let the current main Codex agent lead an adaptive GPT-5.6 engineering team using Luna fast specialists, Terra standard implementers and reviewers, optional Sol deep implementation, and an evidence-based final gate. Use when the user says "$teamplay", "use Teamplay", asks for an adaptive multi-agent team, or wants implementation, independent review, and QA divided among model-specific subagents.
version: 0.6.0
---

# Teamplay

Teamplay forms the smallest useful team for the task. It does not equate more
agents with better work.

## Required references

Before routing a Teamplay request, read all five files:

- `references/routing.md`
- `references/role-contracts.md`
- `references/evidence-contract.md`
- `references/reporting.md`
- `references/qa-surfaces.md`

Use the packet templates when delegating research, implementation, review, or
QA. Use `templates/final-report.md` to close every Teamplay run.

## Entry contract

When this skill is invoked:

1. You, the current main agent handling the user's conversation, are the
   Teamplay Lead. Keep ownership of interpretation, routing, user updates,
   conflict resolution, and final synthesis.
2. Never spawn or delegate to a separate `teamplay-lead`. Teamplay intentionally
   has no Lead subagent preset.
3. Use the model and reasoning effort already selected for the current main
   session. Teamplay does not silently replace or override the user's main model.
4. Apply the Lead workflow below and spawn only the bounded specialist roles it
   selects.

## Lead workflow

### 1. Establish the baseline

- Read applicable `AGENTS.md` and repository instructions.
- Inspect current branch, worktree status, relevant files, and available test or
  runtime surfaces when the request concerns a repository.
- Preserve unrelated and user-owned changes.
- State assumptions, scope, and verifiable success criteria.

Read-only inspection is allowed. Do not mutate product files during this step.

### 2. Classify the task

Evaluate these dimensions:

- `mutation`: none, docs/config, code, or external state.
- `discovery`: known location or investigation required.
- `external_dependency`: current documentation, standards, upstream source, or
  version-specific behavior must be verified.
- `ambiguity`: clear, competing interpretations, or unresolved requirements.
- `breadth`: one spot, several files in established layers, or cross-cutting.
- `implementation_depth`: small and mechanical, standard product work, or deep
  work involving architecture, concurrency, security, data, or migration.
- `verification`: static, tests/build, runtime/UI, device, or external surface.
- `risk`: ordinary, security, privacy, auth, payment, data loss, migration,
  deployment, release, or irreversible external action.

Honor explicit user routing constraints and a shortcut skill's requested preset
before automatic routing.

### 3. Select the roster

Use only roles with concrete work:

- `teamplay-scout`: discovery is required.
- `teamplay-researcher`: current official documentation, standards, upstream
  source, or external version-specific behavior affects the result.
- `teamplay-plan-challenger`: ambiguity, architectural choice, cross-cutting
  change, or high risk makes an independent pre-implementation challenge useful.
- `teamplay-coder-fast`: a small, well-specified, low-risk change fits existing
  patterns. Escalate if the implementation exposes broader design work.
- `teamplay-coder`: standard product implementation spans a few files or
  established layers and benefits from balanced capability.
- `teamplay-coder-deep`: complex, cross-cutting, security, concurrency, data,
  or migration implementation requires frontier reasoning.
- `teamplay-reviewer`: review every non-trivial code change. It may be skipped
  for prose-only or trivial mechanical edits when the lead records why.
- `teamplay-qa`: executable verification is available or specifically requested.
  For UI work, route QA to the in-app Browser, Browser, or Computer Use surface
  according to `references/qa-surfaces.md`; do not stop at unit or build output
  when an interactive surface is available and relevant.
- `teamplay-gate`: material security, payment, privacy, migration, deployment,
  release, destructive, or irreversible risk remains after review and QA.

Select one coder by default. Do not spawn agents merely to restate work already
completed by another role.

### 4. Announce the team

Before spawning children, tell the user which roles are being used, why, and
which roles were intentionally omitted. Keep the update concise.

### 5. Delegate bounded work

- Use `fork_turns: "none"` and minimal self-contained messages. Include only the
  exact task, necessary inputs, owned paths, constraints, acceptance criteria,
  and required output. Keep parent orchestration policy out of child packets.
- Tell every mutating child that other agents share the worktree and it must not
  revert or overwrite unfamiliar changes.
- Keep at most four child threads active concurrently and at most three
  read-only children in parallel.
- Default to one writer. Multiple coders are allowed only when assignments are
  independent and owned paths do not overlap or use isolated worktrees.
- Parallelize read-heavy discovery, research, triage, or review axes. Be
  conservative with parallel write-heavy work.
- Respect dependencies: challenge before coding; review after the diff exists;
  QA after the intended implementation is stable; gate after review and QA.
- Give QA the exact target URL, app, Simulator or device, primary flow, boundary
  cases, expected observables, and evidence directory when known. Require it to
  name the actual surface and its proof limitations.
- Do not poll running agents aggressively. Use bounded waits and back off when
  no new mailbox state arrives. A timeout alone is not a failure.

### 6. Close the loop

- If the challenger returns `REVISE`, resolve the objections before coding.
- If the reviewer returns `REQUEST_CHANGES`, send concrete findings back to the
  owning coder, then request a focused re-review.
- For a high-risk review, reuse `teamplay-reviewer` with separate, bounded
  assignments such as outcome completeness, correctness and regressions, or
  security and concurrency. Do not create extra reviewer personas merely to
  rename a review axis.
- If QA fails because of the implementation, return the failure to the coder and
  rerun the affected review and QA after repair.
- Do not use the gate to replace missing review or QA.
- Stop and ask the user when a decision changes scope materially or requires new
  authority.

### 7. Report the outcome

Separate:

- implementation status;
- review status;
- QA/runtime status;
- gate or release status;
- remaining blockers and user-authorized next actions.

Never call a build-only result a runtime, device, deployment, or release pass.

Every Teamplay run must end with a `Teamplay Run Report`, including read-only,
failed, blocked, or no-subagent runs. Follow `references/reporting.md` and
`templates/final-report.md`.

The report must make later routing improvements possible without exposing hidden
chain-of-thought. Record concise decisions and observable evidence, not private
reasoning. At minimum include:

- requested entry point and resolved preset;
- current main agent as Lead, with its model or reasoning only when runtime
  metadata confirms them;
- every spawned agent instance, registered `agent_type`, configured model and
  reasoning effort, assignment, selection reason, and result;
- roles considered but intentionally omitted, with a concise reason;
- handoff order, retries, escalations, and review or QA repair loops;
- changed paths or delivered artifacts;
- exact verification, review, QA, and gate verdicts;
- interactive QA surfaces used, decisive actions, screenshots or other visual
  evidence, and what those surfaces did not prove;
- remaining blockers, unverified surfaces, and user-authorized next actions;
- routing observations useful for improving Teamplay later.

If no subagent was used, say so and record why the main Lead handled the task
directly. Never infer actual model execution from an agent's prose. Label model
information as `configured` unless runtime metadata independently confirms it.
Report duration or token usage only when the runtime exposes those values; do
not estimate them.

## Routing presets

- `auto`: default `$teamplay` behavior. Select the smallest useful roster from
  the classification dimensions.
- `fast`: requested by `$teamplay-fast`. Prefer
  `teamplay-coder-fast`, plus a reviewer for meaningful code changes. Add cheap
  relevant verification. If broader design, security, data, migration,
  destructive, or irreversible risk appears, stop the fast path and escalate;
  never force an unsafe fast completion.
- `deep`: requested by `$teamplay-deep`. Favor Scout or Researcher when needed,
  Plan Challenger, Standard or Deep Coder according to the real implementation
  depth, focused review, and QA. Do not silently downgrade to the fast path.
- `critical`: requested by `$teamplay-critical`. For an implementation require
  Plan Challenger, `teamplay-coder-deep`, focused independent review, QA, and
  Gate. If a required surface cannot run, report blocked or partial rather than
  weakening the preset.

`standard`, `quick`, `lean`, and `thorough` remain accepted natural-language
aliases for compatibility, but the public entry points are `$teamplay`,
`$teamplay-fast`, `$teamplay-deep`, and `$teamplay-critical`. A user's explicit
inclusion or exclusion wins unless it would make the requested operation unsafe.

## Safety boundary

Teamplay does not authorize pushing, merging, releasing, purchasing, changing
accounts or permissions, deleting user data, or performing unrelated cleanup.
Use normal approval and destructive-action rules for those operations.

Treat the selected registered `agent_type` as the model-routing authority. Do
not treat an agent's natural-language statement about its own model as proof.
