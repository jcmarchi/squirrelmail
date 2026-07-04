---
name: buildline-gate-review
description: Review a slice, phase, or release against QLi Buildline gates and identify blocking gaps.
---

# Buildline Gate Review Skill

Use this skill when a work pass, vertical slice, Spine pass, or release candidate needs review.

## Required Inputs

Read:

```text
QLI.md
.qli/gates/foundation-gate.md
.qli/gates/slice-definition-of-done.md
.qli/gates/human-smoke-test-gate.md
.qli/gates/release-readiness-gate.md
.qli/project/foundation-status.yml
.qli/project/evidence-log.md
.qli/project/deferral-register.md
```

## Procedure

1. Identify the gate being applied.
2. Compare delivered work against applicable Buildline state and evidence.
3. Separate blockers from non-blocking gaps.
4. Do not approve completion based only on code existence or test success.
5. Require human smoke path where applicable.

## Required Output

```text
Gate Review:
- Gate:
- Result: pass / partial / fail
- Blocking gaps:
- Non-blocking gaps:
- Evidence accepted:
- Evidence missing:
- Required next action:
```

## Stop Conditions

Stop if there is no evidence log, no current slice, or no declared validation tier.
