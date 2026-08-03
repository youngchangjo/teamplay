# Runtime identity and isolation

Static TOML and registry availability prove configuration only. A route claim
uses public native spawn/details metadata first. Compare every exposed role,
model, effort, service tier, sandbox policy, and permission profile with the
selected Teamplay contract.

When public metadata omits a required field and the local rollout is available,
resolve `../scripts/inspect-agent-runtime.sh` relative to this file and inspect
one exact child thread. Example for a fresh advisory reviewer:

```sh
sh <installed-teamplay>/scripts/inspect-agent-runtime.sh \
  --expect-role teamplay-reviewer \
  --expect-model gpt-5.6-terra \
  --expect-effort high \
  --require-isolation \
  <thread-id>
```

The helper emits only allowlisted routing fields. It never prints prompts,
messages, environment variables, credentials, token contents, configuration
files, or arbitrary rollout payloads. Public and local evidence must agree.

Missing, conflicting, unavailable, or inconsistent role/model/effort is
`NOT_PROVEN` and stops any lane that requires exact routing. Fast is proven only
when an actual Fast service tier is observed. A read-only advisory claim is
enforced only when the sandbox type is observed as `read-only` and a permission
profile type is observed.

If the host broadens reviewer isolation, continue only when hard isolation is
not required, the child is explicitly forbidden to mutate, and the Lead records
exact before/after repository and artifact state. Report the broader policy as
residual risk. If isolation is unobservable, hard isolation is required, or any
mutation occurs, stop the advisory lane.
