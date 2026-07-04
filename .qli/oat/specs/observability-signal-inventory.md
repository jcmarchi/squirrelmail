# Observability Signal Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Use this inventory to track meaningful observability signals across logs, audit events, metrics, traces, health checks, diagnostics, and business telemetry.

| Signal Name | Type | Source Layer | Operation / Use Case | Severity | Context Required | Sensitive Data Risk | Storage/Backend | Retention | Status | Owner | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|
| api.example.request.completed | metric/log | API | Example request | info | request_id, correlation_id | low | [adapter] | [policy] | planned | | |
| audit.role.assigned | audit | ACL | Assign role | notice | actor, tenant/scope, resource, request_id | medium | audit_events | [policy] | planned | | |
