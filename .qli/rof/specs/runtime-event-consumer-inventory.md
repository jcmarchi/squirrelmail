# Runtime Event Consumer Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/runtime-event-consumer-inventory.md`

| Consumer Key | Event / Webhook | Source | Contract | Domain Module | Idempotency | Retry Policy | Dead-Letter / Manual Review | Security Validation | Status |
|---|---|---|---|---|---|---|---|---|---|
| example.user_created_projection | user.created | internal event | AsyncAPI v1 | identity | event_id | 5x backoff | dead_letter | internal signed event | planned |

## Rules

- Every durable event consumer and external webhook processor must appear here.
- External webhooks must validate signatures/secrets when provider supports them.
- Consumers must be idempotent unless explicitly documented as impossible and protected another way.
