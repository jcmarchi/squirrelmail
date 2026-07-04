---
name: buildline-evidence-report
description: Produce a concise Buildline implementation evidence report after a coding, audit, or hardening pass.
---

# Buildline Evidence Report Skill

Use this skill at the end of implementation work or when summarizing a completed pass.

## Required Inputs

Read:

```text
QLI.md
.qli/evidence/implementation-report-template.md
.qli/evidence/slice-evidence-template.md
.qli/project/current-slice.yml
.qli/project/foundation-status.yml
.qli/project/evidence-log.md
.qli/project/deferral-register.md
```

## Procedure

1. Summarize only what was actually changed or verified.
2. State validation tier and commands/checks run.
3. State tests not run and why.
4. Include human smoke path or say not applicable with reason.
5. Record triggered foundations, status updates, evidence, deferrals, and blockers.
6. Do not claim completion without proof.

## Required Output

```text
Summary:
Validation:
Application Construction:
Buildline Status:
Triggered Foundations:
Evidence:
Deferrals:
Blocking Gaps:
Next Step:
```

## Stop Conditions

Stop if the implementation state is unknown, tests were not run and no reason is available, or evidence contradicts the claimed result.
