# Teamplay 0.13.1 lifecycle validation results

- Package: Teamplay 0.13.1
- Spec: TP-CODER-LIFECYCLE-001 revision 3
- Root-cause evidence: two Luna max Coders were closed while host status remained
  `running`; both had recent reasoning and tool activity, and each active turn
  was first aborted by an `interrupt:true` redirect.
- Static fixture result: 13/13 PASS

| Fixture | Requirement | Static result | Evidence |
|---|---|---|---|
| LF-01..LF-10 | LC-01..LC-07 | PASS | Existing continuity, restart, takeover, and post-takeover QA contracts remain preserved. |
| LF-11 | LC-07 | PASS | `wait_agent` timeout plus empty diff cannot override running/recent activity. |
| LF-12 | LC-07 | PASS | Redirect requires an inactivity window and uses `interrupt:false`. |
| LF-13 | LC-07 | PASS | Takeover requires two evidenced inactivity windows; unknown liveness fails closed. |

The runtime inspector reports only allowlisted routing fields and liveness
timestamps/counts. It does not expose prompt, message, reasoning, or tool
payload text.

## Evidence limits

The root-cause observation is from the named local live run and the policy test
is static. A fresh post-fix Coder run remains the next behavioral canary.
