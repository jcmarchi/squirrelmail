# Observability Test Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


| Area | Required Test | Automated? | Manual Smoke? | Current Status | Notes |
|---|---|---:|---:|---|---|
| Request IDs | Every request receives/propagates request_id | yes | yes | planned | |
| Correlation IDs | Queue/event/job flows preserve correlation_id | yes | yes | planned | |
| Sensitive data | Logs do not emit secrets/tokens/private data | yes | yes | planned | |
| Audit | Privileged action emits audit event | yes | yes | planned | |
| Runtime | Failed/retried/dead-lettered jobs emit signals | yes | yes | planned | |
| API | Contract validation failure emits safe signal | yes | yes | planned | |
| UI | User-facing error shows diagnostic reference | yes/no | yes | planned | |
| Health | Health/status endpoints hide sensitive details | yes | yes | planned | |
| Alerts | Production-relevant alerts have runbooks | no | yes | planned | |
