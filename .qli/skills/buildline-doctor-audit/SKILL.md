---
name: buildline-doctor-audit
description: Run or interpret QLi Buildline doctor checks and separate structural defects from historical/archive references.
---

# Buildline Doctor Audit Skill

Use this skill when verifying the skeleton, Buildline package, or project integration.

## Required Inputs

Read:

```text
QLI.md
.qli/tools/qli-buildline-doctor.sh
.qli/tools/qli-buildline-doctor.py
```

Use whichever doctor runner is available:

```bash
bash .qli/tools/qli-buildline-doctor.sh .
python .qli/tools/qli-buildline-doctor.py .
```

## Procedure

1. Run the doctor when possible.
2. If execution is unavailable, inspect required files manually.
3. Treat active execution-path failures as defects.
4. Treat archived historical references as non-active unless the doctor flags them incorrectly.
5. Report failures and warnings separately.
6. Do not edit unrelated application files during a doctor audit.

## Required Output

```text
Doctor Audit:
- Runner used:
- Failures:
- Warnings:
- Active defects:
- False positives:
- Patch required:
```

## Stop Conditions

Stop if the root path is uncertain or the doctor output cannot be tied to the current skeleton/project.
