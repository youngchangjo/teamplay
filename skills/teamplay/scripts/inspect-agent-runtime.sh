#!/bin/sh
# Emit only allowlisted routing metadata from one exact native subagent rollout.

set -eu

usage() {
  cat <<'EOF'
Usage: inspect-agent-runtime.sh [options] THREAD_ID

Options:
  --sessions-dir DIR          Read a non-default Codex sessions directory.
  --expect-role ROLE          Require the exact native agent role.
  --expect-model MODEL        Require the exact model.
  --expect-effort EFFORT      Require the exact reasoning effort.
  --expect-service-tier TIER  Require an observed exact service tier.
  --require-isolation         Require observed read-only sandbox and permission type.

The output is one compact JSON object containing only allowlisted routing and
liveness fields. Prompt, message, reasoning, and tool payload text is excluded.
EOF
}

fail() {
  printf '%s\n' "ERROR: $*" >&2
  exit 1
}

SESSIONS_DIR=''
EXPECT_ROLE=''
EXPECT_MODEL=''
EXPECT_EFFORT=''
EXPECT_SERVICE_TIER=''
REQUIRE_ISOLATION=0

while [ "$#" -gt 1 ]; do
  case "$1" in
    --sessions-dir|--expect-role|--expect-model|--expect-effort|--expect-service-tier)
      [ "$#" -ge 3 ] || fail "$1 requires a value and THREAD_ID"
      option=$1
      value=$2
      [ -n "$value" ] || fail "$option requires a non-empty value"
      case "$option" in
        --sessions-dir) SESSIONS_DIR=$value ;;
        --expect-role) EXPECT_ROLE=$value ;;
        --expect-model) EXPECT_MODEL=$value ;;
        --expect-effort) EXPECT_EFFORT=$value ;;
        --expect-service-tier) EXPECT_SERVICE_TIER=$value ;;
      esac
      shift 2
      ;;
    --require-isolation)
      REQUIRE_ISOLATION=1
      shift
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      fail "unknown option: $1"
      ;;
  esac
done

[ "$#" -eq 1 ] || { usage >&2; exit 2; }
THREAD_ID=$1
printf '%s\n' "$THREAD_ID" | LC_ALL=C grep -Eq \
  '^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$' ||
  fail "THREAD_ID must be a lowercase UUID"

if [ -z "$SESSIONS_DIR" ]; then
  if [ -n "${CODEX_HOME-}" ]; then
    SESSIONS_DIR=$CODEX_HOME/sessions
  else
    [ -n "${HOME-}" ] || fail "HOME is unset; pass --sessions-dir"
    SESSIONS_DIR=$HOME/.codex/sessions
  fi
fi
[ -d "$SESSIONS_DIR" ] || fail "sessions directory is unavailable"

TMP_BASE=${TMPDIR:-/tmp}
case "$TMP_BASE" in /*) ;; *) TMP_BASE=/tmp ;; esac
MATCHES_FILE=$(mktemp "$TMP_BASE/teamplay-runtime.XXXXXX") ||
  fail "could not create a temporary match list"

cleanup() {
  case "$MATCHES_FILE" in
    "$TMP_BASE"/teamplay-runtime.*) rm -f "$MATCHES_FILE" ;;
    *) printf '%s\n' "ERROR: refusing cleanup of unexpected temporary file" >&2 ;;
  esac
}
trap cleanup 0 HUP INT TERM

find "$SESSIONS_DIR" -type f -name "rollout-*-$THREAD_ID.jsonl" -print > "$MATCHES_FILE" ||
  fail "could not enumerate rollout filenames"
MATCH_COUNT=$(awk 'END { print NR + 0 }' "$MATCHES_FILE")
case "$MATCH_COUNT" in
  0) fail "no rollout filename matched the requested thread id" ;;
  1) ;;
  *) fail "multiple rollout filenames matched the requested thread id" ;;
esac
IFS= read -r ROLLOUT_FILE < "$MATCHES_FILE" || fail "could not read rollout path"
[ -f "$ROLLOUT_FILE" ] || fail "matched rollout is unavailable"

if ! RUNTIME_OUTPUT=$(jq -ce -s --arg expected_thread_id "$THREAD_ID" '
  def text_or_null: if type == "string" and length > 0 then . else null end;
  def one_or_null($values; $label):
    ($values | map(select(. != null)) | unique) as $known
    | if ($known | length) > 1 then error("conflicting " + $label)
      elif ($known | length) == 1 then $known[0]
      else null end;

  [ .[] | select(.type == "session_meta") | .payload ] as $sessions
  | [ .[] | select(.type == "turn_context") | .payload ] as $turns
  | [ .[]
      | .payload.type? as $payload_type
      | select(
          (.type == "event_msg" and
            (["agent_message", "token_count"] | index($payload_type)))
          or
          (.type == "response_item" and
            (["reasoning", "custom_tool_call", "custom_tool_call_output"] |
              index($payload_type)))
        )
      | {timestamp, kind: .payload.type}
    ] as $activities
  | if ($sessions | length) != 1 then error("missing or ambiguous session metadata")
    elif ($turns | length) == 0 then error("missing turn context")
    else
      $sessions[0] as $session
      | ($session.id? | text_or_null) as $thread_id
      | ($session.parent_thread_id? | text_or_null) as $parent_thread_id
      | ($session.agent_role? | text_or_null) as $agent_role
      | ($session.agent_path? | text_or_null) as $agent_path
      | ($session.model_provider? | text_or_null) as $model_provider
      | [ $turns[] | (.model? | text_or_null) ] as $models
      | [ $turns[] | (.effort? | text_or_null) ] as $efforts
      | [ $turns[] | ((.sandbox_policy? // {}) | .type? | text_or_null) ] as $sandboxes
      | [ $turns[] | ((.permission_profile? // {}) | .type? | text_or_null) ] as $permissions
      | [ $turns[] | ((.service_tier? // .serviceTier?) | text_or_null) ] as $tiers
      | [ $turns[] | (.cwd? | text_or_null) ] as $cwds
      | if $thread_id != $expected_thread_id then error("wrong session id")
        elif $agent_role == null then error("missing agent role")
        elif any($models[]; . == null) or ($models | unique | length) != 1 then error("missing or conflicting model")
        elif any($efforts[]; . == null) or ($efforts | unique | length) != 1 then error("missing or conflicting effort")
        elif any($cwds[]; . == null) or ($cwds | unique | length) != 1 then error("missing or conflicting cwd")
        else
          one_or_null($sandboxes; "sandbox policy") as $sandbox
          | one_or_null($permissions; "permission profile") as $permission
          | one_or_null($tiers; "service tier") as $tier
          | {
              thread_id: $thread_id,
              parent_thread_id: $parent_thread_id,
              agent_role: $agent_role,
              agent_path: $agent_path,
              model_provider: $model_provider,
              model: $models[0],
              effort: $efforts[0],
              service_tier: $tier,
              service_tier_observed: ($tier != null),
              service_tier_complete: all($tiers[]; . != null),
              sandbox_policy_type: $sandbox,
              sandbox_observed: ($sandbox != null),
              sandbox_complete: all($sandboxes[]; . != null),
              permission_profile_type: $permission,
              permission_observed: ($permission != null),
              permission_complete: all($permissions[]; . != null),
              cwd: $cwds[0],
              last_activity_at: (($activities | map(.timestamp) | max) // null),
              activity_event_count: ($activities | length),
              agent_message_count: ([ $activities[] | select(.kind == "agent_message") ] | length),
              reasoning_event_count: ([ $activities[] | select(.kind == "reasoning") ] | length),
              tool_call_count: ([ $activities[] | select(.kind == "custom_tool_call") ] | length),
              tool_output_count: ([ $activities[] | select(.kind == "custom_tool_call_output") ] | length),
              token_event_count: ([ $activities[] | select(.kind == "token_count") ] | length)
            }
        end
    end
' "$ROLLOUT_FILE" 2>/dev/null); then
  fail "rollout is missing, ambiguous, invalid, or inconsistent required routing metadata"
fi

printf '%s\n' "$RUNTIME_OUTPUT" | jq -e \
  --arg role "$EXPECT_ROLE" \
  --arg model "$EXPECT_MODEL" \
  --arg effort "$EXPECT_EFFORT" \
  --arg tier "$EXPECT_SERVICE_TIER" \
  --argjson require_isolation "$REQUIRE_ISOLATION" '
    ($role == "" or .agent_role == $role)
    and ($model == "" or .model == $model)
    and ($effort == "" or .effort == $effort)
    and ($tier == "" or (.service_tier_complete and .service_tier == $tier))
    and (($require_isolation == 0) or (
      .sandbox_complete and .sandbox_policy_type == "read-only"
      and .permission_complete
    ))
  ' >/dev/null || fail "runtime metadata does not satisfy the expected route or isolation"

printf '%s\n' "$RUNTIME_OUTPUT"
