#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PACKAGE_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
MODE=${1:-"--bundle"}

case "$MODE" in
  --bundle|--installed)
    ;;
  *)
    echo "usage: $0 [--bundle|--installed]" >&2
    exit 2
    ;;
esac

TARGET_CODEX_DIR=${CODEX_HOME:-"$HOME/.codex"}

python3 - "$PACKAGE_DIR" "$TARGET_CODEX_DIR" "$MODE" <<'PY'
from pathlib import Path
import sys
import tomllib

package = Path(sys.argv[1])
codex_dir = Path(sys.argv[2])
mode = sys.argv[3]

expected = {
    "teamplay-scout": ("gpt-5.6-luna", "low"),
    "teamplay-researcher": ("gpt-5.6-terra", "medium"),
    "teamplay-plan-challenger": ("gpt-5.6-terra", "high"),
    "teamplay-coder-fast": ("gpt-5.6-luna", "max"),
    "teamplay-coder": ("gpt-5.6-terra", "high"),
    "teamplay-coder-deep": ("gpt-5.6-sol", "max"),
    "teamplay-reviewer": ("gpt-5.6-terra", "high"),
    "teamplay-qa": ("gpt-5.6-luna", "high"),
    "teamplay-gate": ("gpt-5.6-sol", "high"),
}
read_only = {
    "teamplay-scout",
    "teamplay-researcher",
    "teamplay-plan-challenger",
    "teamplay-reviewer",
    "teamplay-gate",
}

agent_files = sorted((package / "agents").glob("teamplay-*.toml"))
parsed = {}
for path in agent_files:
    with path.open("rb") as handle:
        data = tomllib.load(handle)
    name = data["name"]
    assert name not in parsed, f"duplicate role: {name}"
    assert data.get("description", "").strip(), f"missing description: {path}"
    assert data.get("developer_instructions", "").strip(), f"missing instructions: {path}"
    parsed[name] = (data["model"], data["model_reasoning_effort"])
    if name in read_only:
        assert data.get("sandbox_mode") == "read-only", f"read-only sandbox missing: {name}"

assert parsed == expected, f"roster mismatch:\nactual={parsed}\nexpected={expected}"

version = (package / "VERSION").read_text().strip()
assert version == "0.8.0", version
skill = (package / "skills/teamplay/SKILL.md").read_text()
assert skill.startswith("---\nname: teamplay\n")
assert "\nversion: 0.8.0\n---\n" in skill
assert "current main agent" in skill
assert "Never spawn or delegate to a separate `teamplay-lead`" in skill
assert "Every Teamplay run must end with a `Teamplay Run Report`" in skill
for required in (
    "references/routing.md",
    "references/role-contracts.md",
    "references/evidence-contract.md",
    "references/reporting.md",
    "references/qa-surfaces.md",
    "references/delivery-speed.md",
):
    assert required in skill, f"skill missing reference: {required}"

skill_names = (
    "teamplay",
    "teamplay-fast",
    "teamplay-deep",
    "teamplay-critical",
)
shortcut_presets = {
    "teamplay-fast": "fast",
    "teamplay-deep": "deep",
    "teamplay-critical": "critical",
}
for shortcut, preset in shortcut_presets.items():
    shortcut_skill = (package / f"skills/{shortcut}/SKILL.md").read_text()
    assert shortcut_skill.startswith(f"---\nname: {shortcut}\n")
    assert "\nversion: 0.8.0\n---\n" in shortcut_skill
    assert "../teamplay/SKILL.md" in shortcut_skill
    assert f"requested_preset: {preset}" in shortcut_skill

for relative in (
    "README.md",
    "LICENSE",
    "CHANGELOG.md",
    "docs/DESIGN.md",
    "skills/teamplay/templates/task-packet.md",
    "skills/teamplay/templates/research-packet.md",
    "skills/teamplay/templates/review-packet.md",
    "skills/teamplay/templates/qa-packet.md",
    "skills/teamplay/templates/final-report.md",
    "skills/teamplay/references/qa-surfaces.md",
    "skills/teamplay/references/delivery-speed.md",
):
    assert (package / relative).is_file(), f"missing distribution file: {relative}"

license_text = (package / "LICENSE").read_text()
assert license_text.startswith("MIT License\n")
assert "Copyright (c) 2026 Young Changjo" in license_text
readme = (package / "README.md").read_text()
for role_name in expected:
    assert role_name in readme, f"README missing role: {role_name}"

qa_agent = (package / "agents/teamplay-qa.toml").read_text()
for required_qa_contract in (
    "browser:control-in-app-browser",
    "computer-use:computer-use",
    "Ambient open-tab context alone is not an instruction",
    "A Simulator does not prove a physical device",
    "visualEvidence",
    "Run only when the Teamplay Lead declares a named QA gate",
    "reusedEvidence",
):
    assert required_qa_contract in qa_agent, f"QA contract missing: {required_qa_contract}"

coder_contracts = {
    "teamplay-coder-fast.toml": (
        "complete outcome",
        "do not stop after the first file",
    ),
    "teamplay-coder.toml": (
        "coherent end-to-end vertical slice",
        "Do not stop after one layer",
        "reasonable low-risk assumptions",
    ),
    "teamplay-coder-deep.toml": (
        "coherent end-to-end goal",
        "integratable vertical slice",
        "unnecessary Lead handoffs",
    ),
}
for coder_file, required_phrases in coder_contracts.items():
    coder_text = (package / "agents" / coder_file).read_text()
    for phrase in required_phrases:
        assert phrase in coder_text, f"{coder_file} missing speed contract: {phrase}"

if mode == "--installed":
    installed_agents = codex_dir / "agents"
    installed_role_names = {
        path.stem for path in installed_agents.glob("teamplay-*.toml")
    }
    assert installed_role_names == set(expected), (
        f"installed role set differs: {sorted(installed_role_names)}"
    )
    for source in agent_files:
        target = installed_agents / source.name
        assert target.is_file(), f"missing installed agent: {target}"
        assert source.read_bytes() == target.read_bytes(), f"installed agent differs: {source.name}"
    for skill_name in skill_names:
        source_skill = package / "skills" / skill_name
        installed_skill = codex_dir / "skills" / skill_name
        for source in sorted(source_skill.rglob("*")):
            if not source.is_file():
                continue
            relative = source.relative_to(source_skill)
            target = installed_skill / relative
            assert target.is_file(), f"missing installed skill file: {target}"
            assert source.read_bytes() == target.read_bytes(), f"installed skill differs: {skill_name}/{relative}"
        installed_license = installed_skill / "LICENSE"
        assert installed_license.read_bytes() == (package / "LICENSE").read_bytes()
        source_skill_files = {
            source.relative_to(source_skill)
            for source in source_skill.rglob("*")
            if source.is_file()
        }
        installed_skill_files = {
            target.relative_to(installed_skill)
            for target in installed_skill.rglob("*")
            if target.is_file() and target.name != "LICENSE"
        }
        assert installed_skill_files == source_skill_files, (
            f"installed skill file set differs for {skill_name}: "
            f"{sorted(map(str, installed_skill_files))}"
        )

print(f"Teamplay {version}: validated {len(parsed)} roles ({mode[2:]})")
PY

sh -n "$PACKAGE_DIR/scripts/install.sh"
