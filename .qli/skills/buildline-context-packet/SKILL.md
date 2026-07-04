---
name: buildline-context-packet
description: Create or refresh the minimum QLi Buildline context packet for a task without loading the entire Foundation package.
---

# Buildline Context Packet Skill

Use this skill when the agent needs a compact, current context packet before planning or implementation.

## Required Inputs

Read only:

```text
QLI.md
.qli/project/manifest.yml
.qli/project/operating-profile.yml
.qli/project/foundation-target.yml
.qli/project/foundation-applicability.yml
.qli/project/foundation-status.yml
.qli/project/current-slice.yml
.qli/binding/context-packet.schema.yml
.qli/workflows/context-packet-protocol.md
```

## Procedure

1. Identify the current task objective.
2. Identify the current project mode: new project, active development, hardening, audit, or maintenance.
3. Determine triggered foundations from the task and `.qli/project/foundation-applicability.yml`.
4. Record only the minimum required files, commands, risks, and gates in `.qli/project/context-packet.yml`.
5. Do not read unrelated Foundation references.
6. Do not implement code while creating the context packet.

## Required Output

Update or propose updates to:

```text
.qli/project/context-packet.yml
```

Then report:

```text
Context Packet:
- Task:
- Mode:
- Triggered foundations:
- Required files to read next:
- Stop conditions:
- Validation gate:
```

## Stop Conditions

Stop if the project identity, target level, current slice, or foundation applicability is missing or contradictory.
