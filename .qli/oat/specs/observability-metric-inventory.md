# Observability Metric Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Metrics must be unit-aware and low-cardinality. Do not use user IDs, emails, tenant names, arbitrary URLs, or resource IDs as labels.

| Metric Name | Type | Unit | Labels | Source | Description | Alert? | Dashboard | Status |
|---|---|---|---|---|---|---|---|---|
| api_requests_total | counter | count | method, route_class, status_class | API | Total API requests | yes/no | API health | planned |
| runtime_job_duration_ms | histogram | milliseconds | job_type, result | Runtime | Job execution duration | yes/no | Runtime health | planned |
| audit_privileged_denials_total | counter | count | permission, scope_type | ACL | Denied privileged operations | yes | Security | planned |
