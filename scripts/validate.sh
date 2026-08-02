#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)
PACKAGE_DIR=$(CDPATH= cd -- "$SCRIPT_DIR/.." && pwd)
MODE=${1:-"--bundle"}

case "$MODE" in
  --bundle|--installed) ;;
  *) echo "usage: $0 [--bundle|--installed]" >&2; exit 2 ;;
esac

TARGET_CODEX_DIR=${CODEX_HOME:-"$HOME/.codex"}

python3 - "$PACKAGE_DIR" "$TARGET_CODEX_DIR" "$MODE" <<'PY'
from pathlib import Path
import hashlib
import importlib.util
import json
import sys
import tomllib

sys.dont_write_bytecode = True

package = Path(sys.argv[1])
codex_dir = Path(sys.argv[2])
mode = sys.argv[3]

expected = {
    "teamplay-scout": ("gpt-5.6-luna", "low"),
    "teamplay-researcher": ("gpt-5.6-terra", "medium"),
    "teamplay-plan-challenger": ("gpt-5.6-terra", "high"),
    "teamplay-coder-fast": ("gpt-5.6-luna", "max"),
    "teamplay-coder": ("gpt-5.6-luna", "max"),
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
agents = {}
for path in agent_files:
    with path.open("rb") as handle:
        data = tomllib.load(handle)
    name = data["name"]
    assert name not in agents, f"duplicate role: {name}"
    assert data.get("description", "").strip(), f"missing description: {path}"
    assert data.get("developer_instructions", "").strip(), f"missing instructions: {path}"
    if name in read_only:
        assert data.get("sandbox_mode") == "read-only", f"read-only sandbox missing: {name}"
    agents[name] = data

actual_roster = {
    name: (data["model"], data["model_reasoning_effort"])
    for name, data in agents.items()
}
assert actual_roster == expected, f"roster mismatch:\n{actual_roster}"

for name, data in agents.items():
    features = data.get("features", {})
    if name == "teamplay-coder-fast":
        assert data.get("service_tier") == "fast", data
        assert features.get("fast_mode") is True, data
    else:
        assert data.get("service_tier") is None, f"unexpected service tier: {name}"
        assert features.get("fast_mode") is not True, f"unexpected Fast feature: {name}"

version = (package / "VERSION").read_text().strip()
assert version == "0.11.0", version

skill = (package / "skills/teamplay/SKILL.md").read_text()
assert skill.startswith("---\nname: teamplay\n")
assert "\nversion: 0.11.0\n---\n" in skill
for phrase in (
    "references/execution-policy.md",
    "references/session-continuity.md",
    "references/spec-contract.md",
    "references/routing.md",
    "R0-R3 order",
    "personally owns final review and QA",
    "render-task-packet.py",
    "same session key",
    "continuation packet",
    "Teamplay Run Report",
):
    assert phrase in skill, f"core skill missing: {phrase}"

shortcut_presets = {
    "teamplay-fast": "fast",
    "teamplay-deep": "deep",
    "teamplay-critical": "critical",
}
for shortcut, preset in shortcut_presets.items():
    text = (package / f"skills/{shortcut}/SKILL.md").read_text()
    assert text.startswith(f"---\nname: {shortcut}\n")
    assert "\nversion: 0.11.0\n---\n" in text
    assert "../teamplay/SKILL.md" in text
    assert f"requested_preset: {preset}" in text

required_files = (
    "README.md",
    "LICENSE",
    "CHANGELOG.md",
    "docs/DESIGN.md",
    "docs/POLICY_MOVEMENT_V0.10.md",
    "skills/teamplay/references/execution-policy.md",
    "skills/teamplay/references/session-continuity.md",
    "skills/teamplay/references/routing.md",
    "skills/teamplay/references/spec-contract.md",
    "skills/teamplay/references/delivery-speed.md",
    "skills/teamplay/templates/spec-brief.md",
    "skills/teamplay/templates/spec-contract.md",
    "skills/teamplay/templates/task-packet.md",
    "skills/teamplay/templates/continuation-packet.md",
    "skills/teamplay/templates/lead-review.md",
    "skills/teamplay/templates/qa-packet.md",
    "skills/teamplay/templates/final-report.md",
    "skills/teamplay/scripts/render-task-packet.py",
    "tests/routing-fixtures.md",
    "tests/routing-results-v0.10.md",
    "tests/routing-results-v0.11.md",
    "tests/render-results-v0.10.json",
    "tests/render-results-v0.11.json",
    "tests/lifecycle-fixtures.md",
    "tests/lifecycle-results-v0.11.md",
    "tests/baselines/prompt-pressure-v0.9.json",
    "tests/fixtures/task-standard.md",
    "tests/fixtures/task-fast.md",
    "tests/fixtures/task-sol.md",
    "tests/fixtures/task-standard-v0.11.md",
    "tests/fixtures/task-fast-v0.11.md",
    "tests/fixtures/task-sol-v0.11.md",
    "tests/fixtures/continuation-v0.11.md",
)
for relative in required_files:
    assert (package / relative).is_file(), f"missing distribution file: {relative}"

policy_path = package / "skills/teamplay/references/execution-policy.md"
policy = policy_path.read_text()
begin = "---BEGIN TEAMPLAY EXECUTION CAPSULE v1---"
end = "---END TEAMPLAY EXECUTION CAPSULE v1---"
assert policy.count(begin) == 1 and policy.count(end) == 1
task_template = (package / "skills/teamplay/templates/task-packet.md").read_text()
assert begin not in task_template and end not in task_template
for phrase in ("outcome_id:", "session_key:", "initial_assignment: true",
               "continuation-packet.md"):
    assert phrase in task_template, f"task template missing: {phrase}"

continuation_template = (
    package / "skills/teamplay/templates/continuation-packet.md"
).read_text()
continuation_fixture = (
    package / "tests/fixtures/continuation-v0.11.md"
).read_text()
for text, label in (
    (continuation_template, "continuation template"),
    (continuation_fixture, "continuation fixture"),
):
    assert begin not in text and end not in text, f"capsule copied in {label}"
    for phrase in (
        "session_key:",
        "prior_agent_id:",
        "message/reuse",
        "resume",
        "redirect",
        "continuation_reason:",
        "requested_result:",
        "failed_requirement_ids:",
        "acceptance_reruns:",
        "zero execution capsule copies",
    ):
        assert phrase in text, f"{label} missing: {phrase}"
    assert "exact_next_action" not in text, f"micro-instruction field in {label}"

renderer_path = package / "skills/teamplay/scripts/render-task-packet.py"
spec = importlib.util.spec_from_file_location("teamplay_renderer", renderer_path)
assert spec and spec.loader
renderer = importlib.util.module_from_spec(spec)
spec.loader.exec_module(renderer)
canonical_capsule = renderer.extract_capsule(policy)
canonical_hash = hashlib.sha256(canonical_capsule.encode()).hexdigest()

baseline = json.loads((package / "tests/baselines/prompt-pressure-v0.9.json").read_text())
render_record = json.loads((package / "tests/render-results-v0.11.json").read_text())
assert render_record["canonicalCapsuleSha256"] == canonical_hash
fixture_map = {
    "teamplay-coder": ("task-standard-v0.11.md", "standard"),
    "teamplay-coder-fast": ("task-fast-v0.11.md", "fast"),
    "teamplay-coder-deep": ("task-sol-v0.11.md", "sol"),
}
pressure = {}
for role, (fixture, record_name) in fixture_map.items():
    developer = agents[role]["developer_instructions"]
    for forbidden in (
        begin,
        end,
        "Do not push",
        "Never revert",
        "final code review",
        "acceptance QA",
        "external writes",
    ):
        assert forbidden not in developer, f"copied global policy in {role}: {forbidden}"

    rendered, metadata = renderer.render(
        policy_path, package / "tests/fixtures" / fixture
    )
    assert metadata["beginDelimiterCount"] == 1
    assert metadata["endDelimiterCount"] == 1
    assert metadata["canonicalCapsuleSha256"] == canonical_hash
    recorded = render_record["fixtures"][record_name]
    for key in (
        "taskSha256",
        "renderedPromptSha256",
        "renderedCharacters",
        "beginDelimiterCount",
        "endDelimiterCount",
    ):
        assert metadata[key] == recorded[key], (role, key, metadata[key], recorded[key])
    start = rendered.index(begin)
    finish = rendered.index(end, start) + len(end)
    rendered_capsule = renderer.normalize_final_newline(rendered[start:finish])
    assert rendered_capsule == canonical_capsule

    old = baseline["roles"][role]
    role_chars = len(developer)
    non_task_policy_chars = role_chars + len(canonical_capsule)
    assert role_chars < old["developerInstructionCharacters"], (role, role_chars, old)
    assert non_task_policy_chars <= old["assembledNonTaskPolicyCharacters"] * 0.75, (
        role,
        non_task_policy_chars,
        old,
    )
    pressure[role] = {
        "roleChars": role_chars,
        "nonTaskPolicyChars": non_task_policy_chars,
        "baseline": old["assembledNonTaskPolicyCharacters"],
    }

routing = (package / "skills/teamplay/references/routing.md").read_text()
for phrase in (
    "R0 authority",
    "L1 requirements_closed",
    "L6 bounded_ownership",
    "user directly requests Sol",
    "Never run more than three mutating Coders",
    "sole normative source",
):
    assert phrase in routing, f"routing missing: {phrase}"

continuity = (
    package / "skills/teamplay/references/session-continuity.md"
).read_text()
for phrase in (
    "LC-01",
    "LC-02",
    "LC-03",
    "LC-04",
    "LC-05",
    "LC-06",
    "message/reuse",
    "resume",
    "redirect",
    "restart",
    "close",
    "input_cached",
    "input_uncached",
    "output",
    "reasoning",
    "provider billing",
    "reflexively poll",
    "Closing a child to release capacity does not authorize a replacement",
):
    assert phrase in continuity, f"continuity contract missing: {phrase}"

final_report = (package / "skills/teamplay/templates/final-report.md").read_text()
for phrase in (
    "Outcome continuity",
    "Lifecycle diagnostics",
    "message/reuse",
    "input_cached",
    "Billing inferred: no",
):
    assert phrase in final_report, f"final report missing: {phrase}"

spec_contract = (package / "skills/teamplay/references/spec-contract.md").read_text()
assert "Merely touching a named artifact does not trigger Full Lock" in spec_contract
brief_template = (package / "skills/teamplay/templates/spec-brief.md").read_text()
full_template = (package / "skills/teamplay/templates/spec-contract.md").read_text()
for text in (brief_template, full_template):
    assert "Must be empty before any mutating Coder starts" in text

delivery = (package / "skills/teamplay/references/delivery-speed.md").read_text()
assert "Pool count, writer independence, and isolation are defined only" in delivery
assert "LEAD_QA bounded failure -> next available REPAIR slot" in delivery
assert "Any failure after REPAIR_2 -> REPLAN/BLOCKED" in delivery

fixtures = (package / "tests/routing-fixtures.md").read_text()
for index in range(1, 15):
    assert f"DR-{index:02d}" in fixtures, f"routing fixture missing: DR-{index:02d}"
for live in ("LC-STD", "LC-FAST", "LC-SOL"):
    assert live in fixtures
results = (package / "tests/routing-results-v0.10.md").read_text()
assert "14/14 static classifications" in results
assert results.count("NOT_PROVEN") >= 3
results_011 = (package / "tests/routing-results-v0.11.md").read_text()
assert "14/14 preserved routing classifications" in results_011
assert "7/7 lifecycle classifications" in results_011

lifecycle_fixtures = (package / "tests/lifecycle-fixtures.md").read_text()
for fixture in ("LF-01", "LF-02", "LF-03", "LF-04", "LF-05", "LF-06", "LF-07"):
    assert fixture in lifecycle_fixtures, f"lifecycle fixture missing: {fixture}"
lifecycle_results = (
    package / "tests/lifecycle-results-v0.11.md"
).read_text()
for phrase in (
    "7/7 PASS",
    "LC-01",
    "LC-02",
    "LC-03",
    "LC-04",
    "LC-05",
    "LC-06",
    "input_cached",
    "input_uncached",
    "Billing",
):
    assert phrase in lifecycle_results, f"lifecycle result missing: {phrase}"

license_text = (package / "LICENSE").read_text()
assert license_text.startswith("MIT License\n")
assert "Copyright (c) 2026 Young Changjo" in license_text

readme = (package / "README.md").read_text()
for role_name in expected:
    assert role_name in readme, f"README missing role: {role_name}"

if mode == "--installed":
    installed_agents = codex_dir / "agents"
    installed_names = {path.stem for path in installed_agents.glob("teamplay-*.toml")}
    assert installed_names == set(expected), sorted(installed_names)
    for source in agent_files:
        target = installed_agents / source.name
        assert target.is_file(), f"missing installed agent: {target}"
        assert source.read_bytes() == target.read_bytes(), f"installed agent differs: {source.name}"

    for skill_name in ("teamplay", "teamplay-fast", "teamplay-deep", "teamplay-critical"):
        source_skill = package / "skills" / skill_name
        installed_skill = codex_dir / "skills" / skill_name
        source_files = {
            source.relative_to(source_skill)
            for source in source_skill.rglob("*")
            if source.is_file()
            and "__pycache__" not in source.parts
            and source.suffix != ".pyc"
        }
        for relative in source_files:
            source = source_skill / relative
            target = installed_skill / relative
            assert target.is_file(), f"missing installed skill file: {skill_name}/{relative}"
            assert source.read_bytes() == target.read_bytes(), f"installed skill differs: {skill_name}/{relative}"
        installed_files = {
            target.relative_to(installed_skill)
            for target in installed_skill.rglob("*")
            if target.is_file()
            and target.name != "LICENSE"
            and "__pycache__" not in target.parts
            and target.suffix != ".pyc"
        }
        assert installed_files == source_files, (
            skill_name,
            sorted(map(str, installed_files)),
            sorted(map(str, source_files)),
        )

print(f"Teamplay {version}: validated {len(agents)} roles ({mode[2:]})")
print("Prompt pressure:", json.dumps(pressure, sort_keys=True))
PY

sh -n "$PACKAGE_DIR/scripts/install.sh"
