#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PACKAGE_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
TARGET_CODEX_DIR=${CODEX_HOME:-"$HOME/.codex"}
TARGET_AGENTS_DIR="$TARGET_CODEX_DIR/agents"
TARGET_SKILLS_DIR="$TARGET_CODEX_DIR/skills"
TARGET_SKILL_DIR="$TARGET_SKILLS_DIR/teamplay"

install -d "$TARGET_AGENTS_DIR"
install -d "$TARGET_SKILL_DIR/references"
install -d "$TARGET_SKILL_DIR/templates"
install -d "$TARGET_SKILL_DIR/scripts"

# Teamplay 0.4.0 moved Lead ownership to the current main agent. Remove only the
# obsolete Teamplay-owned preset from earlier installations.
rm -f "$TARGET_AGENTS_DIR/teamplay-lead.toml"

for AGENT_FILE in "$PACKAGE_DIR"/agents/teamplay-*.toml; do
  install -m 0644 "$AGENT_FILE" "$TARGET_AGENTS_DIR/$(basename "$AGENT_FILE")"
done

install -m 0644 "$PACKAGE_DIR/skills/teamplay/SKILL.md" "$TARGET_SKILL_DIR/SKILL.md"
install -m 0644 "$PACKAGE_DIR/LICENSE" "$TARGET_SKILL_DIR/LICENSE"

for REFERENCE_FILE in "$PACKAGE_DIR"/skills/teamplay/references/*.md; do
  install -m 0644 "$REFERENCE_FILE" "$TARGET_SKILL_DIR/references/$(basename "$REFERENCE_FILE")"
done

for TEMPLATE_FILE in "$PACKAGE_DIR"/skills/teamplay/templates/*.md; do
  install -m 0644 "$TEMPLATE_FILE" "$TARGET_SKILL_DIR/templates/$(basename "$TEMPLATE_FILE")"
done

for SKILL_SCRIPT in "$PACKAGE_DIR"/skills/teamplay/scripts/*; do
  [ -f "$SKILL_SCRIPT" ] || continue
  install -m 0755 "$SKILL_SCRIPT" "$TARGET_SKILL_DIR/scripts/$(basename "$SKILL_SCRIPT")"
done

for SHORTCUT in teamplay-fast teamplay-deep teamplay-critical; do
  SHORTCUT_TARGET="$TARGET_SKILLS_DIR/$SHORTCUT"
  install -d "$SHORTCUT_TARGET"
  install -m 0644 "$PACKAGE_DIR/skills/$SHORTCUT/SKILL.md" "$SHORTCUT_TARGET/SKILL.md"
  install -m 0644 "$PACKAGE_DIR/LICENSE" "$SHORTCUT_TARGET/LICENSE"
done

echo "Teamplay installed in $TARGET_CODEX_DIR"
echo "Restart Codex or open a new task to refresh the agent registry."
