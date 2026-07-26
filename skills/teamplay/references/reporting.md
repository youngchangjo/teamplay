# Reporting contract

Every Teamplay invocation ends with a structured `Teamplay Run Report`. The
report is part of completion, not optional commentary. Produce it even when the
request is read-only, fails, is blocked, or needs no subagent.

The inline final-response report is mandatory. If the caller supplies a report
path or the workflow already owns an evidence directory, also save the same
report there and return its path. Do not create or commit a new report directory
inside an unrelated product repository by default.

## Purpose

The report should let a maintainer answer:

- Which entry point and routing preset ran?
- Which model-specific roles were selected, and why?
- What did each agent actually contribute?
- Where did handoffs, retries, escalation, review, or QA occur?
- Which evidence supports completion?
- What should Teamplay route differently next time?

## Model provenance

For each child, report the model and reasoning effort configured in its
registered Teamplay agent preset. Label these values `configured` unless the
runtime independently exposes the actual resolved model metadata.

Do not ask an agent which model it is running and treat the prose response as
evidence. Do not infer the main Lead's model or reasoning level. When the
runtime does not expose them, write `current main session; runtime metadata not
exposed`.

## Required sections

1. `Run`: entry point, resolved preset, overall status, and Lead provenance.
2. `Team used`: one row per spawned instance with role, registered agent type,
   configured model and effort, assignment, selection reason, and result.
3. `Flow`: the actual handoff order, including parallel groups, retries,
   escalations, and repair loops.
4. `Delivery`: changed paths, artifacts, and the user-visible outcome.
5. `Evidence`: implementation, review, QA/runtime, gate, and release verdicts as
   separate layers.
6. `Omissions and limits`: roles intentionally omitted, blocked or unverified
   surfaces, and actions still requiring user authority.
7. `Routing observations`: brief, observable signals for future tuning.

## No-subagent runs

If no subagent is useful, include a single Team-used row stating `None` and the
reason. Do not manufacture delegation to make the report look more substantial.

## Routing observations

Record only observable facts, for example:

- Fast Coder escalated because the change crossed an auth boundary.
- Reviewer found a regression and one repair loop was required.
- Standard Coder completed without rework and all requested QA passed.
- QA could not run because the named physical device was unavailable.

Do not expose hidden chain-of-thought, score models from one anecdote, estimate
tokens, or claim a model was better without comparable evidence. Include token
usage and duration only when the runtime supplies them.

## Status vocabulary

- `COMPLETE`: every requested and applicable finish line passed.
- `PARTIAL`: valid work completed but one or more requested finish lines remain.
- `BLOCKED`: a named prerequisite prevents meaningful completion.
- `FAILED`: executed evidence shows a required criterion did not pass.
