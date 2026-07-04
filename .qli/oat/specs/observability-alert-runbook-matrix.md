# Observability Alert and Runbook Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


| Alert | Signal / Condition | Severity | Owner | User Impact | Runbook / Recovery | Escalation | Suppression/Sampling | Status |
|---|---|---|---|---|---|---|---|---|
| Dead-letter queue spike | dead_letters_total > threshold | critical | | Background work stalled | [runbook] | | | planned |
| API error ratio high | 5xx rate above threshold | critical | | API degraded | [runbook] | | | planned |
| Privileged denial spike | audit_privileged_denials_total spike | warning | | Possible attack/misconfig | [runbook] | | | planned |
