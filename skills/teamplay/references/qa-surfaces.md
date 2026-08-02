# Lead QA surfaces

The current main Lead owns acceptance QA. Run QA at a named integrated-feature,
user-visible-milestone, pre-merge, pre-release, or critical final-evidence gate,
not after every edit.

## Scenario record

For each applicable requirement record:

- gate and requirement ID;
- branch/SHA, build, app, device, URL, or external target identity;
- faithful surface and setup;
- decisive action;
- expected and actual observable;
- artifact path or log reference;
- verdict and surface limitation;
- reused or invalidated evidence.

The Lead executes or directly observes the decisive scenario. An advisory QA
helper may prepare setup, commands, logs, screenshots, or candidate evidence.

## Separate proof layers

Do not blend:

- static analysis and unit tests;
- build success;
- browser runtime;
- native Simulator;
- native macOS app;
- installed application;
- physical device;
- external service or admin readback;
- deployment;
- release or store state.

Use the most faithful available surface. Mark unavailable requested surfaces
`BLOCKED`, `PARTIAL`, or `NOT_PROVEN`; do not upgrade a weaker surface to PASS.

## Failure and repair

A requirement-linked QA failure consumes the next shared repair slot from
`delivery-speed.md`. After repair, the Lead re-reviews affected code and reruns
the invalidated scenario. QA does not create a separate repair budget.
