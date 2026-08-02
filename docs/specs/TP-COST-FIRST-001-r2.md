# Spec amendment: Lead-owned Gate and visual README

## Identity

- Spec ID and revision: `TP-COST-FIRST-001`, revision 2
- Repository baseline: `67f3121`
- Implementation owner: current main agent; Teamplay is not invoked to maintain
  its own package
- Date: 2026-08-03
- Coder count: zero for this maintenance change

## Outcome

Preserve Luna-first cost routing while removing the Gate child completely,
making final Gate judgment an explicit current-main-Lead phase, and presenting
the workflow through scannable tables and Mermaid flows in README.

## Requirements

| ID | Requirement | Acceptance |
|---|---|---|
| CF-01 | Luna max remains the default and first implementation Coder. | Core skill, routing, README, and role TOML remain unchanged in intent. |
| CF-02 | Sol remains prohibited for every child. | All distributed and installed agent TOML contain zero Sol models. |
| CF-03 | Terra xhigh remains the maximum implementation exception. | T1/T2 rules remain unchanged; no Gate route is added. |
| CF-11 | Final Gate belongs directly to the current main Lead. | Core skill, Critical preset, role contract, README, and design identify Gate as a Lead phase after review and QA. |
| CF-12 | No Gate child exists. | `agents/teamplay-gate.toml` is absent from bundle and installation; installer removes only the obsolete installed Gate role. |
| CF-13 | README is visually scannable. | README includes an owner/phase table, model-decision table, installed-role table, and Mermaid end-to-end flow. |
| CF-14 | Gate verdict remains specification- and evidence-based. | Flow and prose show specification review, acceptance QA, residual risk/evidence Gate, repair, replan, and blocked outcomes. |
| CF-15 | Private DeepSeek inherits Lead-owned Gate. | Local wrapper states that no Gate child is created and validates against public 0.12.1. |
| CF-16 | Luna's 90% figure is a lower-bound audit alarm, never a mix target. | Terra allocation budget is zero; every Terra outcome requires T1/T2; policy forbids filling 10%, balancing models, or inferring cumulative compliance. |

## Canonical flow

```text
User request
-> Main Lead authority and specification
-> Luna max default or T1/T2 Terra xhigh exception
-> implementation and focused checks
-> Main Lead specification review
-> Main Lead acceptance QA
-> Main Lead final Gate
-> complete, repair, replan, or blocked
```

## Frozen contracts

- Every Luna child remains max.
- Fast remains Luna-only and child-local.
- T1/T2 and the no-Sol prohibition remain unchanged.
- Without T1 or T2, every public implementation outcome in a run uses Luna max.
- Terra has no reserved share or percentage allowance.
- One mutating writer remains default; parallelism and lifecycle bounds remain.
- Review and QA continue to share two in-spec repair slots.
- Gate does not create another repair allowance or another model route.

## Validation

- `./scripts/validate.sh --bundle`
- `./scripts/install.sh`
- `./scripts/validate.sh --installed`
- `git diff --check`
- Agent roster count and exact installed-byte comparison
- Static assertion that `teamplay-gate.toml` is absent in bundle and install
- README Mermaid/table contract assertions
- Local `teamplay_deepseek` static/full validation after synchronization

## Evidence limits

- Markdown validation does not render GitHub's Mermaid implementation; the
  source syntax and required nodes are checked statically.
- No live child or runtime Gate canary is required for this maintenance change.
- No push, merge, release, or external write is authorized.

## Unresolved items requiring user authority

- None.
