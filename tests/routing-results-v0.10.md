# Teamplay 0.10 routing classification results

- Reviewer: current main Lead
- Date: 2026-08-02
- Specification: approved architect PLAN packets 2 and 3
- Result: 14/14 static classifications match the expected route

| Fixture | Authority/spec | Model decision | Spec/pool | Verdict |
|---|---|---|---|---|
| DR-01 | R0/R1 ready | L1-L6 pass -> Luna max Standard | Brief/1 | PASS |
| DR-02 | R0/R1 ready | L1-L6 pass; file breadth ignored -> Luna max Standard | Brief/1 | PASS |
| DR-03 | R0/R1 ready | L1-L6 pass -> Luna max Standard | Brief/1 | PASS |
| DR-04 | R0/R1 ready | both outcomes L1-L6 pass -> Luna max | Full/2 independent | PASS |
| DR-05 | R0/R1 ready; explicit three | all outcomes L1-L6 pass -> Luna max | Full/3 isolated | PASS |
| DR-06 | R0/R1 ready; one artifact owner | L1-L6 pass -> Luna max Standard | Brief/1 | PASS |
| DR-07 | R0/R1 ready | L4/L5 fail -> Sol max | Full/1 | PASS |
| DR-08 | R0/R1 ready | L5 fails on lifecycle/concurrency -> Sol max | Full/1 | PASS |
| DR-09 | R0/R1 ready | L5 fails on migration/integrity -> Sol max | Full/1 | PASS |
| DR-10 | R0/R1 ready | L4 fails on bounded diagnosis -> Sol max | Brief/1 | PASS |
| DR-11 | R0/R1 ready | L1-L6 pass + Fast -> Luna max Fast | Brief/1; Lead unchanged | PASS |
| DR-12 | R0/R1 ready | production renderer route-neutral | one exact capsule/hash | PASS |
| DR-13 | same locked spec | original route retained | shared REPAIR_1/2 | PASS |
| DR-14 | replan trigger reached | no new model until R1 repeats | REPLAN/BLOCKED | PASS |

## Render evidence

- Canonical capsule SHA-256:
  `9965cc7cfc9c4658f3783247d265388cc8a098f97ca026cf3115d00a07b2478c`
- Standard fixture begin/end delimiter count: `1/1`
- Source-to-rendered capsule equality: `PASS`
- Coder TOML copied global-policy block: `0`

## Prompt-pressure evidence

| Role | 0.9 baseline | 0.10 non-task policy | Reduction |
|---|---:|---:|---:|
| Standard Luna | 2,888 | 1,804 | 37.5% |
| Fast Luna | 2,999 | 1,868 | 37.7% |
| Sol | 2,619 | 1,634 | 37.6% |

All exceed the approved 25% reduction threshold.

## Live canaries

| Canary | Static configuration | Runtime identity | Reason |
|---|---|---|---|
| LC-STD | Luna max Standard PASS | NOT_PROVEN | Installed registry requires a new Codex task for a fresh role prompt/run |
| LC-FAST | Luna max + Fast-only settings PASS | NOT_PROVEN | No host-observed post-install child run in this task |
| LC-SOL | Sol max PASS | NOT_PROVEN | No host-observed post-install child run in this task |

Child self-reporting will not be accepted as runtime identity evidence. Open a
new Codex task before running these canaries.
