# API Contract Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/api-contract-inventory.md`  
**Purpose:** Track formal API contracts, schemas, examples, ownership, status, and compatibility risk.

| Contract ID | Type | Path | Version | Owner | Status | Consumers | Last Change | Compatibility Risk | Notes |
|---|---|---|---|---|---|---|---|---|---|
| core-http-api | OpenAPI | `/docs/api/openapi.yaml` | v1 | | planned | | | low | |
| core-event-api | AsyncAPI | `/docs/api/asyncapi.yaml` | v1 | | planned / n/a | | | low | |

## Status Values

- planned
- draft
- active
- deprecated
- replaced
- internal_only
- dev_only

## Required Update Rule

Update this inventory whenever a contract file, schema location, API version, event version, or consumer-facing behavior changes.
