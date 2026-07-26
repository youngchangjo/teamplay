# QA surface contract

Teamplay QA should verify user-visible behavior on the most faithful available
surface. Unit tests and builds are necessary evidence when applicable, but they
do not replace interactive UI proof.

## Surface selection

Use this order:

1. Honor an explicit user surface such as the in-app Browser, Chrome, a named
   Simulator, a physical device, or a specific native app.
2. Prefer a purpose-built connector, API, CLI, build tool, simulator tool, or
   app-specific skill for semantic or build operations.
3. For websites, local web apps, browser flows, responsive layouts, and
   browser-visible integrations, load `browser:control-in-app-browser` and use
   the Browser runtime. When no browser is explicitly named, prefer the in-app
   Browser when available through the runtime default or URL selection.
4. For native macOS UI, iOS Simulator windows, installed apps, system dialogs,
   or UI not exposed through the Browser skill, load
   `computer-use:computer-use` and operate the visible app after purpose-built
   surfaces have done what they can.
5. If the requested faithful surface is unavailable, mark that scenario
   `BLOCKED` or `PARTIAL`; do not silently replace it with weaker evidence.

Ambient browser tabs are context, not an explicit browser choice. An explicit
in-app Browser or Chrome request remains binding unless the user approves a
switch.

## Browser QA

- Follow the Browser skill's setup, browser-selection, documentation, and reuse
  requirements exactly.
- Do not use standalone Playwright, unrelated browser MCP servers, or Computer
  Use as a shortcut when the Browser skill is the appropriate surface.
- Do not inspect cookies, local storage, profiles, passwords, or session stores.
- Record target URL, selected browser, viewport when exposed, decisive actions,
  visible before and after state, and screenshot, console, or network evidence
  supported by the chosen browser.
- Test the requested primary flow and applicable error, empty, loading,
  responsive, or boundary states.

## Computer Use QA

- Prefer purpose-built tools first; Computer Use is for UI state or interaction
  not exposed elsewhere.
- Fetch fresh app state after actions and re-derive element references.
- Prefer accessibility-element actions; use screenshots and coordinates only
  when accessibility state is incomplete or unreliable.
- Record app identifier, window or device surface, action sequence, before and
  after observables, and screenshot paths.
- Follow Computer Use confirmation requirements for consequential actions. QA
  does not authorize purchases, publication, permanent deletion, credential
  creation, legal acceptance, or permission expansion.

## Proof boundaries

Keep these separate:

- in-app Browser simulation;
- Chrome or another browser session;
- native iOS Simulator;
- native macOS app;
- installed application;
- physical device;
- external service or production readback;
- deployment or release state.

A pass on one surface does not imply a pass on another.

## Minimum UI scenario record

For each scenario capture:

- criterion and scenario id;
- `surfaceKind` and exact target;
- setup and action sequence;
- expected and actual visible behavior;
- verdict;
- screenshot or equivalent artifact reference;
- surface limitations and missing stronger proof.
