---
name: teamplay-fast
description: Run Teamplay with the fast preset for small, clear, low-risk changes. Use when the user says "$teamplay-fast", asks Teamplay to move quickly, or wants the Luna max fast implementation lane with bounded review.
version: 0.3.0
---

# Teamplay Fast

This is a thin entry point for the core Teamplay workflow.

Before acting, fully read `../teamplay/SKILL.md` and every reference it marks as
required. Then follow the core entry contract with:

```text
requested_preset: fast
```

Fast means:

- use `teamplay-lead`;
- prefer `teamplay-coder-fast` for a required mutation;
- use `teamplay-reviewer` for meaningful code changes;
- run cheap, directly relevant verification when available;
- omit roles that have no concrete assignment.

Fast does not weaken safety. If the task exposes broader design, security,
privacy, auth, payment, data integrity, migration, deployment, destructive, or
irreversible risk, stop the fast path and have the lead announce the required
escalation. Never force fast completion through a higher-risk boundary.
