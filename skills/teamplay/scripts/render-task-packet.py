#!/usr/bin/env python3
"""Render one Teamplay task with the canonical execution capsule."""

from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import sys


BEGIN = "---BEGIN TEAMPLAY EXECUTION CAPSULE v1---"
END = "---END TEAMPLAY EXECUTION CAPSULE v1---"


def normalize_final_newline(value: str) -> str:
    return value.rstrip("\n") + "\n"


def extract_capsule(policy: str) -> str:
    if policy.count(BEGIN) != 1 or policy.count(END) != 1:
        raise ValueError("canonical policy must contain exactly one capsule")
    start = policy.index(BEGIN)
    finish = policy.index(END, start) + len(END)
    capsule = policy[start:finish]
    return normalize_final_newline(capsule)


def digest(value: str) -> str:
    return hashlib.sha256(value.encode("utf-8")).hexdigest()


def render(policy_path: Path, task_path: Path) -> tuple[str, dict[str, object]]:
    capsule = extract_capsule(policy_path.read_text(encoding="utf-8"))
    task = normalize_final_newline(task_path.read_text(encoding="utf-8"))
    if BEGIN in task or END in task:
        raise ValueError("task capsule must not contain execution delimiters")
    rendered = capsule + "\n" + task
    metadata: dict[str, object] = {
        "policyVersion": "TEAMPLAY-EXEC-1",
        "canonicalCapsuleSha256": digest(capsule),
        "taskSha256": digest(task),
        "renderedPromptSha256": digest(rendered),
        "beginDelimiterCount": rendered.count(BEGIN),
        "endDelimiterCount": rendered.count(END),
        "renderedCharacters": len(rendered),
    }
    return rendered, metadata


def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("--policy", required=True, type=Path)
    parser.add_argument("--task", required=True, type=Path)
    parser.add_argument("--metadata-only", action="store_true")
    args = parser.parse_args()

    try:
        rendered, metadata = render(args.policy, args.task)
    except (OSError, ValueError) as error:
        print(f"render-task-packet: {error}", file=sys.stderr)
        return 1

    if args.metadata_only:
        print(json.dumps(metadata, sort_keys=True))
    else:
        sys.stdout.write(rendered)
        print(json.dumps(metadata, sort_keys=True), file=sys.stderr)
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
