#!/bin/sh
set -eu

SCRIPT_DIR=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)
PACKAGE_DIR=$(CDPATH='' cd -- "$SCRIPT_DIR/.." && pwd)
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
    "teamplay-scout": ("gpt-5.6-luna", "max"),
    "teamplay-researcher": ("gpt-5.6-terra", "medium"),
    "teamplay-plan-challenger": ("gpt-5.6-terra", "high"),
    "teamplay-coder-fast": ("gpt-5.6-luna", "max"),
    "teamplay-coder": ("gpt-5.6-luna", "max"),
    "teamplay-coder-deep": ("gpt-5.6-terra", "xhigh"),
    "teamplay-reviewer": ("gpt-5.6-terra", "high"),
    "teamplay-qa": ("gpt-5.6-luna", "max"),
}
read_only = {
    "teamplay-scout",
    "teamplay-researcher",
    "teamplay-plan-challenger",
    "teamplay-reviewer",
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
assert all(model != "gpt-5.6-sol" for model, _ in actual_roster.values())
assert all(
    effort == "max" for model, effort in actual_roster.values()
    if model == "gpt-5.6-luna"
), actual_roster

for name, data in agents.items():
    features = data.get("features", {})
    if name == "teamplay-coder-fast":
        assert data.get("service_tier") == "fast", data
        assert features.get("fast_mode") is True, data
    else:
        assert data.get("service_tier") is None, f"unexpected service tier: {name}"
        assert features.get("fast_mode") is not True, f"unexpected Fast feature: {name}"

version = (package / "VERSION").read_text().strip()
assert version == "0.13.1", version

skill = (package / "skills/teamplay/SKILL.md").read_text()
assert skill.startswith("---\nname: teamplay\n")
assert "\nversion: 0.13.1\n---\n" in skill
for phrase in (
    "references/execution-policy.md",
    "references/session-continuity.md",
    "references/spec-contract.md",
    "references/routing.md",
    "references/runtime-identity.md",
    "R0-R3 order",
    "code review",
    "acceptance QA",
    "render-task-packet.py",
    "same session key",
    "continuation packet",
    "cost-first",
    "default initial implementation Coder",
    "Never create a Sol child",
    "T1 explicit_user_terra",
    "T2 evidenced_luna_capability_blocker",
    "There is no Gate child",
    "final Gate directly",
    "Perform the final Gate personally",
    "canonical user",
    "conversation and locked specification",
    "cannot approve its own work",
    "CODER_STALLED",
    "Lead directly finish",
    "Teamplay Run Report",
    "Read contracts progressively",
    "fork_turns: none",
    "complete revision-locked",
    "wait_agent",
    "interrupt:false",
    "`running` plus recent activity",
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
    assert "\nversion: 0.13.1\n---\n" in text
    assert "../teamplay/SKILL.md" in text
    assert f"requested_preset: {preset}" in text

required_files = (
    "README.md",
    "README.ko.md",
    "LICENSE",
    "CHANGELOG.md",
    "docs/DESIGN.md",
    "docs/POLICY_MOVEMENT_V0.10.md",
    "docs/specs/TP-COST-FIRST-001-r1.md",
    "docs/specs/TP-COST-FIRST-001-r2.md",
    "docs/specs/TP-COST-FIRST-001-r3.md",
    "docs/specs/TP-CODER-LIFECYCLE-001-r2.md",
    "docs/specs/TP-CODER-LIFECYCLE-001-r3.md",
    "docs/specs/TP-OPERATIONS-HARDENING-001-r1.md",
    "scripts/legacy-0.12.2.sha256",
    "skills/teamplay/references/execution-policy.md",
    "skills/teamplay/references/session-continuity.md",
    "skills/teamplay/references/routing.md",
    "skills/teamplay/references/spec-contract.md",
    "skills/teamplay/references/runtime-identity.md",
    "skills/teamplay/references/delivery-speed.md",
    "skills/teamplay/templates/spec-brief.md",
    "skills/teamplay/templates/spec-contract.md",
    "skills/teamplay/templates/task-packet.md",
    "skills/teamplay/templates/continuation-packet.md",
    "skills/teamplay/templates/lead-review.md",
    "skills/teamplay/templates/qa-packet.md",
    "skills/teamplay/templates/final-report.md",
    "skills/teamplay/scripts/render-task-packet.py",
    "skills/teamplay/scripts/inspect-agent-runtime.sh",
    "tests/fixtures/install/teamplay-critical-0.12.2.md",
    "tests/fixtures/install/teamplay-gate-obsolete.toml",
    "tests/fixtures/install/teamplay-lead-obsolete.toml",
    "tests/routing-fixtures.md",
    "tests/routing-results-v0.10.md",
    "tests/routing-results-v0.11.md",
    "tests/routing-results-v0.11.1.md",
    "tests/routing-results-v0.12.md",
    "tests/routing-results-v0.12.1.md",
    "tests/render-results-v0.10.json",
    "tests/render-results-v0.11.json",
    "tests/render-results-v0.12.json",
    "tests/render-results-v0.12.1.json",
    "tests/lifecycle-fixtures.md",
    "tests/lifecycle-results-v0.11.md",
    "tests/lifecycle-results-v0.11.1.md",
    "tests/lifecycle-results-v0.13.1.md",
    "tests/baselines/prompt-pressure-v0.9.json",
    "tests/fixtures/task-standard.md",
    "tests/fixtures/task-fast.md",
    "tests/fixtures/task-sol.md",
    "tests/fixtures/task-standard-v0.11.md",
    "tests/fixtures/task-fast-v0.11.md",
    "tests/fixtures/task-sol-v0.11.md",
    "tests/fixtures/task-standard-v0.12.md",
    "tests/fixtures/task-fast-v0.12.md",
    "tests/fixtures/task-terra-v0.12.md",
    "tests/fixtures/continuation-v0.11.md",
    "tests/fixtures/continuation-v0.11.1.md",
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
    package / "tests/fixtures/continuation-v0.11.1.md"
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
        "expected_checkpoint:",
        "wait_boundary_reached:",
        "observed_progress:",
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
render_record = json.loads((package / "tests/render-results-v0.12.1.json").read_text())
assert render_record["canonicalCapsuleSha256"] == canonical_hash
fixture_map = {
    "teamplay-coder": ("task-standard-v0.12.md", "standard"),
    "teamplay-coder-fast": ("task-fast-v0.12.md", "fast"),
    "teamplay-coder-deep": ("task-terra-v0.12.md", "terra"),
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
    "DEFAULT_IMPLEMENTATION_CODER = Luna max",
    "T1 explicit_user_terra",
    "T2 evidenced_luna_capability_blocker",
    "No Teamplay child may use GPT-5.6 Sol",
    "Terra xhigh is the maximum allowed child route",
    "LUNA_IMPLEMENTATION_FLOOR = 90% audit threshold, never a quota",
    "TERRA_ALLOCATION_BUDGET = 0",
    "Never create Terra to approach 10%",
    "Without T1 or T2",
    "does not satisfy T2",
    "Never run more than three mutating Coders",
    "sole normative source",
    "Final Gate judgment is a phase owned directly by that Lead",
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
    "LC-07",
    "wait",
    "message/reuse",
    "resume",
    "redirect",
    "restart",
    "takeover",
    "close",
    "CODER_STALLED",
    "input_cached",
    "input_uncached",
    "output",
    "reasoning",
    "provider billing",
    "reflexively poll",
    "Closing a child to release capacity does not authorize a replacement",
    "locked whole outcome to the current main Lead",
    "must not prescribe keystrokes",
    "wait_agent",
    "interrupt:false",
    "`running` with",
    "liveness",
):
    assert phrase in continuity, f"continuity contract missing: {phrase}"

final_report = (package / "skills/teamplay/templates/final-report.md").read_text()
for phrase in (
    "Outcome continuity",
    "Lifecycle diagnostics",
    "Final implementation owner",
    "CODER_STALLED",
    "takeover",
    "message/reuse",
    "input_cached",
    "Billing inferred: no",
    "90% Luna floor audit",
    "NOT_MEANINGFUL_SAMPLE",
    "Lead final Gate",
    "Gate child used: no",
    "Fresh-context audit selected",
    "fork_turns: none",
    "Advisory authority only; Lead Gate retained: yes",
    "Host status at each wait boundary",
    "wait_agent` timeout treated as terminal failure: no",
    "Redirect interruption mode",
):
    assert phrase in final_report, f"final report missing: {phrase}"

spec_contract = (package / "skills/teamplay/references/spec-contract.md").read_text()
assert "Merely touching a named artifact does not trigger Full Lock" in spec_contract
brief_template = (package / "skills/teamplay/templates/spec-brief.md").read_text()
full_template = (package / "skills/teamplay/templates/spec-contract.md").read_text()
for text in (brief_template, full_template):
    assert "Must be empty before any mutating Coder starts" in text
for phrase in (
    "Compact five-part Spec Brief",
    "## 1. Objective",
    "## 2. Ownership",
    "## 3. Interfaces",
    "## 4. Constraints",
    "## 5. Verification",
    "Stable requirements",
    "Requirement mapping and invalidation condition",
):
    assert phrase in brief_template, f"compact Brief missing: {phrase}"

reviewer = agents["teamplay-reviewer"]
for phrase in (
    "complete revision-locked specification",
    "only code or a prose goal summary",
    "cannot approve, veto, repair, or Gate",
    "current main Lead",
):
    assert phrase in reviewer["developer_instructions"], phrase
review_packet = (package / "skills/teamplay/templates/review-packet.md").read_text()
for phrase in (
    "context_policy: fresh",
    "fork_turns: none",
    "complete_spec_available: true",
    "runtime_identity_evidence",
    "only a code diff or prose goal summary",
    "never Lead approval",
):
    assert phrase in review_packet, f"review packet missing: {phrase}"

legacy_manifest = (package / "scripts/legacy-0.12.2.sha256").read_text().splitlines()
legacy_entries = {}
for line in legacy_manifest:
    if not line.strip():
        continue
    digest, path = line.split(maxsplit=1)
    legacy_entries.setdefault(path, set()).add(digest)
critical_legacy = package / "tests/fixtures/install/teamplay-critical-0.12.2.md"
assert hashlib.sha256(
    critical_legacy.read_bytes()
).hexdigest() in legacy_entries["skills/teamplay-critical/SKILL.md"]
installer_text = (package / "scripts/install.sh").read_text()
for fixture_name, expected_var in (
    ("teamplay-lead-obsolete.toml", "LEAD_OBSOLETE_SHA"),
    ("teamplay-gate-obsolete.toml", "GATE_OBSOLETE_SHA"),
):
    digest = hashlib.sha256(
        (package / "tests/fixtures/install" / fixture_name).read_bytes()
    ).hexdigest()
    assert f"{expected_var}={digest}" in installer_text

delivery = (package / "skills/teamplay/references/delivery-speed.md").read_text()
assert "Pool count, writer independence, and isolation are defined only" in delivery
assert "LEAD_QA bounded failure -> next available REPAIR slot" in delivery
assert "Any failure after REPAIR_2 -> REPLAN/BLOCKED" in delivery

fixtures = (package / "tests/routing-fixtures.md").read_text()
for index in range(1, 19):
    assert f"DR-{index:02d}" in fixtures, f"routing fixture missing: DR-{index:02d}"
for live in ("LC-STD", "LC-FAST", "LC-TERRA", "LC-NO-SOL", "LC-NO-GATE"):
    assert live in fixtures
results = (package / "tests/routing-results-v0.10.md").read_text()
assert "14/14 static classifications" in results
assert results.count("NOT_PROVEN") >= 3
results_011 = (package / "tests/routing-results-v0.11.md").read_text()
assert "14/14 preserved routing classifications" in results_011
assert "7/7 lifecycle classifications" in results_011
results_0111 = (package / "tests/routing-results-v0.11.1.md").read_text()
assert "14/14 preserved routing classifications" in results_0111
assert "7/7 lifecycle contract" in results_0111
assert "10/10 lifecycle fixtures" in results_0111
results_012 = (package / "tests/routing-results-v0.12.md").read_text()
for phrase in (
    "16/16 static routing classifications PASS",
    "gpt-5.6-sol` agent entries: 0",
    "Every Luna role, including Default/Fast Coders: Luna max",
    "Exception Coder: Terra xhigh",
    "Sol implementation, review, QA, Gate, and rescue routes: prohibited",
):
    assert phrase in results_012, f"0.12 routing result missing: {phrase}"
results_0121 = (package / "tests/routing-results-v0.12.1.md").read_text()
for phrase in (
    "18/18 static routing and ownership classifications PASS",
    "Main Lead owns final Gate",
    "Gate child absent from bundle",
    "Gate child absent from install",
    "Every Luna role remains max",
    "Luna 90% is a lower-bound audit alarm",
    "Terra allocation budget and reserved share are zero",
    "without T1/T2 routes 100%",
    "Mermaid flow",
):
    assert phrase in results_0121, f"0.12.1 routing result missing: {phrase}"

lifecycle_fixtures = (package / "tests/lifecycle-fixtures.md").read_text()
for fixture in (
    "LF-01", "LF-02", "LF-03", "LF-04", "LF-05", "LF-06", "LF-07",
    "LF-08", "LF-09", "LF-10", "LF-11", "LF-12", "LF-13",
):
    assert fixture in lifecycle_fixtures, f"lifecycle fixture missing: {fixture}"
assert "spawn, wait, message/reuse, resume, redirect, restart," in lifecycle_fixtures
assert "takeover, and close" in lifecycle_fixtures
lifecycle_results = (
    package / "tests/lifecycle-results-v0.11.1.md"
).read_text()
for phrase in (
    "10/10 PASS",
    "LC-01",
    "LC-02",
    "LC-03",
    "LC-04",
    "LC-05",
    "LC-06",
    "LC-07",
    "CODER_STALLED",
    "takeover",
    "input_cached",
    "input_uncached",
    "Billing",
):
    assert phrase in lifecycle_results, f"lifecycle result missing: {phrase}"
lifecycle_results_0131 = (
    package / "tests/lifecycle-results-v0.13.1.md"
).read_text()
for phrase in (
    "13/13 PASS",
    "wait_agent",
    "running/recent activity",
    "interrupt:false",
    "two evidenced inactivity windows",
):
    assert phrase in lifecycle_results_0131, f"0.13.1 lifecycle result missing: {phrase}"

license_text = (package / "LICENSE").read_text()
assert license_text.startswith("MIT License\n")
assert "Copyright (c) 2026 Young Changjo" in license_text

readme = (package / "README.md").read_text()
for role_name in expected:
    assert role_name in readme, f"README missing role: {role_name}"
for phrase in (
    "Why Luna first",
    "Luna max is the default and first implementation Coder",
    "Teamplay never creates a Sol child",
    "Terra xhigh is the strongest Teamplay child",
    "$1 / $0.10 / $6",
    "$2.50 / $0.25 / $15",
    "25 / 2.5 / 150",
    "62.5 / 6.25 / 375",
    "Sol | $5 / $0.50 / $30 | 125 / 12.5 / 750 | 100% | 0%",
    "Luna | $1 / $0.10 / $6 | 25 / 2.5 / 150 | 20% | 80%",
    "Estimated savings versus an all-Sol implementation baseline",
    "100% Luna, no Terra exception | 20% | **80%**",
    "These are estimates, not billing claims",
    "[한국어](README.ko.md)",
    "## At a glance",
    "```mermaid",
    "Main Lead final Gate",
    "### Common routing decisions",
    "No installed Teamplay role uses Sol, and no Gate role is installed",
    "90% is only a lower-bound audit alarm",
    "Allocation budget 0; no reserved percentage",
    "If no T1 or T2 exception",
    "## Why the Main Lead reviews, runs QA, and performs Gate",
    "Coder approving or rationalizing its own work",
    "five implementation-facing",
    "fork_turns: none",
    "Ordinary runs do not create this reviewer",
    "never overwrites a modified local Teamplay file",
    "inspect-agent-runtime.sh",
    "wait_agent` timing out",
    "interrupt:true",
    "active pre-mutation analysis",
):
    assert phrase in readme, f"README missing cost-first contract: {phrase}"
for stale in ("$0.20/$0.02/$1.20", "`1/25` ratio", "Sol max |"):
    assert stale not in readme, f"README contains stale routing/pricing: {stale}"
assert "`teamplay-gate`" not in readme
assert not (package / "agents/teamplay-gate.toml").exists()
installer = (package / "scripts/install.sh").read_text()
for phrase in (
    "--check",
    "legacy-0.12.2.sha256",
    "preflight failed; target was not changed",
    "will not be replaced",
    "classify_obsolete",
    "REMOVED EXACT OBSOLETE",
):
    assert phrase in installer, f"installer missing safety contract: {phrase}"
assert 'rm -f "$TARGET_AGENTS_DIR/teamplay-gate.toml"' not in installer

readme_ko = (package / "README.ko.md").read_text()
for phrase in (
    "[English](README.md)",
    "본체 Lead: 사양 -> 통합 -> 리뷰 -> QA -> Gate",
    "배정 예산 0, 예약 비율 없음",
    "왜 Luna를 먼저 쓰나",
    "Sol을 100% 기준으로 비교했습니다",
    "Luna | $1 / $0.10 / $6 | 25 / 2.5 / 150 | 20% | 80%",
    "전부 Sol로 구현했을 때와 비교한 예상 절감",
    "Luna 100%, Terra 예외 없음 | 20% | **80%**",
    "청구 금액이 아니라 가정에 따른 추정",
    "왜 본체가 리뷰·QA·Gate를 하나",
    "```mermaid",
    "설치되는 Teamplay 역할에는 Sol도 Gate도 없습니다",
    "다섯 구현 섹션",
    "fork_turns: none",
    "수정된 로컬 Teamplay 파일을 덮어쓰지 않습니다",
    "runtime inspector",
    "`wait_agent` timeout",
    "`interrupt:true`",
    "파일 수정 전 분석",
):
    assert phrase in readme_ko, f"Korean README missing contract: {phrase}"
for role_name in expected:
    assert role_name in readme_ko, f"Korean README missing role: {role_name}"
assert "`teamplay-gate`" not in readme_ko

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
sh -n "$PACKAGE_DIR/skills/teamplay/scripts/inspect-agent-runtime.sh"

TEST_ROOT=$(mktemp -d "${TMPDIR:-/tmp}/teamplay-validate.XXXXXX")
cleanup_tests() {
  case "$TEST_ROOT" in
    "${TMPDIR:-/tmp}"/teamplay-validate.*) rm -rf "$TEST_ROOT" ;;
    *) printf '%s\n' "ERROR: refusing cleanup of unexpected validation path" >&2 ;;
  esac
}
trap cleanup_tests 0 HUP INT TERM

snapshot_target() {
  target=$1
  find "$target" -type f -print | LC_ALL=C sort | while IFS= read -r file; do
    printf '%s  %s\n' "$(shasum -a 256 "$file" | awk '{print $1}')" "${file#"$target"/}"
  done
}

INSTALLER="$PACKAGE_DIR/scripts/install.sh"
CLEAN_TARGET="$TEST_ROOT/clean"
"$INSTALLER" --target-codex-dir "$CLEAN_TARGET" >/dev/null
"$INSTALLER" --target-codex-dir "$CLEAN_TARGET" --check >/dev/null
before=$(snapshot_target "$CLEAN_TARGET")
"$INSTALLER" --target-codex-dir "$CLEAN_TARGET" >/dev/null
after=$(snapshot_target "$CLEAN_TARGET")
[ "$before" = "$after" ] || { printf '%s\n' "idempotent install changed files" >&2; exit 1; }

MIGRATION_TARGET="$TEST_ROOT/migration"
"$INSTALLER" --target-codex-dir "$MIGRATION_TARGET" >/dev/null
cp "$PACKAGE_DIR/tests/fixtures/install/teamplay-critical-0.12.2.md" \
  "$MIGRATION_TARGET/skills/teamplay-critical/SKILL.md"
"$INSTALLER" --target-codex-dir "$MIGRATION_TARGET" >/dev/null
cmp -s "$PACKAGE_DIR/skills/teamplay-critical/SKILL.md" \
  "$MIGRATION_TARGET/skills/teamplay-critical/SKILL.md" || {
  printf '%s\n' "exact 0.12.2 migration failed" >&2; exit 1;
}

CONFLICT_TARGET="$TEST_ROOT/conflict"
"$INSTALLER" --target-codex-dir "$CONFLICT_TARGET" >/dev/null
printf '%s\n' "user modification" >> "$CONFLICT_TARGET/agents/teamplay-coder.toml"
before=$(snapshot_target "$CONFLICT_TARGET")
if "$INSTALLER" --target-codex-dir "$CONFLICT_TARGET" >/dev/null 2>&1; then
  printf '%s\n' "installer accepted a modified destination" >&2; exit 1
fi
after=$(snapshot_target "$CONFLICT_TARGET")
[ "$before" = "$after" ] || { printf '%s\n' "conflict caused partial mutation" >&2; exit 1; }

MISSING_TARGET="$TEST_ROOT/missing"
if "$INSTALLER" --target-codex-dir "$MISSING_TARGET" --check >/dev/null 2>&1; then
  printf '%s\n' "--check accepted a missing installation" >&2; exit 1
fi
[ ! -e "$MISSING_TARGET" ] || { printf '%s\n' "--check mutated missing target" >&2; exit 1; }

SYMLINK_TARGET="$TEST_ROOT/symlink"
mkdir -p "$SYMLINK_TARGET/agents"
ln -s "$PACKAGE_DIR/agents/teamplay-coder.toml" "$SYMLINK_TARGET/agents/teamplay-coder.toml"
if "$INSTALLER" --target-codex-dir "$SYMLINK_TARGET" >/dev/null 2>&1; then
  printf '%s\n' "installer accepted a symlinked destination" >&2; exit 1
fi
[ ! -e "$SYMLINK_TARGET/skills" ] || { printf '%s\n' "symlink refusal partially installed skills" >&2; exit 1; }

OBSOLETE_TARGET="$TEST_ROOT/obsolete"
"$INSTALLER" --target-codex-dir "$OBSOLETE_TARGET" >/dev/null
cp "$PACKAGE_DIR/tests/fixtures/install/teamplay-lead-obsolete.toml" "$OBSOLETE_TARGET/agents/teamplay-lead.toml"
cp "$PACKAGE_DIR/tests/fixtures/install/teamplay-gate-obsolete.toml" "$OBSOLETE_TARGET/agents/teamplay-gate.toml"
"$INSTALLER" --target-codex-dir "$OBSOLETE_TARGET" >/dev/null
[ ! -e "$OBSOLETE_TARGET/agents/teamplay-lead.toml" ] || { printf '%s\n' "exact obsolete Lead remained" >&2; exit 1; }
[ ! -e "$OBSOLETE_TARGET/agents/teamplay-gate.toml" ] || { printf '%s\n' "exact obsolete Gate remained" >&2; exit 1; }
printf '%s\n' "user-owned gate" > "$OBSOLETE_TARGET/agents/teamplay-gate.toml"
before=$(snapshot_target "$OBSOLETE_TARGET")
if "$INSTALLER" --target-codex-dir "$OBSOLETE_TARGET" >/dev/null 2>&1; then
  printf '%s\n' "installer removed an unknown obsolete-name file" >&2; exit 1
fi
after=$(snapshot_target "$OBSOLETE_TARGET")
[ "$before" = "$after" ] || { printf '%s\n' "obsolete conflict caused partial mutation" >&2; exit 1; }

INSPECTOR="$PACKAGE_DIR/skills/teamplay/scripts/inspect-agent-runtime.sh"
SESSIONS="$TEST_ROOT/sessions"
SESSION_DAY="$SESSIONS/2026/08/03"
mkdir -p "$SESSION_DAY"
GOOD_ID=11111111-1111-7111-8111-111111111111
GOOD_FILE="$SESSION_DAY/rollout-2026-08-03T00-00-00-$GOOD_ID.jsonl"
printf '%s\n' \
  '{"timestamp":"2026-08-03T00:00:00Z","type":"response_item","payload":{"prompt":"DO_NOT_LEAK_PROMPT"}}' \
  "{\"timestamp\":\"2026-08-03T00:00:01Z\",\"type\":\"session_meta\",\"payload\":{\"id\":\"$GOOD_ID\",\"parent_thread_id\":\"00000000-0000-7000-8000-000000000000\",\"agent_role\":\"teamplay-reviewer\",\"agent_path\":\"/fixture\",\"model_provider\":\"openai\"}}" \
  '{"timestamp":"2026-08-03T00:00:02Z","type":"turn_context","payload":{"model":"gpt-5.6-terra","effort":"high","service_tier":"default","sandbox_policy":{"type":"read-only"},"permission_profile":{"type":"disabled"},"cwd":"/fixture"}}' \
  '{"timestamp":"2026-08-03T00:00:03Z","type":"response_item","payload":{"type":"reasoning","summary":"DO_NOT_LEAK_REASONING"}}' \
  '{"timestamp":"2026-08-03T00:00:04Z","type":"response_item","payload":{"type":"custom_tool_call","input":"DO_NOT_LEAK_TOOL"}}' \
  '{"timestamp":"2026-08-03T00:00:05Z","type":"event_msg","payload":{"type":"token_count","message":"DO_NOT_LEAK_TOKEN"}}' \
  > "$GOOD_FILE"
runtime_output=$("$INSPECTOR" --sessions-dir "$SESSIONS" --expect-role teamplay-reviewer \
  --expect-model gpt-5.6-terra --expect-effort high --expect-service-tier default \
  --require-isolation "$GOOD_ID")
printf '%s\n' "$runtime_output" | jq -e '
  .agent_role == "teamplay-reviewer" and .model == "gpt-5.6-terra"
  and .effort == "high" and .sandbox_policy_type == "read-only"
  and .sandbox_observed and .permission_observed
  and .sandbox_complete and .permission_complete
  and .last_activity_at == "2026-08-03T00:00:05Z"
  and .activity_event_count == 3 and .reasoning_event_count == 1
  and .tool_call_count == 1 and .token_event_count == 1
' >/dev/null || { printf '%s\n' "runtime inspector returned wrong evidence" >&2; exit 1; }
printf '%s\n' "$runtime_output" | grep -Eq 'DO_NOT_LEAK_(PROMPT|REASONING|TOOL|TOKEN)' && {
  printf '%s\n' "runtime inspector leaked prompt payload" >&2; exit 1;
}

NO_ISOLATION_ID=22222222-2222-7222-8222-222222222222
printf '%s\n' \
  "{\"type\":\"session_meta\",\"payload\":{\"id\":\"$NO_ISOLATION_ID\",\"agent_role\":\"teamplay-reviewer\"}}" \
  '{"type":"turn_context","payload":{"model":"gpt-5.6-terra","effort":"high","cwd":"/fixture"}}' \
  > "$SESSION_DAY/rollout-2026-08-03T00-00-01-$NO_ISOLATION_ID.jsonl"
"$INSPECTOR" --sessions-dir "$SESSIONS" "$NO_ISOLATION_ID" | jq -e '
  (.sandbox_observed == false) and (.permission_observed == false)
' >/dev/null || { printf '%s\n' "unobserved isolation was not explicit" >&2; exit 1; }
if "$INSPECTOR" --sessions-dir "$SESSIONS" --require-isolation "$NO_ISOLATION_ID" >/dev/null 2>&1; then
  printf '%s\n' "isolation-required inspection accepted missing isolation" >&2; exit 1
fi

MISSING_MODEL_ID=33333333-3333-7333-8333-333333333333
printf '%s\n' \
  "{\"type\":\"session_meta\",\"payload\":{\"id\":\"$MISSING_MODEL_ID\",\"agent_role\":\"teamplay-reviewer\"}}" \
  '{"type":"turn_context","payload":{"effort":"high","cwd":"/fixture"}}' \
  > "$SESSION_DAY/rollout-2026-08-03T00-00-02-$MISSING_MODEL_ID.jsonl"
if "$INSPECTOR" --sessions-dir "$SESSIONS" "$MISSING_MODEL_ID" >/dev/null 2>&1; then
  printf '%s\n' "runtime inspector accepted a missing model" >&2; exit 1
fi

CONFLICT_MODEL_ID=44444444-4444-7444-8444-444444444444
printf '%s\n' \
  "{\"type\":\"session_meta\",\"payload\":{\"id\":\"$CONFLICT_MODEL_ID\",\"agent_role\":\"teamplay-reviewer\"}}" \
  '{"type":"turn_context","payload":{"model":"gpt-5.6-terra","effort":"high","cwd":"/fixture"}}' \
  '{"type":"turn_context","payload":{"model":"gpt-5.6-luna","effort":"high","cwd":"/fixture"}}' \
  > "$SESSION_DAY/rollout-2026-08-03T00-00-03-$CONFLICT_MODEL_ID.jsonl"
if "$INSPECTOR" --sessions-dir "$SESSIONS" "$CONFLICT_MODEL_ID" >/dev/null 2>&1; then
  printf '%s\n' "runtime inspector accepted conflicting models" >&2; exit 1
fi

printf '%s\n' "Operational hardening fixtures: PASS"
