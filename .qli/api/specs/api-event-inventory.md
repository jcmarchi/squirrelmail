# API Event Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/api-event-inventory.md`  
**Purpose:** Track event-driven contracts, message ownership, channels, consumers, schemas, retries, and operational risk.

| Event / Message | Type | Version | Channel / Topic / Queue | Producer | Consumers | Schema | Tenant/Scope Context | Idempotency Key | Retry/DLQ | Status | Tests | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `example.created.v1` | domain event | 1 | `example.events` | | | | yes/no | `event_id` | planned | planned | | |

## Type Values

- domain event
- integration event
- command
- query/reply
- webhook inbound
- webhook outbound
- system event

## Status Values

- planned
- active
- deprecated
- replaced
- internal_only
- dev_only

## Required Update Rule

Update this inventory whenever an event name, payload schema, producer, consumer, retry behavior, dead-letter behavior, or version changes.
