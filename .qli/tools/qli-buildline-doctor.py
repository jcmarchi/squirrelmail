#!/usr/bin/env python3
"""QLi Buildline Doctor for the Universal Skeleton new-project baseline."""
from __future__ import annotations
import argparse
import re
from pathlib import Path

REQUIRED_FILES = [
    "AGENTS.md", "QLI.md", "SKILLS.md", "CLAUDE.md", "CODEX.md",
    ".qli/buildline.yml", ".qli/README.md", ".qli/BUILDGUIDE.md", ".qli/foundation-map.yml",
    ".qli/agents/README.md", ".qli/agents/AGENTS.foundation-block.md", ".qli/agents/AGENTS.integration-rules.md", ".qli/agents/AGENTS.generation-template.md", ".qli/agents/AGENTS.prompt-control-block.md",
    ".qli/skills/README.md", ".qli/skills/skill-index.yml", ".qli/skills/buildline-context-packet/SKILL.md", ".qli/skills/buildline-bind-project/SKILL.md", ".qli/skills/buildline-spine/SKILL.md", ".qli/skills/buildline-vertical-slice/SKILL.md", ".qli/skills/buildline-gate-review/SKILL.md", ".qli/skills/buildline-evidence-report/SKILL.md", ".qli/skills/buildline-doctor-audit/SKILL.md", ".qli/skills/buildline-agent-integration/SKILL.md",
    ".qli/binding/README.md", ".qli/binding/project-classifier.md", ".qli/binding/project-profile.schema.yml", ".qli/binding/foundation-applicability-algorithm.md", ".qli/binding/foundation-applicability-output-template.yml", ".qli/binding/foundation-applicability-rules.yml", ".qli/binding/foundation-target-levels.yml", ".qli/binding/implementation-priority-rules.md", ".qli/binding/deferral-rules.md", ".qli/binding/agent-context-loading-rules.md", ".qli/binding/context-packet.schema.yml",
    ".qli/project/manifest.yml", ".qli/project/operating-profile.yml", ".qli/project/foundation-target.yml", ".qli/project/foundation-applicability.yml", ".qli/project/foundation-status.yml", ".qli/project/current-slice.yml", ".qli/project/context-packet.yml", ".qli/project/buildline-plan.md", ".qli/project/prompt-log.md", ".qli/project/evidence-log.md", ".qli/project/deferral-register.md", ".qli/project/skills/.gitkeep",
    ".qli/spine/README.md", ".qli/spine/spine-checklist.md",
    ".qli/workflows/new-project-implementation.md", ".qli/workflows/foundation-spine-implementation.md", ".qli/workflows/vertical-slice-protocol.md", ".qli/workflows/controlled-prompt-protocol.md", ".qli/workflows/context-packet-protocol.md", ".qli/workflows/stop-conditions.md", ".qli/workflows/prompt-usage-lifecycle.md",
    ".qli/gates/foundation-gate.md", ".qli/gates/slice-definition-of-done.md", ".qli/gates/human-smoke-test-gate.md", ".qli/gates/release-readiness-gate.md", ".qli/gates/prompt-readiness-gate.md", ".qli/gates/prompt-completion-gate.md",
    ".qli/evidence/slice-evidence-template.md", ".qli/evidence/implementation-report-template.md",
    ".qli/handoff/README.md", ".qli/handoff/NEW_PROJECT_CUSTOMIZATION_GUIDE.md", ".qli/handoff/AI_COARCHITECT_CUSTOMIZATION_PROMPT.md", ".qli/handoff/FIRST_CODING_AGENT_PROMPT_TEMPLATE.md",
    ".qli/acd/specs/application-construction-doctrine.md", ".qli/acd/specs/acd-implementation-control.md", ".qli/uiux/specs/ui-foundation-reference.md", ".qli/uiux/specs/ui-implementation-control.md", ".qli/data/specs/data-foundation-reference.md", ".qli/data/specs/data-implementation-control.md", ".qli/api/specs/api-foundation-reference.md", ".qli/api/specs/api-implementation-control.md", ".qli/acl/specs/access-control-reference.md", ".qli/acl/specs/acl-implementation-control.md", ".qli/security/specs/security-foundation-reference.md", ".qli/security/specs/security-implementation-control.md", ".qli/test/specs/testing-foundation-reference.md", ".qli/test/specs/testing-implementation-control.md", ".qli/rof/specs/runtime-foundation-reference.md", ".qli/rof/specs/runtime-implementation-control.md", ".qli/oat/specs/observability-foundation-reference.md", ".qli/oat/specs/observability-implementation-control.md", ".qli/deployment/specs/delivery-foundation-reference.md", ".qli/deployment/specs/delivery-implementation-control.md", ".qli/devbox/README.md", ".qli/devbox/devbox-implementation-control.md",
    ".qli/prompts/compact/INDEX.md", ".qli/prompts/compact/00-context-packet.md", ".qli/prompts/compact/01-bind-project.md", ".qli/prompts/compact/02-build-foundation-spine.md", ".qli/prompts/compact/03-active-vertical-slice.md", ".qli/prompts/compact/04-gate-review.md", ".qli/prompts/compact/05-hardening-review.md", ".qli/prompts/compact/06-doctor-audit.md", ".qli/prompts/compact/07-agents-integration.md",
    ".qli/tools/qli-buildline-doctor.sh", ".qli/tools/qli-buildline-doctor.py",
]

REQUIRED_DIRS = [
    ".qli/agents", ".qli/binding", ".qli/project", ".qli/spine", ".qli/workflows", ".qli/gates", ".qli/evidence", ".qli/prompts/compact", ".qli/skills", ".qli/handoff", ".qli/tools", ".qli/reports"
]

MUST_NOT_EXIST = [
    ".qli/kickstart",
    ".qli/tools/qli-kickstart.py", ".qli/tools/qli-kickstart.ps1", ".qli/tools/qli-kickstart.sh",
    ".qli/skills/buildline-kickstart", ".qli/skills/buildline-existing-intake",
    ".qli/workflows/existing-project-adoption.md",
    ".qli/prompts/compact/03-existing-project-intake.md", ".qli/prompts/compact/04-existing-adoption-slice.md", ".qli/prompts/compact/10-project-kickstart.md",
    ".qli/project/adoption-intake.md", ".qli/project/adoption-plan.md", ".qli/project/behavior-snapshot.md", ".qli/project/risk-map.md",
    ".qli/validation", ".qli/legacy",
]

CONTENT_CHECKS = [
    ("AGENTS.md", "QLI.md", "AGENTS.md contains QLI.md reference"),
    ("AGENTS.md", "Project-Specific Agent Instructions", "AGENTS.md contains project-specific instruction section"),
    ("QLI.md", "QLi Buildline", "QLI.md contains QLi Buildline identity"),
    ("QLI.md", "new-project baseline", "QLI.md declares new-project baseline"),
    ("QLI.md", "foundation-applicability", "QLI.md contains foundation applicability state reference"),
    ("QLI.md", "doctor", "QLI.md contains doctor command reference"),
    ("QLI.md", "skill-index", "QLI.md contains skill index reference"),
    ("SKILLS.md", "skill-index.yml", "SKILLS.md contains skill index reference"),
    ("CLAUDE.md", "QLI.md", "CLAUDE.md contains QLI.md reference"),
    ("CODEX.md", "QLI.md", "CODEX.md contains QLI.md reference"),
]

AMBIGUITY_PATTERNS = [
    re.compile(r"(?<![A-Za-z0-9_.-])/docs/specs"),
    re.compile(r"foundation-adoption-refactoring-intake\.md"),
]

IGNORE_PREFIXES = [".qli/reports/"]
IGNORE_FILES = {".qli/tools/qli-buildline-doctor.py", ".qli/tools/qli-buildline-doctor.sh"}


def rel(path: Path, root: Path) -> str:
    return path.relative_to(root).as_posix()

def ok(msg: str): print(f"OK   {msg}")
def fail(msg: str): print(f"FAIL {msg}")
def warn(msg: str): print(f"WARN {msg}")

def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("root", nargs="?", default=".")
    args = ap.parse_args()
    root = Path(args.root).resolve()
    failures = 0
    warnings = 0

    print("QLi Buildline Doctor — New Project Baseline")
    print(f"Root: {root}\n")
    print("Root instruction files")

    for f in ["AGENTS.md", "QLI.md", "SKILLS.md", "CLAUDE.md", "CODEX.md"]:
        if (root/f).is_file(): ok(f)
        else: fail(f); failures += 1

    for file, needle, label in CONTENT_CHECKS:
        p = root/file
        if not p.exists():
            continue
        text = p.read_text(encoding="utf-8", errors="ignore")
        if needle in text: ok(label)
        else: fail(label); failures += 1

    print("")
    for d in REQUIRED_DIRS:
        if (root/d).is_dir(): ok(d + "/")
        else: fail(d + "/"); failures += 1
    for f in REQUIRED_FILES:
        if (root/f).is_file(): ok(f)
        else: fail(f); failures += 1

    print("\nNew-project-only cleanup checks")
    for item in MUST_NOT_EXIST:
        p = root/item
        if p.exists():
            fail(f"unexpected active existing/kickstart artifact: {item}")
            failures += 1
        else:
            ok(f"absent {item}")

    print("\nContent checks")
    print("\nActive ambiguity scan")
    for p in root.rglob("*"):
        if not p.is_file():
            continue
        rp = rel(p, root)
        if rp in IGNORE_FILES:
            continue
        if any(rp.startswith(prefix) for prefix in IGNORE_PREFIXES):
            continue
        if p.suffix.lower() not in {".md", ".txt", ".yml", ".yaml", ".sh", ".py", ".ps1"}:
            continue
        text = p.read_text(encoding="utf-8", errors="ignore")
        for pat in AMBIGUITY_PATTERNS:
            if pat.search(text):
                print(f"{rp}: {pat.pattern}")
                failures += 1

    print("\nSummary")
    print(f"Failures: {failures}")
    print(f"Warnings: {warnings}")
    return 1 if failures else 0

if __name__ == "__main__":
    raise SystemExit(main())
