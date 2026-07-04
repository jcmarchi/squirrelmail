# AI Coding Agent Prompt — Existing Access-Control Refactoring

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Use when:** an existing application already has users, roles, permissions, admin checks, route guards, UI gating, or scattered authorization logic.

```text
You are refactoring an existing application's access-control implementation toward the Universal Access Control Foundation.

Before coding, read:
1. AGENTS.md
2. /docs/access-control-reference.md
3. /docs/access-control-mapping.md if present
4. Existing authentication, authorization, route, policy, role, permission, admin UI, API, test, seed, and audit-log code

First produce a short access-control inventory before changing behavior:
- current roles and where they are checked;
- route/API guards and unguarded protected routes;
- frontend-only authorization/gating;
- tenant/project/resource ownership boundaries;
- existing audit logging;
- high-risk operations;
- test coverage;
- known production behavior that must be preserved.

Refactoring rules:
- Preserve valid existing behavior unless explicitly instructed to migrate it.
- Do not remove legacy checks until central authorization coverage and tests exist.
- Create compatibility adapters/shims if needed.
- Map legacy roles to role categories.
- Map legacy checks to stable resource.action permissions.
- Classify routes and endpoints incrementally.
- Move authorization toward a centralized service/policy layer.
- Add server-side checks for any UI-only gated operation.
- Add cross-scope and negative tests before claiming security improvement.
- Update /docs/access-control-mapping.md, permission inventory, route inventory, and test matrix.

Do not perform a risky big-bang rewrite unless the repository is small and tests prove equivalence.
Do not create new role names for every old condition. Normalize to permissions, scopes, and policies.
Do not use hidden UI controls as proof of authorization.

End your response with:
Summary:
Validation:
Access Control Refactor:
- Existing Behavior Preserved:
- Legacy Checks Mapped:
- Centralized Enforcement Added:
- Routes Classified:
- Permissions Added/Migrated:
- Tests Added:
- Risks Remaining:
Next Step:
```
