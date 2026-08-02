# Run reporting

Every invocation ends with a Teamplay Run Report, including blocked and
read-only runs.

Report:

1. user outcome and authority boundary;
2. canonical spec path, ID, revision, level, and baseline;
3. R0-R3 route: model, effort, tier, L1-L6 or Sol signal, pool, isolation;
4. agent assignments and compact results;
5. execution capsule and task hashes;
6. requirement coverage: implementation, Lead review, Lead QA, evidence;
7. repair state and invalidated checks;
8. advisory findings and Lead adjudication when used;
9. runtime identity as host-observed `PASS` or honest `NOT_PROVEN`;
10. external/release state, limitations, blockers, and next authority gate.
11. lifecycle events: spawn, message/reuse, resume, redirect, restart, and
    close, with the session key, Coder identity, outcome, and evidence state;
12. host token diagnostics as separate input_cached, input_uncached, output,
    and reasoning fields, plus an explicit statement that billing is not
    inferred.

The initial assignment records one canonical execution capsule. A same-session
continuation records zero capsule copies and references the unchanged session
key. Lifecycle events are orchestration evidence, not proof that product
behavior, runtime identity, deployment, or release state passed.

## Overall status

- `COMPLETE`: every applicable requirement passed Lead review and Lead QA.
- `PARTIAL`: useful work exists but a requirement or evidence class remains.
- `BLOCKED`: a named prerequisite or authority boundary stops progress.
- `FAILED`: execution completed with a requirement failure not repaired.

Do not present a configured model as an observed runtime identity, Coder checks
as final QA, an advisory verdict as Lead approval, or a local artifact as an
external/release result. Do not present host token counters as provider
billing, credits, or cost.
