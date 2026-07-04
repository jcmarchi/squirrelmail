# API Endpoint Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/api-endpoint-inventory.md`  
**Purpose:** Track HTTP routes/endpoints, classification, contracts, access requirements, versioning, and test coverage.

| Method | Path | Operation ID | Contract | Classification | Required Permission | Scope | Idempotency | Rate Limit | Status | Tests | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|
| GET | `/api/v1/health` | getHealth | OpenAPI | Public/Internal | n/a | n/a | n/a | yes/no | planned | | Decide public safety. |

## Classification Values

- Public
- Authenticated
- Permissioned
- Privileged
- Internal
- Dev Only

## Status Values

- planned
- active
- deprecated
- removed
- internal_only
- dev_only

## Required Update Rule

Update this inventory whenever a route, method, operation ID, response shape, authorization rule, rate limit, or idempotency behavior changes.
