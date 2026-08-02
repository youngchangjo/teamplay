# Teamplay 0.10 policy movement map

This map records where Teamplay 0.9 duplicated policy moved in 0.10.

| Policy | Removed from | Canonical destination | Child loading |
|---|---|---|---|
| Authority and prohibited side effects | Coder TOMLs, task constraints, repeated core prose | `references/execution-policy.md` | Exact delimited capsule rendered once |
| Unrelated-work and owned-surface safety | Coder TOMLs, task constraints, role reference | `references/execution-policy.md` | Exact delimited capsule rendered once |
| Evidence-layer separation and final Lead authority | Coder TOMLs, task constraints, several references | `references/execution-policy.md`; detail in `evidence-contract.md` | Capsule plus Lead-only evidence reference |
| Luna versus Sol eligibility | rescue-only Coder and preset prose, core skill summaries | `references/routing.md` | Route result recorded in task capsule |
| Pool count, independence, and isolation | core skill, routing, delivery-speed copies | `references/routing.md` only | Pool assignment in task capsule |
| Spec level and Full triggers | one universal spec contract and core prose | `references/spec-contract.md` | Brief or Full template identified by revision |
| Repair cadence | core skill and delivery narrative | `references/delivery-speed.md` | Lead orchestration; repair cycle in task capsule |
| Role outputs | nine-field Coder TOMLs and task template | six-field envelope in execution capsule | One rendered envelope |
| Lead review and QA | child prompts and several references | `lead-review.md`, `qa-surfaces.md`, `qa-packet.md` | Lead context only |
| Public explanation | copied operational clauses in README/DESIGN | concise links to canonical references | Not injected into children |

## Mechanical safeguards

- Coder TOMLs contain no execution-capsule delimiter or copied global block.
- The renderer extracts the canonical block rather than maintaining a second copy.
- Validation compares the normalized rendered block byte-for-byte and by SHA-256.
- The routing fixture suite checks the model, spec, pool, Fast, and repair edges.
