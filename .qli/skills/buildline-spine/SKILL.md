---
name: buildline-spine
description: Implement or review the upfront QLi Buildline Spine so a project has a usable structure before feature expansion.
---

# Buildline Spine Skill

Use this skill when establishing the minimum upfront implementation baseline for a new or newly bound project.

## Required Inputs

Read:

```text
QLI.md
.qli/spine/README.md
.qli/spine/spine-checklist.md
.qli/project/foundation-applicability.yml
.qli/project/foundation-status.yml
.qli/project/current-slice.yml
.qli/gates/foundation-gate.md
.qli/gates/human-smoke-test-gate.md
```

Read only the implementation-control files for foundations marked required or partial in `.qli/project/foundation-applicability.yml`.

## Procedure

1. Identify required Spine items from project applicability.
2. Implement or review only the minimum operational spine needed to prevent predictable technical debt.
3. Prefer placeholders only when they preserve real routes, contracts, testability, or human review surfaces.
4. Ensure UI/API/ACL/DATA/testing/runtime/security/observability/delivery are represented according to applicability.
5. Update evidence and status after changes.

## Required Output

```text
Spine Result:
- Implemented:
- Placeholder but testable:
- Deferred with register entry:
- Human smoke path:
- Tests/checks:
- Remaining gaps:
```

## Stop Conditions

Stop if the work expands into full feature development, stack replacement, or unapproved enterprise machinery.
