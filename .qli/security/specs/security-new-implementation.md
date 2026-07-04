# AI Coding Agent Prompt — Security Foundation for New Implementation

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Use this prompt when starting security-sensitive work in a new project.

## Instruction

Read `AGENTS.md`, `.qli/application-construction-doctrine.md`, `.qli/project-operating-profile.md`, and all files under `.qli/security/` before implementation.

Treat the Security Foundation as a posture-driven control system. Do not invent a security architecture from the deployment target alone.

## Required Process

1. Confirm or create the Project Operating Profile.
2. Create or update Security Posture.
3. Identify feature triggers from the Security Trigger Matrix.
4. Implement only the controls required for the current feature and posture, while preserving future evolution.
5. Coordinate with ACL, DATA, API, Runtime, Delivery, Observability, Testing, and UI foundations.
6. Update security inventories.
7. Add tests or smoke checks.
8. Report implemented controls and deferred risks.

## Completion Report

End with:

```text
Security Foundation:
- Posture Reviewed: yes/no
- Feature Triggers Activated: [list]
- Controls Implemented: [list]
- Inventories Updated: [list]
- Tests Added/Run: [list]
- Exceptions/Deferred Risks: [list]
```
