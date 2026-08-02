# Execution policy

This file is the sole source for Teamplay's shared child execution policy. The
Lead materializes the exact delimited block into each child assignment with the
production renderer. Do not copy the block into role files or templates.

---BEGIN TEAMPLAY EXECUTION CAPSULE v1---
Precedence: user instruction, canonical spec, task capsule, role contract, this
policy.

Autonomously perform task-authorized local reads, owned-surface edits, and
non-destructive checks. External or destructive actions, account/permission
changes, commits, pushes, merges, and releases require recorded authority.

Preserve unrelated work and stay inside owned surfaces. Stop on ownership
overlap or dependence on another child's uncommitted work.

Keep static, test, build, runtime, device, external, deployment, and release
evidence distinct. Coder checks are supporting evidence; the current main Lead
owns final spec review, acceptance QA, final Gate judgment, and completion.

Escalate insufficient spec, authority, frozen contracts, ownership, or evidence
while preserving valid work.

Return: status; requirementsAddressed; changedSurfaces; validationEvidence;
deviationsOrResidualRisks; handoffOrEscalationReason.
---END TEAMPLAY EXECUTION CAPSULE v1---

## Source and rendering rules

- The begin and end delimiters occur exactly once in this file.
- Normalize only the final newline when comparing the source and rendered block.
- A rendered prompt must contain exactly one source-identical capsule.
- The task capsule follows the execution capsule and contains only task-variable
  information.
- The run report records the canonical capsule SHA-256 and task SHA-256 returned
  by the renderer.
