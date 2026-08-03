# Spec Brief: Coder liveness before stall takeover

- Spec ID: `TP-CODER-LIFECYCLE-001`
- Revision: `3`
- Status: implemented

## Objective

Prevent the Main Lead from aborting a healthy Coder because `wait_agent` timed
out or no file diff existed during active pre-mutation work.

## Requirements

- `LC-07A`: Lead inspects host status and recent agent-message, reasoning, tool,
  token, and command activity before using diff as supporting evidence.
- `LC-07B`: `wait_agent timed_out` is never terminal or stall evidence by itself.
- `LC-07C`: `running` plus recent activity requires continued waiting.
- `LC-07D`: stall redirect uses `interrupt:false`; forced interruption requires
  a known unsafe/wrong-direction action or authority revocation.
- `LC-07E`: takeover requires two evidenced inactivity windows. Unknown activity
  visibility fails closed to waiting or user direction.

## Verification

- LF-11 through LF-13 statically cover active-running, non-interrupting redirect,
  and takeover proof.
- Runtime inspector emits liveness timestamps/counts without payload text.
- Bundle, installer migration, installed copy, shell parsing, and diff checks pass.
