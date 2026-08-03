#!/bin/sh
set -eu

usage() {
  cat <<'EOF'
Usage: scripts/install.sh [--check] [--target-codex-dir PATH]

Install Teamplay without overwriting modified local files. Normal mode installs
missing files and migrates only byte-exact 0.12.2 files. --check verifies that
the installed copy is byte-identical without changing the target.
EOF
}

fail() {
  printf '%s\n' "ERROR: $*" >&2
  exit 1
}

path_exists() {
  [ -e "$1" ] || [ -L "$1" ]
}

sha256_file() {
  shasum -a 256 "$1" 2>/dev/null | awk 'NF >= 1 && length($1) == 64 { print $1; exit }'
}

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
PACKAGE_DIR=$(CDPATH='' cd -- "$SCRIPT_DIR/.." && pwd)
LEGACY_MANIFEST="$SCRIPT_DIR/legacy-0.12.2.sha256"
TARGET_CODEX_DIR=${CODEX_HOME:-"$HOME/.codex"}
CHECK_ONLY=0

while [ "$#" -gt 0 ]; do
  case "$1" in
    --check)
      CHECK_ONLY=1
      shift
      ;;
    --target-codex-dir)
      [ "$#" -ge 2 ] || fail "--target-codex-dir requires a path"
      [ -n "$2" ] || fail "--target-codex-dir requires a non-empty path"
      case "$2" in
        --*) fail "prefix an option-like relative path with ./" ;;
      esac
      TARGET_CODEX_DIR=$2
      shift 2
      ;;
    --help|-h)
      usage
      exit 0
      ;;
    *)
      fail "unknown argument: $1"
      ;;
  esac
done

case "$TARGET_CODEX_DIR" in
  /*) ;;
  *) TARGET_CODEX_DIR=$(pwd -P)/$TARGET_CODEX_DIR ;;
esac
case "$TARGET_CODEX_DIR" in
  /|//) fail "refusing to use the filesystem root as Codex home" ;;
esac

[ -f "$LEGACY_MANIFEST" ] && [ ! -L "$LEGACY_MANIFEST" ] ||
  fail "legacy manifest is missing or unsafe"

TMP_BASE=${TMPDIR:-/tmp}
case "$TMP_BASE" in
  /*) ;;
  *) TMP_BASE=/tmp ;;
esac
WORK_DIR=$(mktemp -d "$TMP_BASE/teamplay-install.XXXXXX") ||
  fail "could not create installer workspace"
INVENTORY="$WORK_DIR/inventory"
PREFLIGHT="$WORK_DIR/preflight"
STAGING="$WORK_DIR/staging"

cleanup() {
  case "$WORK_DIR" in
    "$TMP_BASE"/teamplay-install.*) rm -rf "$WORK_DIR" ;;
    *) printf '%s\n' "ERROR: refusing cleanup of unexpected path" >&2 ;;
  esac
}
trap cleanup 0 HUP INT TERM

append_inventory() {
  source_path=$1
  relative_path=$2
  mode=$3
  [ -f "$source_path" ] && [ ! -L "$source_path" ] ||
    fail "distribution file is missing or unsafe: $source_path"
  printf '%s|%s|%s\n' "$source_path" "$relative_path" "$mode" >> "$INVENTORY"
}

: > "$INVENTORY"
for source_path in "$PACKAGE_DIR"/agents/teamplay-*.toml; do
  append_inventory "$source_path" "agents/$(basename "$source_path")" 0644
done
append_inventory "$PACKAGE_DIR/skills/teamplay/SKILL.md" "skills/teamplay/SKILL.md" 0644
append_inventory "$PACKAGE_DIR/LICENSE" "skills/teamplay/LICENSE" 0644
for source_path in "$PACKAGE_DIR"/skills/teamplay/references/*.md; do
  append_inventory "$source_path" "skills/teamplay/references/$(basename "$source_path")" 0644
done
for source_path in "$PACKAGE_DIR"/skills/teamplay/templates/*.md; do
  append_inventory "$source_path" "skills/teamplay/templates/$(basename "$source_path")" 0644
done
for source_path in "$PACKAGE_DIR"/skills/teamplay/scripts/*; do
  [ -f "$source_path" ] || continue
  append_inventory "$source_path" "skills/teamplay/scripts/$(basename "$source_path")" 0755
done
for shortcut in teamplay-fast teamplay-deep teamplay-critical; do
  append_inventory "$PACKAGE_DIR/skills/$shortcut/SKILL.md" "skills/$shortcut/SKILL.md" 0644
  append_inventory "$PACKAGE_DIR/LICENSE" "skills/$shortcut/LICENSE" 0644
done

legacy_digest_for() {
  relative_path=$1
  awk -v path="$relative_path" '$2 == path { print $1; exit }' "$LEGACY_MANIFEST"
}

classify_destination() {
  source_path=$1
  relative_path=$2
  destination=$TARGET_CODEX_DIR/$relative_path
  if ! path_exists "$destination"; then
    printf '%s\n' missing
  elif [ -L "$destination" ] || [ ! -f "$destination" ]; then
    printf '%s\n' unsafe
  elif cmp -s "$source_path" "$destination"; then
    printf '%s\n' current
  else
    actual_digest=$(sha256_file "$destination")
    legacy_digest=$(legacy_digest_for "$relative_path")
    if [ -n "$legacy_digest" ] && [ "$actual_digest" = "$legacy_digest" ]; then
      printf '%s\n' legacy
    elif [ -z "$actual_digest" ]; then
      printf '%s\n' unreadable
    else
      printf '%s\n' conflict
    fi
  fi
}

classify_obsolete() {
  relative_path=$1
  expected_digest=$2
  destination=$TARGET_CODEX_DIR/$relative_path
  if ! path_exists "$destination"; then
    printf '%s\n' missing
  elif [ -L "$destination" ] || [ ! -f "$destination" ]; then
    printf '%s\n' unsafe
  elif [ "$(sha256_file "$destination")" = "$expected_digest" ]; then
    printf '%s\n' obsolete
  else
    printf '%s\n' conflict
  fi
}

if path_exists "$TARGET_CODEX_DIR" &&
   { [ -L "$TARGET_CODEX_DIR" ] || [ ! -d "$TARGET_CODEX_DIR" ]; }; then
  fail "target Codex home is not a real directory: $TARGET_CODEX_DIR"
fi

: > "$PREFLIGHT"
PREFLIGHT_FAILED=0
while IFS='|' read -r source_path relative_path mode; do
  state=$(classify_destination "$source_path" "$relative_path")
  printf '%s|%s|%s|%s\n' "$source_path" "$relative_path" "$mode" "$state" >> "$PREFLIGHT"
  if [ "$CHECK_ONLY" -eq 1 ]; then
    [ "$state" = current ] || {
      printf '%s\n' "ERROR: installed file is $state: $TARGET_CODEX_DIR/$relative_path" >&2
      PREFLIGHT_FAILED=1
    }
  else
    case "$state" in
      missing|current|legacy) ;;
      *)
        printf '%s\n' "ERROR: installed file is $state and will not be replaced: $TARGET_CODEX_DIR/$relative_path" >&2
        PREFLIGHT_FAILED=1
        ;;
    esac
  fi
done < "$INVENTORY"

LEAD_OBSOLETE_SHA=56069fbff42ad552e888a27a652c418c4a75ba289e9bc06bc9e0283dc7279190
GATE_OBSOLETE_SHA=8ad76b571ab23663a5f725167cc9377d2ab753d13380e5f5bdbc41dba2a5bf81
for obsolete_record in \
  "agents/teamplay-lead.toml|$LEAD_OBSOLETE_SHA" \
  "agents/teamplay-gate.toml|$GATE_OBSOLETE_SHA"
do
  relative_path=${obsolete_record%%|*}
  expected_digest=${obsolete_record#*|}
  state=$(classify_obsolete "$relative_path" "$expected_digest")
  printf '%s|%s|%s\n' "obsolete" "$relative_path" "$state" >> "$PREFLIGHT"
  case "$state" in
    missing) ;;
    obsolete)
      [ "$CHECK_ONLY" -eq 0 ] || {
        printf '%s\n' "ERROR: obsolete Teamplay file remains: $TARGET_CODEX_DIR/$relative_path" >&2
        PREFLIGHT_FAILED=1
      }
      ;;
    *)
      printf '%s\n' "ERROR: obsolete-name file is $state and will not be removed: $TARGET_CODEX_DIR/$relative_path" >&2
      PREFLIGHT_FAILED=1
      ;;
  esac
done

[ "$PREFLIGHT_FAILED" -eq 0 ] || fail "preflight failed; target was not changed"

if [ "$CHECK_ONLY" -eq 1 ]; then
  printf '%s\n' "Teamplay check passed: installed files exactly match 0.13.0"
  exit 0
fi

mkdir -p "$STAGING"
while IFS='|' read -r source_path relative_path mode state; do
  case "$source_path" in obsolete) continue ;; esac
  case "$state" in
    current) continue ;;
    missing|legacy)
      staged=$STAGING/$relative_path
      mkdir -p "$(dirname "$staged")"
      install -m "$mode" "$source_path" "$staged"
      ;;
  esac
done < "$PREFLIGHT"

# Recheck every destination after staging and before the first target mutation.
while IFS='|' read -r source_path relative_path mode expected_state; do
  case "$source_path" in obsolete) continue ;; esac
  actual_state=$(classify_destination "$source_path" "$relative_path")
  [ "$actual_state" = "$expected_state" ] ||
    fail "destination changed after preflight: $TARGET_CODEX_DIR/$relative_path"
done < "$PREFLIGHT"

mkdir -p "$TARGET_CODEX_DIR/agents" "$TARGET_CODEX_DIR/skills"
while IFS='|' read -r source_path relative_path mode state; do
  case "$source_path" in obsolete) continue ;; esac
  destination=$TARGET_CODEX_DIR/$relative_path
  case "$state" in
    current)
      printf '%s\n' "CURRENT: $destination"
      ;;
    missing)
      mkdir -p "$(dirname "$destination")"
      ln "$STAGING/$relative_path" "$destination" ||
        fail "destination appeared during install and was not overwritten: $destination"
      printf '%s\n' "INSTALLED: $destination"
      ;;
    legacy)
      [ "$(classify_destination "$source_path" "$relative_path")" = legacy ] ||
        fail "legacy destination changed and was not replaced: $destination"
      mv -f "$STAGING/$relative_path" "$destination"
      chmod "$mode" "$destination"
      printf '%s\n' "MIGRATED: $destination"
      ;;
  esac
done < "$PREFLIGHT"

for obsolete_record in \
  "agents/teamplay-lead.toml|$LEAD_OBSOLETE_SHA" \
  "agents/teamplay-gate.toml|$GATE_OBSOLETE_SHA"
do
  relative_path=${obsolete_record%%|*}
  expected_digest=${obsolete_record#*|}
  if [ "$(classify_obsolete "$relative_path" "$expected_digest")" = obsolete ]; then
    rm "$TARGET_CODEX_DIR/$relative_path"
    printf '%s\n' "REMOVED EXACT OBSOLETE: $TARGET_CODEX_DIR/$relative_path"
  fi
done

printf '%s\n' "Teamplay installed in $TARGET_CODEX_DIR"
printf '%s\n' "Run scripts/install.sh --check, then open a new Codex task to refresh roles."
