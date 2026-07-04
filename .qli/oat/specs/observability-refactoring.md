# AI Coding Agent Prompt — Observability Refactoring for an Existing Project

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


You are refactoring or formalizing observability in an existing project. Do not break working behavior or existing compliance/support reports.

## Required Behavior

1. Read `.qli/observability-foundation-reference.md` and `.qli/observability-adapter.md` if present.
2. Inventory existing logs, audit records, metrics, traces, health endpoints, dashboards, alerts, debug routes, and error handling.
3. Identify privacy/security leaks before adding new instrumentation.
4. Identify missing request/correlation context.
5. Classify existing signals using the foundation taxonomy.
6. Preserve existing audit/reporting compatibility unless migration is explicitly approved.
7. Wrap or adapt existing logging/audit systems before replacing them.
8. Migrate ad hoc logs into structured signal names gradually.
9. Add tests and smoke checks around high-risk signals.
10. Update inventories and note deprecated signal names.

## Refactoring Constraints

- Do not delete existing audit records or audit functionality.
- Do not reduce visibility during migration.
- Do not replace a working logging/audit backend without documenting migration and rollback.
- Do not expose debug/diagnostic routes in production.
- Do not add high-cardinality metrics.
- Do not log raw sensitive data for convenience.

## Required Final Report

```text
Observability Refactor:
- Current State Reviewed: [yes/no]
- Existing Signals Preserved: [list]
- Sensitive Data Risks Found: [list]
- Correlation Improvements: [list]
- Signals Added/Changed: [list]
- Signals Deprecated: [list]
- Tests Added: [list]
- Deferred Risks: [list]
```
