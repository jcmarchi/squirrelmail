# API Test Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/api-test-matrix.md`  
**Purpose:** Ensure every API and event change has positive, negative, compatibility, security, and operational tests.

| Area | Scenario | Required? | Test Path | Status | Notes |
|---|---|---:|---|---|---|
| Contract | OpenAPI/AsyncAPI validates | yes | | planned | |
| Request validation | Invalid field rejected before core logic | yes | | planned | |
| Response validation | Response matches contract | yes | | planned | |
| Authorization | Missing permission denied | yes | | planned | Also follow access-control foundation. |
| Scope isolation | Cross-tenant/project access denied | if scoped | | planned | |
| Idempotency | Duplicate create/command does not duplicate side effects | if applicable | | planned | |
| Event publish | Use case emits expected event | if events | | planned | |
| Event consume | Consumer handles valid event | if events | | planned | |
| Event failure | Invalid event retries/dead-letters safely | if events | | planned | |
| Webhook inbound | Signature verification works | if webhooks | | planned | |
| Webhook replay | Duplicate webhook is ignored or safely replayed | if webhooks | | planned | |
| Observability | request_id/correlation_id logged | yes | | planned | |
| Compatibility | Existing consumer behavior preserved | if refactor | | planned | |

## Status Values

- planned
- implemented
- passing
- failing
- deferred_with_reason
- not_applicable
