---
name: teamplay-critical
description: Run Teamplay with the critical preset for security, privacy, auth, payment, data integrity, migration, deployment, release, destructive, or irreversible work. Use when the user says "$teamplay-critical" or explicitly requires the strongest Teamplay evidence gate.
version: 0.6.0
---

# Teamplay Critical

This is a thin entry point for the core Teamplay workflow.

Before acting, fully read `../teamplay/SKILL.md` and every reference it marks as
required. Then follow the core entry contract with:

```text
requested_preset: critical
```

For a mutating implementation, Critical requires:

- the current main agent acting as Teamplay Lead;
- `teamplay-plan-challenger`;
- `teamplay-coder-deep`;
- one or more task-focused `teamplay-reviewer` passes;
- `teamplay-qa` on every applicable requested verification surface;
- `teamplay-gate` after review and QA.

Add Scout or Researcher when discovery or current external evidence is required.
Do not silently downgrade, skip a required evidence layer, or convert a blocked
physical, external, deployment, or release surface into a pass. Critical does
not itself authorize publication, release, account changes, purchases, deletion,
or other destructive actions.

End with the core Teamplay Run Report. Every required Critical evidence layer
must have a separate verdict; missing evidence must remain `PARTIAL` or
`BLOCKED`.
