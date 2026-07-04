# Observability Dashboard Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


| Dashboard | Audience | Signals Used | Location | Access Classification | Refresh/Retention | Owner | Status | Notes |
|---|---|---|---|---|---|---|---|---|
| Runtime Health | Operators/admins | job failures, queue depth, dead letters | [location] | internal/privileged | [policy] | | planned | |
| API Health | Developers/operators | request rate, latency, errors | [location] | internal/privileged | [policy] | | planned | |
| Security/Audit | Admin/security | privileged denials, impersonation, token changes | [location] | privileged | [policy] | | planned | |
