# API Adapter — [Project Name]

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/api-adapter.md`  
**Purpose:** Map the Universal Composable API Foundation to this repository's actual stack, paths, contracts, adapters, and operational rules.

---

## 1. Project API Profile

| Field | Decision |
|---|---|
| Product | [Project Name] |
| API maturity target | [0-5] |
| Core backend stack | [PHP / Go / Python / Java / etc.] |
| Explicitly disallowed core stack | Node.js and Laravel unless project-approved exception exists |
| Application style | [monolith / modular monolith / services / hybrid / internal tool] |
| Runtime environment | [shared hosting / VPS / Docker / Kubernetes / bare metal / cloud / on-prem] |
| Primary consumers | [web UI / mobile / partners / internal services / CLI / automation] |
| External API exposure | [none / private / partner / public] |

---

## 2. Contract Locations

| Contract | Path | Status | Owner |
|---|---|---|---|
| OpenAPI | `/docs/api/openapi.yaml` | planned | |
| AsyncAPI | `/docs/api/asyncapi.yaml` | planned / n/a | |
| Shared schemas | `/docs/api/schemas/` | planned | |
| API examples | `/docs/api/examples/` | planned | |
| Contract changelog | `/docs/api/changelog.md` | planned | |

---

## 3. Routing and Boundary Model

| Surface | Pattern | Notes |
|---|---|---|
| Public HTTP API | `[route prefix]` | |
| Internal API | `[route prefix]` | |
| Admin API | `[route prefix]` | |
| Webhooks inbound | `[route prefix]` | |
| Webhooks outbound | `[mechanism]` | |
| CLI commands | `[path / command convention]` | |
| Jobs/consumers | `[path / queue convention]` | |

---

## 4. Port and Adapter Convention

| Concern | Port/interface path | Adapter path | Notes |
|---|---|---|---|
| Repositories | | | |
| Event publishing | | | |
| Queue/job dispatch | | | |
| Identity/auth | | | |
| Policy/authorization | | | |
| Storage/files | | | |
| Email/notifications | | | |
| External integrations | | | |

---

## 5. Event and Broker Strategy

| Field | Decision |
|---|---|
| Broker model | none / in-process / database queue / RabbitMQ / Kafka / NATS / other |
| Event contract format | AsyncAPI / JSON Schema / other |
| Event naming | `[module.resource.event.v1]` |
| Message envelope | standard foundation envelope / custom |
| Retry policy | |
| Dead-letter policy | |
| Idempotency policy | |
| Outbox/inbox policy | |

---

## 6. Security and Gateway Model

| Concern | Decision |
|---|---|
| Authentication | session / API key / OAuth2 / OIDC / mTLS / mixed |
| Authorization | access-control foundation / policy service / OPA / gateway policy / mixed |
| Gateway/front boundary | none / reverse proxy / API gateway / ingress / service mesh / custom |
| Rate limiting | |
| Request size limits | |
| Schema validation point | gateway / middleware / controller / DTO factory / mixed |
| Secret handling | |
| Webhook verification | |

---

## 7. Versioning and Compatibility

| Concern | Decision |
|---|---|
| HTTP version strategy | URI / header / media type / none yet |
| Event version strategy | event name / envelope field / schema version |
| Deprecation policy | |
| Breaking change approval | |
| Consumer notification | |

---

## 8. Observability

| Concern | Decision |
|---|---|
| Request ID | |
| Correlation ID | |
| Trace ID | |
| Structured logs | |
| Metrics | |
| Audit integration | |
| Dead-letter monitoring | |
| Webhook delivery logs | |

---

## 9. Testing Gates

| Gate | Tool/Path | Required? |
|---|---|---|
| Contract lint | | |
| Contract conformance tests | | |
| Endpoint integration tests | | |
| Event publish/consume tests | | |
| Authorization tests | | |
| Idempotency tests | | |
| Webhook verification tests | | |
| Compatibility tests | | |
