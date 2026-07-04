# AI Coding Agent Prompt — New Access-Control Implementation

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Use when:** starting a new project or an early project with no serious access-control foundation yet.

```text
You are implementing the project's access-control foundation.

Before coding, read:
1. AGENTS.md
2. /docs/access-control-reference.md
3. /docs/access-control-mapping.md if present
4. ROADMAP.md and relevant ADRs if present

If /docs/access-control-mapping.md does not exist, create it first and fill the initial project-specific assumptions. Do not overbuild. Select the minimum access-control maturity level required now, but design so the project can grow into scoped RBAC, policy conditions, auditability, service accounts, and capability-driven UI later.

Implementation requirements:
- Use deny-by-default authorization.
- Implement or prepare a centralized Authorization Service with a clear decision object.
- Define actors, resources, actions, permissions, roles, scopes, and capabilities.
- Use stable permission names in resource.action format.
- Add route/API classification for all introduced routes.
- Add backend authorization checks; UI gating is not sufficient.
- Add capability-driven UI visibility only after backend enforcement exists or is being implemented in the same pass.
- Add audit logging for privileged actions introduced in this pass.
- Add positive and negative tests.
- Update /docs/access-control-permission-inventory.md, /docs/access-control-route-inventory.md, and /docs/access-control-test-matrix.md.

Do not introduce a new framework or package unless necessary and documented.
Do not scatter role checks through controllers/views/templates.
Do not use is_admin as the long-term authorization model.
Do not mark the pass complete unless tests or explicit validation are reported.

End your response with:
Summary:
Validation:
Access Control:
- Maturity Level:
- Reused:
- Added:
- Routes Classified:
- Permissions Added:
- Tests Added:
- Deferred Risks:
Next Step:
```
