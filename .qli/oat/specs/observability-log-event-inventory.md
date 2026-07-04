# Observability Log Event Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Structured logs explain system behavior. They are not a substitute for audit events.

| Log Event | Severity | Source | When Emitted | Required Context | Sampled? | Sensitive Data Review | Retention | Status |
|---|---|---|---|---|---|---|---|---|
| runtime.job.retrying | warning | Runtime | Job retry scheduled | job_id, attempt, correlation_id | no | safe metadata only | [policy] | planned |
| api.contract.validation_failed | info | API | Request schema validation fails | request_id, endpoint, error_code | yes/no | no raw body | [policy] | planned |
