# Teamplay 0.12 cost-first routing results

- Reviewer and implementation owner: current main agent
- Date: 2026-08-03
- Specification: TP-COST-FIRST-001 revision 1
- Result: 16/16 static routing classifications PASS

| Fixture | Cost-first decision | Spec/pool | Verdict |
|---|---|---|---|
| DR-01 | Luna max default | Brief/1 | PASS |
| DR-02 | Luna max; file breadth ignored | Brief/1 | PASS |
| DR-03 | Luna max established UI outcome | Brief/1 | PASS |
| DR-04 | Two independent Luna max outcomes | Full/2 | PASS |
| DR-05 | Three explicitly isolated Luna max outcomes | Full/3 | PASS |
| DR-06 | Luna max single shared-artifact owner | Brief/1 | PASS |
| DR-07 | Lead locks auth decision, then Luna max | Full/1 | PASS |
| DR-08 | Lead locks lifecycle invariants, then Luna max | Full/1 | PASS |
| DR-09 | Lead locks migration/recovery, then Luna max | Full/1 | PASS |
| DR-10 | Ambiguous diagnosis remains Luna max | Brief/1 | PASS |
| DR-11 | Luna max Fast; Lead unchanged | Brief/1 | PASS |
| DR-12 | Renderer remains route-neutral | one capsule/hash | PASS |
| DR-13 | Existing route retained through two repairs | shared repair budget | PASS |
| DR-14 | Replan does not auto-escalate models | REPLAN/BLOCKED | PASS |
| DR-15 | Direct Terra request records T1 | Terra xhigh/1 | PASS |
| DR-16 | Prior-Luna blocker records complete T2 evidence | Terra xhigh/1 | PASS |

## Global role inspection

- `gpt-5.6-sol` agent entries: 0 — PASS
- Every Luna role, including Default/Fast Coders: Luna max — PASS
- Exception Coder: Terra xhigh — PASS
- Highest advisory role: Terra high — PASS
- Sol implementation, review, QA, Gate, and rescue routes: prohibited — PASS

## Cost evidence

Official API and Codex tables observed on 2026-08-03 list Luna input, cached
input, and output at 1/2.5 of Terra in every category. Price values are
point-in-time evidence and are not embedded as routing constants.

## Preserved contracts

- Luna implementation reasoning remains max.
- Fast remains Luna-only and child-local.
- Pool cap remains three with the existing independence and isolation rules.
- Session continuity, stall-to-Lead takeover, final Lead review, and acceptance
  QA remain unchanged.

## Evidence limits

This is static package evidence. Live Luna, Fast, Terra, and global no-Sol
runtime observations remain `NOT_PROVEN` until host metadata is captured in a
fresh task. No provider billing amount is inferred.
