# AI Coding Agent Prompt — Security Foundation Refactoring

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Use this prompt when reviewing or refactoring an existing project.

## Instruction

Do not replace working security behavior blindly. First inventory it, classify it, and preserve valid behavior while moving toward the Security Foundation.

## Required Process

1. Read `AGENTS.md`, the Project Operating Profile, and all files under `.qli/security/`.
2. Inspect existing authentication, sessions, authorization, routes, APIs, uploads/downloads, secrets/config, logs, dependencies, and tests.
3. Build or update Security Surface Inventory, Control Inventory, Secrets Inventory, Data Protection Matrix, and Test Matrix.
4. Identify gaps against the Security Trigger Matrix.
5. Refactor toward centralized, testable controls without breaking valid behavior.
6. Add regression tests for old behavior and negative tests for fixed risks.
7. Record temporary risks in the Exception Register.

## Prohibited Behavior

- Do not remove existing protections without replacement.
- Do not expand exposure while weakening controls.
- Do not introduce broad dependencies or frameworks without documented approval.
- Do not commit secrets or placeholder secrets that look real.
- Do not mark the refactor complete without reporting deferred risks.
