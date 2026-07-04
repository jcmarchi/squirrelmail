---
name: buildline-vertical-slice
description: Execute one bounded product slice across the applicable Buildline layers without expanding into unrelated Foundation work.
---

# Buildline Vertical Slice Skill

Use this skill when implementing a feature, workflow, screen, endpoint, import, admin action, or user-visible behavior.

## Required Inputs

Read:

```text
QLI.md
.qli/project/current-slice.yml
.qli/project/context-packet.yml
.qli/project/foundation-applicability.yml
.qli/project/foundation-status.yml
.qli/workflows/vertical-slice-protocol.md
.qli/gates/slice-definition-of-done.md
.qli/evidence/slice-evidence-template.md
```

Read only the Foundation implementation controls triggered by the slice.

## Procedure

1. Restate the slice objective, included scope, excluded scope, and risk.
2. Inspect current implementation before editing.
3. Implement the smallest product-relevant vertical path through applicable layers.
4. Do not create isolated backend-only work unless the slice is explicitly backend-only and has an API/CLI/smoke surface.
5. Add or update focused tests and a human smoke path.
6. Update evidence and foundation status.

## Required Output

```text
Vertical Slice Result:
- Slice:
- Product behavior changed:
- Layers touched:
- Tests/checks:
- Human smoke path:
- Evidence updated:
- Deferrals:
- Next action:
```

## Stop Conditions

Stop if the requested change requires unapproved schema migration, auth/ACL redesign, stack change, unrelated UI redesign, or global architecture replacement.
