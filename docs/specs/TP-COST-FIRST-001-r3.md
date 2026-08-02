# Spec amendment: Sol-baseline economics and Korean README

## Identity

- Spec ID and revision: `TP-COST-FIRST-001`, revision 3
- Repository baseline: `4cb9794`
- Implementation owner: current main agent; Teamplay is not invoked to maintain
  its own package
- Date: 2026-08-03
- Coder count: zero for this maintenance change

## Outcome

Preserve Luna-first, zero-budget Terra, no-Sol routing while explaining economics
against an all-Sol baseline and publishing a Korean README with the same
normative product, ownership, visual, lifecycle, and evidence contracts.

## Requirements

| ID | Requirement | Acceptance |
|---|---|---|
| CF-01 | Luna max remains the default implementation Coder. | Public routing and roles are unchanged. |
| CF-02 | Sol remains a prohibited route but becomes the price baseline. | Price tables show Sol at 100% cost without making it selectable. |
| CF-17 | API comparison uses current official Sol/Terra/Luna rates. | Sol `$5/$0.50/$30`, Terra `$2.50/$0.25/$15`, Luna `$1/$0.10/$6`. |
| CF-18 | Codex comparison uses current token-credit rates. | Sol `125/12.5/750`, Terra `62.5/6.25/375`, Luna `25/2.5/150`. |
| CF-19 | Savings are explicit and assumption-bounded. | Luna shows 80% per-token savings, Terra 50%; example child mixes and whole-workflow scenarios identify assumptions and reject billing claims. |
| CF-20 | Terra examples do not become allocations. | Every 5%/10% example repeats zero allocation budget and individual T1/T2 requirements. |
| CF-21 | Korean README exists. | `README.ko.md` contains language links, core policies, tables, Mermaid, economics, Lead rationale, lifecycle, roles, validation, and authority. |
| CF-22 | English and Korean policies agree. | Both state all-Luna default without T1/T2, zero-budget Terra, no Sol/Gate child, and Lead-owned review/QA/Gate. |

## Estimated-savings model

For equal token-type volumes, every input/cached/output category has the same
relative price:

```text
Luna relative child cost = 20% of Sol
Terra relative child cost = 50% of Sol
child relative cost = 20% × Luna token share + 50% × Terra token share
child savings = 100% - child relative cost
```

- 100% Luna: 80% estimated child-token savings.
- 95% Luna / 5% Terra: 78.5% estimated child-token savings.
- 90% Luna / 10% Terra: 77% estimated child-token savings.

The latter rows are illustrative calculations only. Terra allocation budget is
zero and no percentage creates routing authority.

Whole-workflow savings multiply child savings by the child implementation share
of the hypothetical all-Sol total. Main Lead cost remains unchanged. Fast,
reasoning/retries, context reuse, direct Lead coding, and actual token mix can
change the observed result.

## Frozen contracts

- Every Luna child remains max.
- Terra xhigh remains an individually authorized T1/T2 exception.
- Sol and Gate children remain absent.
- Main Lead owns specification, integration, review, QA, Gate, and completion.
- Price observations never become routing constants or billing proof.

## Validation

- `./scripts/validate.sh --bundle`
- `./scripts/install.sh`
- `./scripts/validate.sh --installed`
- English/Korean key-policy and role parity assertions
- Sol-baseline price and estimated-savings assertions
- `git diff --check` and shell parsing
- Local `teamplay_deepseek` static/full validation after public version sync

## Evidence limits

- Price values are official point-in-time observations from 2026-08-03.
- Scenario tables are arithmetic estimates, not observed token use or billing.
- Markdown and Mermaid are statically checked without rendered screenshots.
- No live child canary, push, merge, or release is authorized by this spec.

## Unresolved items requiring user authority

- None.
