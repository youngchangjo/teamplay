---
name: teamplay-critical
description: Run Teamplay with threat-, rollback-, and evidence-aware specification for security, privacy, auth, payment, migration, release, or irreversible-risk work. Use when the user invokes "$teamplay-critical" or requests a critical gate.
version: 0.13.1
---

# Teamplay Critical

Read and apply `../teamplay/SKILL.md` with:

```yaml
requested_preset: critical
```

- Apply R0 before every route; critical does not grant new authority.
- Use a Full Spec Lock when the triggers in `spec-contract.md` apply.
- Route by Luna-first L1-L6 readiness. Criticality never selects Sol or automatic
  Terra; unresolved decisions return to the Lead before delegation.
- The current main Lead directly performs the critical Gate after final spec
  review and acceptance QA. Never create a Gate or Sol child.
- The current main Lead owns final spec review, QA, Gate, and completion.
- A fresh-context Terra advisory audit is optional when the Lead records a
  material independent-review reason. It uses `fork_turns: none`, the complete
  locked spec and actual diff, and never becomes a Gate or Sol route.
- Lifecycle continuity never expands authority: reuse the same Coder only while
  the locked session key, ownership, and frozen contracts remain unchanged.
