# Full Spec Lock: cost-first Luna routing and Sol prohibition

## Identity

- Spec ID and revision: `TP-COST-FIRST-001`, revision 1
- Repository baseline: `5c18984`
- Implementation owner: current main agent; Teamplay is not invoked to maintain
  its own package
- Date: 2026-08-03
- Coder count: zero for this maintenance change

## Outcome

Teamplay must visibly and mechanically default every implementation to Luna max
for cost efficiency, never create a Sol child, and allow Terra xhigh only by
explicit user request or concrete evidence from a prior Luna attempt.

## Requirement matrix

| ID | Requirement | Acceptance |
|---|---|---|
| CF-01 | Luna max is the economic and initial implementation default. | Core skill, routing, presets, README, templates, and reports state the default. |
| CF-02 | No Teamplay child uses Sol at any effort. | Every distributed agent TOML rejects `gpt-5.6-sol`; docs and fixtures treat Sol as prohibited. |
| CF-03 | Terra xhigh is the maximum child route. | Exception Coder uses Terra xhigh, Gate uses Terra high, and no child uses a stronger model tier. |
| CF-04 | Terra implementation requires T1 or T2. | T1 is direct user Terra selection; T2 contains prior-Luna requirement/check evidence and economic rationale. |
| CF-05 | Difficulty is not escalation evidence. | Hard/deep/critical/ambiguous work returns to the Lead for specification and then Luna. |
| CF-06 | Stall does not escalate models. | Existing wait/redirect/Lead-takeover path remains canonical and rejects Terra/Sol on stall. |
| CF-07 | README leads with the economic premise. | First sections explain Lead authority, Luna max implementation, price relationship, Terra ceiling, and Sol prohibition. |
| CF-08 | Current price evidence is accurate and non-normative. | 2026-08-03 official API and Codex tables show Luna at 1/2.5 of Terra for input/cached/output; docs require recheck. |
| CF-09 | Existing authority, session, review, and QA contracts remain. | Validation preserves bounded pools, one-outcome sessions, Lead spec review, acceptance QA, and evidence separation. |
| CF-10 | Private DeepSeek remains explicit and local. | Wrapper inherits no-Sol fallback and retains exact model ID, max effort, and local-only boundary. |

## Routing contract

```text
R0 authority
-> R1 Lead closes specification and L1-L6 readiness
-> R2 Luna max default
-> optional Terra xhigh only with T1 or T2
-> R3 smallest safe writer pool
```

`T2 evidenced_luna_capability_blocker` requires all of:

- a real Luna attempt on the same locked whole outcome;
- a named failed requirement and check or objective observation;
- preserved valid work and current state;
- why Lead clarification or same-Luna repair is insufficient;
- why one Terra attempt is expected to cost less than further Luna work or
  direct Lead completion.

Silence, slow reasoning, no mutation, ordinary test/review failure, or generic
difficulty is not T2.

## Frozen contracts

- The current main Lead's selected model, effort, and tier remain unchanged.
- Every Luna child remains max.
- Fast remains Luna-only and child-local.
- One mutating writer remains default; automatic two and explicit three still
  require independent outcomes and safe isolation.
- One outcome/session continuity and Lead takeover on stall remain unchanged.
- Lead specification review and acceptance QA remain final.
- Public Teamplay does not expose the private DeepSeek route.

## Current price evidence

Official pages observed on 2026-08-03:

- API per 1M tokens: Luna `$1 / $0.10 / $6`; Terra
  `$2.50 / $0.25 / $15` for input/cached/output.
- Codex credits per 1M tokens: Luna `25 / 2.5 / 150`; Terra
  `62.5 / 6.25 / 375`.
- Each Luna category is 1/2.5 of Terra. Values remain volatile and must not
  become permanent routing constants.

Sources:

- https://developers.openai.com/api/docs/models/compare
- https://developers.openai.com/api/docs/models/gpt-5.6-luna
- https://help.openai.com/en/articles/20001106-codex-rate-card

## Validation

- `./scripts/validate.sh --bundle`
- `./scripts/install.sh`
- `./scripts/validate.sh --installed`
- `git diff --check`
- role TOML and shell parsing
- 16 static routing fixtures, including difficult Luna-first tasks, T1, T2,
  and global no-Sol inspection
- installed public skill byte comparison
- local `teamplay_deepseek` static and full validation after synchronization

## Evidence limits

- Static configuration does not prove a live Luna, Fast, Terra, or no-Sol run.
- Prices are point-in-time official observations and may change.
- No push, merge, release, or live child canary is authorized by this spec.

## Unresolved items requiring user authority

- None.
