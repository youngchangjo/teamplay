# Evidence contract

## Evidence layers

Teamplay keeps these claims separate:

1. `implemented`: the intended files changed.
2. `reviewed`: an independent reviewer inspected the actual diff.
3. `verified`: applicable tests, builds, or runtime scenarios passed.
4. `gated`: a high-risk final audit accepted the available evidence.
5. `released`: an external deployment or release surface was verified.

No earlier layer implies a later one.

## Required handoff fields

Every child result should include:

- role and assignment;
- status;
- inspected or changed paths;
- exact checks performed;
- findings or observable results;
- blockers and remaining risks;
- artifact paths when artifacts were produced.

## Verdict vocabulary

Use explicit verdicts:

- `PASS`: directly verified against the requested surface.
- `FAIL`: executed and did not meet the criterion.
- `PARTIAL`: some requested layers passed and others remain open.
- `BLOCKED`: the scenario could not run because a named prerequisite is missing.
- `NOT_APPLICABLE`: the criterion genuinely does not apply, with one-line reason.

Do not use `PASS` for skipped, inferred, simulated-as-physical, or prose-only
evidence.

## Final report

The lead's final report must name:

- what changed;
- review verdict;
- commands and scenarios that passed or failed;
- surfaces not exercised;
- high-risk gate verdict when used;
- exact next action requiring the user, a device, credentials, or external state.
