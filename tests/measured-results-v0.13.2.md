# Teamplay 0.13.2 measured-effectiveness validation results

- Package: Teamplay 0.13.2
- Source: host `token_count` logs of the 2026-08-03 Itssle Link NATIVE run
  (Lead session `019fc472`; Luna coders `019fc61c`, `019fc64d` completed;
  `019fc5c6`, `019fc5e6` killed pre-fix).
- Rates: official 2026-08-03 API and Codex cards, Sol as Lead baseline.

| Measure | Value |
|---|---:|
| Lead-only implementation (two slices, Sol rates) | $30.14 / 753 credits |
| Luna-completed (two slices) + Lead orchestration | $7.34 / 184 credits |
| Measured savings | ~76% (API dollars and Codex credits) |
| Full-run coordination (4 coders, 63 waits) | $1.26 / 31 credits |
| Coordination share of total | ~1-2% |
| Cost per Lead wake-up | ~$0.11 (mostly cached-input re-read) |

Method: per-session sums of host `last_token_usage` deltas; orchestration turns
are turns containing spawn/send/close/wait operations. The compared slices are
adjacent NATIVE slices of the same app: comparable in size, not identical.

Limits: one run; host observations are not a billing surface; rates are
volatile. This is measured evidence, not a guarantee or a billing claim.
