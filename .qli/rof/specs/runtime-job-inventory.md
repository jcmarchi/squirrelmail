# Runtime Job Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/runtime-job-inventory.md`

| Job Key | Domain Module | Trigger | Queue/Adapter | Payload Schema | Idempotency Key | Timeout | Retry Policy | Lock Policy | Terminal Failure | Owner | Status |
|---|---|---|---|---|---|---:|---|---|---|---|---|
| example.send_notification | notifications | domain event | db_queue | v1 | event_id | 60s | 3x exponential | none | dead_letter | core.notifications | planned |

## Rules

- Every durable background job must appear here.
- Payloads must be versioned when persisted or delayed.
- Jobs must call Core use cases/application services, not own business rules.
- Retryable jobs must define idempotency.
