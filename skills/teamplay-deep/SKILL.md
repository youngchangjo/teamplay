---
name: teamplay-deep
description: Run Teamplay with the deep preset for complex implementation, architecture, difficult debugging, or thorough review. Use when the user says "$teamplay-deep" or asks Teamplay to investigate and implement deeply without taking the fast path.
version: 0.3.0
---

# Teamplay Deep

This is a thin entry point for the core Teamplay workflow.

Before acting, fully read `../teamplay/SKILL.md` and every reference it marks as
required. Then follow the core entry contract with:

```text
requested_preset: deep
```

Deep means:

- use `teamplay-lead`;
- add Scout or Researcher when discovery or external facts matter;
- use Plan Challenger when design, ambiguity, or cross-cutting interfaces matter;
- select Standard Coder or Deep Coder from the actual implementation depth;
- require focused independent review for meaningful code changes;
- run faithful QA on available requested surfaces.

Do not silently downgrade to the fast path. Deep does not require mutation when
the user's request is read-only, and it does not authorize unrelated expansion.
