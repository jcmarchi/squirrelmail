# AI Coding Agent Prompt — Observability Foundation for a New Project

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


You are implementing observability, audit, and telemetry for a new project. Follow `.qli/observability-foundation-reference.md` and the application construction doctrine.

## Required Behavior

1. Inspect the project stack, runtime profile, and planned surfaces.
2. Create or update `.qli/observability-adapter.md`.
3. Establish request ID and correlation ID strategy.
4. Add structured logging or the project-approved minimal equivalent.
5. Add audit-event support if the project has users, admin actions, permissions, files, billing, integrations, exports, or public exposure.
6. Add health/status behavior appropriate to the deployment profile.
7. Define safe error reporting and diagnostic references.
8. Instrument initial vertical slices across Core, Data, API, UI, ACL, and Runtime where applicable.
9. Update observability inventories.
10. Add tests/smoke checks for signal emission and sensitive-data exclusion.

## Constraints

- Do not add vendor-specific lock-in unless the adapter explicitly approves it.
- Do not log secrets, tokens, raw cookies, authorization headers, or full request bodies.
- Do not use logs as a substitute for audit events.
- Do not create one-off debug output in production paths.
- Keep observability decoupled from business logic.

## Required Final Report

```text
Observability Foundation:
- Adapter: [created/updated]
- Logs: [strategy]
- Audit Events: [added/deferred/n/a]
- Metrics: [added/deferred/n/a]
- Traces/Correlation: [strategy]
- Health/Diagnostics: [added/deferred]
- Privacy Controls: [redaction/omission rules]
- Tests Added: [list]
- Deferred Risks: [list]
```
