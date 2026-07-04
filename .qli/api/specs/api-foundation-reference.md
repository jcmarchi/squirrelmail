# Universal Composable API Foundation Reference

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Version:** 1.0-Universal  
**Intended location:** `.qli/api-foundation-reference.md`  
**Audience:** AI Coding Agents, human architects, implementation reviewers  
**Purpose:** Define a reusable, technology-agnostic API foundation for contract-first, event-driven, secure, composable application development.

---

## 0. Mandatory Instruction to the AI Coding Agent

Before creating, modifying, or refactoring any API, integration, queue, message, job, webhook, contract, schema, service boundary, gateway rule, authentication flow, policy, background workflow, or API-facing test, read this file and treat it as the API source of truth for the repository.

The API foundation is a contract and architecture standard, not a mandated framework. The AI Coding Agent must map this model to the current repository stack instead of imposing a foreign scaffold.

Required sequence before API work:

1. Inspect the repository stack, routing, controllers, handlers, services, DTOs, schemas, API specs, event specs, jobs, queues, middleware, tests, and existing integration patterns.
2. Read `.qli/api-adapter.md` if present.
3. Read `.qli/api-contract-inventory.md` if present.
4. Read `.qli/api-endpoint-inventory.md` if present.
5. Read `.qli/api-event-inventory.md` if present.
6. Read `.qli/api-test-matrix.md` if present.
7. Identify whether the task is greenfield implementation, incremental feature work, or refactoring/migration.
8. Reuse existing contracts, schemas, DTOs, ports, adapters, middleware, policies, event names, message envelopes, and test patterns before creating new ones.
9. Do not create uncontracted API behavior. Update OpenAPI, AsyncAPI, or the project-approved contract format in the same implementation pass.
10. Do not bypass validation, authorization, idempotency, observability, error-shape, versioning, or event-governance rules.
11. Do not mark API work complete until the acceptance checklist in this reference passes.

Emergency/minor fixes may be narrow, but they must not introduce a second API style. Record any missing foundation setup in `.dev/todo-local.md`.

---

## 1. What This Foundation Is

The Universal Composable API Foundation is a reusable architecture model for applications that expose HTTP APIs, internal APIs, external integrations, event-driven workflows, background jobs, webhooks, service-to-service interactions, or automation surfaces.

It is designed for any implementation stack: PHP, Go, Python, Java, C#, Rust, Ruby, C/C++, Elixir, static services, server-rendered applications, monoliths, modular monoliths, microservices, service meshes, internal tools, desktop-connected systems, API gateways, and hybrid deployments.

This foundation intentionally avoids binding the business core to any single framework, broker, database, cloud provider, gateway, deployment model, or programming language. The system may run on shared hosting, VPS, bare metal, container infrastructure, Kubernetes, cloud platforms, on-premises infrastructure, or air-gapped environments if the project constraints require it.

Core doctrine:

- Contract-first: define the external and internal interface before or alongside implementation.
- Hexagonal: keep business logic behind ports and adapters.
- Event-capable: use events, queues, and workflows where asynchronous behavior is beneficial.
- Zero-trust: validate, authenticate, authorize, rate-limit, observe, and audit every meaningful boundary.
- Infrastructure-agnostic: brokers, gateways, storage, identity providers, and transports are adapters, not core logic.
- Evolvable: version, deprecate, test, observe, and document every contract change.

This foundation does not require every product to be a SaaS product, a microservice system, or a fully event-driven platform. Small applications may implement a minimal profile. Larger systems should adopt the full model progressively.

---

## 2. Non-Negotiable Technology Constraint

For the user's standard project posture:

- **Node.js is not allowed as the core application runtime or primary backend framework unless explicitly approved for a specific project.**
- **Laravel is not allowed as the core application framework unless explicitly approved for a specific project.**
- Node-based tooling, generators, documentation tools, frontend build tools, test tooling, or API linters may be used when they do not make Node.js the backend application core.
- Standalone Laravel/Illuminate components may be considered only as isolated packages when they do not impose Laravel as the application framework and the dependency impact is documented.
- Existing projects that already depend on Node.js or Laravel must be assessed before refactor; do not rip them out blindly without a migration plan.

The API foundation is compatible with modules, tools, schemas, or client packages from those ecosystems, but not with turning them into the default backend architecture.

---

## 3. Foundation Layers

A complete API foundation has seven layers. The AI Coding Agent must identify where each change belongs before writing code.

| Layer | Purpose | Examples |
|---|---|---|
| Contract Layer | Source of truth for HTTP and event interfaces. | OpenAPI, AsyncAPI, JSON Schema, protobuf, project schema registry. |
| Boundary Layer | Entry/exit points into the system. | Routes, controllers, handlers, consumers, webhooks, CLI commands, jobs. |
| Application Layer | Use cases and orchestration. | Create order, approve document, sync integration, publish content. |
| Domain/Core Layer | Business rules independent of transport and infrastructure. | Pricing rules, lifecycle transitions, eligibility rules, validation invariants. |
| Port Layer | Interfaces the core depends on. | Repository ports, message publisher port, payment port, identity port, file storage port. |
| Adapter Layer | Technology-specific implementation of ports. | SQL repository, RabbitMQ publisher, Kafka consumer, S3 storage, SMTP sender, OAuth provider. |
| Governance Layer | Cross-cutting enforcement. | Auth, authorization, schema validation, idempotency, observability, audit, rate limits, versioning. |

Rules:

1. Business rules must not depend directly on HTTP controllers, request objects, broker clients, database clients, or framework globals.
2. Contracts must not be reverse-engineered after implementation except during legacy refactors.
3. Ports define what the core needs. Adapters define how infrastructure satisfies it.
4. Events must represent facts or commands with clear ownership and versioning.
5. Gateway and policy rules must enforce external exposure without becoming the only security layer.

---

## 4. Project API Adapter Contract

Every repository adopting this foundation should include `.qli/api-adapter.md`. The adapter maps the universal API model to the current project.

Required fields:

| Field | Decision required |
|---|---|
| Core backend stack | Language/framework/runtime used for business and API code. |
| Rendering/application style | Monolith, modular monolith, service set, server-rendered app, SPA backend, internal tool, CLI/API hybrid. |
| Contract location | Where OpenAPI, AsyncAPI, JSON Schema, webhook specs, and generated docs live. |
| HTTP routing model | Front controller, router, framework routes, generated routes, API gateway routes. |
| Event/broker model | None, in-process events, database queue, RabbitMQ, Kafka, NATS, Redis-compatible queue, cloud queue, custom adapter. |
| Port/adapter convention | Namespace/folder layout for domain ports and infrastructure adapters. |
| DTO/schema convention | Request/response DTOs, validation schemas, serialization rules. |
| AuthN/AuthZ model | Session, token, API key, OAuth2, OIDC, mTLS, service account, policy engine. |
| Gateway model | None, reverse proxy, API gateway, ingress, Kong, Tyk, Traefik, Envoy, custom front controller. |
| Policy model | In-app policy, OPA/Rego, gateway policy, access-control service, hybrid. |
| Versioning model | URI version, header version, media type version, event version, semantic contract version. |
| Observability | Correlation IDs, logs, metrics, traces, audit events, dead-letter reporting. |
| Testing | Contract tests, schema validation tests, integration tests, consumer-driven tests, event replay tests. |

If this file does not exist and API work is more than a narrow fix, create it before broad implementation.

---

## 5. Contract-First Design

Contract-first means the API contract is the source of truth for consumers and implementers. The contract describes what the system promises before implementation details leak into the API surface.

### 5.1 REST/HTTP Contracts

Use OpenAPI for REST/HTTP APIs unless the project explicitly adopts a different formal contract format. The contract should define:

- paths and methods;
- request parameters;
- request bodies;
- response bodies;
- response status codes;
- error shape;
- authentication requirements;
- authorization requirements when expressible;
- pagination, filtering, sorting, and search conventions;
- headers, correlation IDs, idempotency keys, and rate-limit headers;
- examples for common success and failure cases.

### 5.2 Event Contracts

Use AsyncAPI for message-driven, event-driven, pub/sub, streaming, webhook, and broker-based flows when the event surface is non-trivial. The contract should define:

- channels/topics/queues/subjects;
- message names;
- event direction: publish, subscribe, request, reply;
- payload schemas;
- envelope metadata;
- correlation IDs;
- ordering assumptions;
- retry/dead-letter policy;
- versioning policy;
- producer and consumer ownership;
- examples for valid and invalid messages.

### 5.3 Schema Contracts

Contracts must reference stable schemas. JSON Schema is suitable for JSON APIs and events. Other formats may be used when appropriate, such as protobuf, Avro, XML Schema, GraphQL SDL, or project-specific typed DTOs.

Rules:

1. External inputs must be validated at the boundary before reaching internal business logic.
2. Validation errors must use a consistent error shape.
3. Internal domain invariants must still be enforced inside the core. Boundary validation is not enough.
4. Generated code may be used, but generated code must not become the domain model.
5. Contract changes must include tests.

---

## 6. Contract Change Policy

API compatibility is a product promise. The agent must classify every contract change.

| Change type | Examples | Required action |
|---|---|---|
| Non-breaking | Add optional response field, add optional query filter, add new endpoint, add new event type. | Update contract, docs, tests, inventory. |
| Potentially breaking | Tighten validation, change enum values, alter default sorting, add required permission. | Review consumers, update version or migration note. |
| Breaking | Remove field, rename field, change type, remove endpoint/event, change required request field. | New version or explicit migration plan. |
| Security correction | Stop returning sensitive field, enforce missing authorization, reject invalid input. | May be immediate; document as security behavior change. |

Do not silently break contracts. Deprecate first where practical.

---

## 7. HTTP API Standard

### 7.1 Resource Naming

Prefer stable resource nouns and predictable hierarchy.

Examples:

```text
GET    /api/v1/projects
POST   /api/v1/projects
GET    /api/v1/projects/{project_id}
PATCH  /api/v1/projects/{project_id}
DELETE /api/v1/projects/{project_id}
POST   /api/v1/projects/{project_id}/archive
```

Rules:

- Use plural nouns for collections.
- Use path parameters for identity and query parameters for filtering/searching.
- Avoid action-heavy paths except for domain actions that are not CRUD.
- Use `PATCH` for partial update when supported.
- Use `POST` for commands/actions that cause non-idempotent behavior.
- Keep internal database IDs from leaking if public IDs, UUIDs, slugs, or opaque IDs are required by product/security posture.

### 7.2 Standard Status Codes

| Status | Use |
|---|---|
| 200 | Successful read/update with body. |
| 201 | Successful creation. |
| 202 | Accepted for asynchronous processing. |
| 204 | Successful operation with no body. |
| 400 | Malformed request or general validation failure. |
| 401 | Authentication required or invalid. |
| 403 | Authenticated but not allowed. |
| 404 | Resource not found or intentionally hidden. |
| 409 | Conflict with current resource state. |
| 422 | Semantically valid request with validation errors, if project chooses this convention. |
| 429 | Rate limit exceeded. |
| 500 | Unexpected server error. |
| 503 | Service unavailable/dependency unavailable. |

### 7.3 Canonical Error Shape

Use a stable error shape across all APIs.

```json
{
  "error": {
    "code": "validation_failed",
    "message": "The request contains invalid fields.",
    "details": [
      {
        "field": "email",
        "reason": "invalid_format",
        "message": "Email must be a valid email address."
      }
    ],
    "request_id": "req_...",
    "correlation_id": "corr_..."
  }
}
```

Rules:

1. Do not leak stack traces, SQL errors, secrets, internal file paths, broker topology, or policy internals.
2. Include request/correlation identifiers where available.
3. Field-level validation errors must be machine-readable.
4. Security-sensitive details may be omitted from production responses but logged internally.

### 7.4 Pagination, Filtering, Sorting, Search

Every collection endpoint must document pagination behavior.

Preferred approaches:

- Cursor pagination for large, frequently changing datasets.
- Offset/page pagination for small or administrative datasets.
- Explicit `limit` with maximum bounds.
- Stable sort field and direction.
- Document filter operators instead of accepting arbitrary SQL-like filter strings.

Example:

```text
GET /api/v1/projects?limit=50&cursor=abc&sort=-created_at&status=active
```

### 7.5 Idempotency

Any endpoint that creates resources, initiates payment, triggers expensive work, starts a workflow, or publishes commands/events should support idempotency.

Recommended header:

```text
Idempotency-Key: <client-generated-unique-key>
```

The system must store enough information to safely return the same result for repeated requests within the configured idempotency window.

---

## 8. Event-Driven Architecture Standard

The system should use events when work can happen asynchronously, fan out to multiple consumers, integrate with external systems, decouple long-running workflows, or provide reliable audit/replay capability.

Do not use an event broker merely because it is fashionable. Use it when it improves latency, resilience, decoupling, scalability, or operational clarity.

### 8.1 Event Types

| Type | Meaning | Example |
|---|---|---|
| Domain event | A business fact that already happened. | `project.created`, `invoice.paid` |
| Integration event | A stable public or cross-boundary event for other systems. | `customer.profile_updated.v1` |
| Command message | A request for a handler to do work. | `email.send_requested` |
| Query/reply message | Asynchronous request/response flow. | `report.generate_requested` / `report.generated` |
| System event | Operational or infrastructure-relevant fact. | `job.failed`, `integration.token_expiring` |

### 8.2 Event Naming

Use stable, lowercase, dot-separated names.

```text
resource.event_name.v1
module.resource.event_name.v1
```

Examples:

```text
projects.created.v1
projects.archived.v1
billing.invoice_paid.v1
identity.user_invited.v1
integrations.webhook_delivery_failed.v1
```

Events describe facts in past tense. Commands describe requested work.

### 8.3 Message Envelope

Every event should use a consistent envelope.

```json
{
  "event_id": "evt_01H...",
  "event_name": "projects.created.v1",
  "event_version": 1,
  "occurred_at": "2026-05-03T21:00:00Z",
  "producer": "project-service",
  "tenant_id": "ten_...",
  "actor_id": "usr_...",
  "correlation_id": "corr_...",
  "causation_id": "cmd_...",
  "idempotency_key": "idem_...",
  "payload": {
    "project_id": "prj_...",
    "name": "Example Project"
  },
  "metadata": {
    "schema": "projects.created.v1",
    "trace_id": "trace_..."
  }
}
```

Rules:

1. `event_id` is globally unique.
2. `event_name` and `event_version` are stable.
3. `correlation_id` links related events and requests.
4. `causation_id` links the event to the command/request that caused it.
5. Tenant/account/workspace context must be included when applicable.
6. Payload schemas are versioned.
7. Sensitive data must not be published unless explicitly approved.

### 8.4 Broker Adapter Strategy

RabbitMQ, Kafka, NATS, Redis-compatible queues, cloud queues, database-backed queues, in-process dispatchers, and file-based queues are adapters. The domain/application core must not depend directly on a specific broker client.

Define ports such as:

```text
EventPublisher.publish(event): PublishResult
EventConsumer.handle(message): HandlerResult
JobQueue.enqueue(job): QueueResult
WebhookDispatcher.dispatch(event): DeliveryResult
```

Then implement adapters for the chosen infrastructure.

### 8.5 Reliability Patterns

Use these patterns when appropriate:

| Pattern | Purpose |
|---|---|
| Transactional outbox | Ensure database state and event publication do not drift. |
| Inbox/idempotent consumer | Prevent duplicate message side effects. |
| Dead-letter queue | Capture repeatedly failing messages for review/retry. |
| Retry with backoff | Avoid immediate retry storms. |
| Poison-message handling | Quarantine invalid or unprocessable messages. |
| Saga/process manager | Coordinate multi-step workflows without distributed transactions. |
| Event replay | Rebuild projections or re-run integrations from stored events. |
| Projection/read model | Maintain optimized views for query-heavy features. |

Do not claim exactly-once delivery unless the full infrastructure and handler semantics prove it. Design consumers to be idempotent.

---

## 9. Hexagonal Architecture Rules

The API foundation uses ports and adapters to isolate the core.

### 9.1 Dependency Direction

Dependencies point inward.

```text
Transport Adapter -> Application Use Case -> Domain/Core -> Port Interface
Infrastructure Adapter implements Port Interface
```

The core may define an interface like `ProjectRepository`, but it must not import a SQL client, HTTP framework request object, broker SDK, or cloud SDK.

### 9.2 Use Case Pattern

A use case should represent application behavior.

```text
CreateProjectUseCase
- validates command against domain/application rules
- checks authorization through policy/access-control port
- calls repository port
- records audit event
- publishes domain event through event publisher port
- returns application result DTO
```

### 9.3 Adapters

Adapters translate external details into internal commands and results.

Examples:

| Adapter | Converts |
|---|---|
| HTTP controller | HTTP request -> command DTO; result DTO -> HTTP response. |
| Queue consumer | Message envelope -> command/use case; result -> ack/retry/dead-letter. |
| CLI command | CLI arguments -> command DTO. |
| Webhook receiver | External webhook -> normalized internal event/command. |
| SQL repository | Domain query -> SQL/data mapping. |
| File storage adapter | File port -> local disk/object storage/cloud provider. |

Adapters may be framework-specific. The core must not be.

---

## 10. Zero-Trust API Gateway and Boundary Security

A gateway or front boundary may be a dedicated gateway product, reverse proxy, ingress controller, custom middleware, front controller, or service mesh. The specific tool is an adapter decision.

Boundary responsibilities:

- TLS termination where applicable;
- request size limits;
- rate limiting and quotas;
- IP/network policy;
- authentication token verification or forwarding;
- request normalization;
- schema validation where supported;
- threat protection for common abuse patterns;
- routing to internal services;
- correlation/request ID injection;
- logging/metrics;
- policy checks where appropriate.

Do not rely only on the gateway. Services must still enforce authorization and validation for protected operations.

### 10.1 Identity

Use project-appropriate identity:

- session authentication for server-rendered apps;
- API keys for simple machine clients with limited scope;
- OAuth 2.0 for delegated authorization flows;
- OpenID Connect for identity/authentication on top of OAuth 2.0;
- mTLS for service-to-service or high-trust infrastructure;
- signed webhooks for inbound third-party events.

### 10.2 Policy as Code

OPA/Rego or another policy-as-code engine may be used when policies must be language-neutral, gateway-enforced, centrally governed, or shared across services. For smaller projects, an in-application policy service may be enough.

Policy decisions must be testable and observable. A denied request should have a reason logged internally.

---

## 11. Security Requirements

Minimum API security rules:

1. Deny by default.
2. Validate all external input before use.
3. Authenticate before protected operations.
4. Authorize every protected operation server-side.
5. Enforce tenant/scope containment where relevant.
6. Avoid leaking existence of protected resources.
7. Use safe error responses.
8. Apply rate limits to public, auth, webhook, and expensive endpoints.
9. Protect file uploads and downloads through authorization and content validation.
10. Do not log secrets, tokens, passwords, authorization headers, private keys, or sensitive payloads.
11. Sign or verify webhooks.
12. Use replay protection for high-risk inbound events.
13. Rotate and revoke API tokens.
14. Record privileged, destructive, export, auth, token, integration, and policy changes in audit logs.

This document does not replace the access-control foundation. API work involving authorization must also follow `.qli/access-control-reference.md`.

---

## 12. Capability and Access Integration

APIs must integrate with the access-control foundation.

Every protected API endpoint or event consumer should define:

```text
route_or_consumer
access_classification
required_permission
required_scope
resource_resolution
policy_conditions
risk_level
audit_required
```

Routes without classification fail review.

For event consumers, authorization may evaluate the original actor, service actor, tenant context, event provenance, or integration identity depending on the workflow.

---

## 13. Data Contracts and DTOs

DTOs protect the core from transport-specific request objects.

Rules:

1. External request body -> boundary validation -> request DTO/command.
2. Use case returns result DTO, not raw database rows.
3. Response serializer maps result DTO -> contract response.
4. Events use event DTO/envelope, not raw domain objects.
5. DTOs must not expose secrets or internal-only fields accidentally.
6. Avoid over-posting by accepting only explicitly allowed fields.
7. Avoid mass assignment from raw request payloads into domain entities.

---

## 14. Webhooks and External Integrations

Inbound webhooks are public attack surfaces unless proven otherwise.

Inbound webhook requirements:

- explicit route classification;
- signature verification where provider supports it;
- timestamp tolerance and replay protection;
- schema validation;
- provider identity mapping;
- idempotency using provider event ID;
- safe retry behavior;
- dead-letter or quarantine for invalid messages;
- minimal synchronous work;
- audit/logging without secrets.

Outbound webhook requirements:

- registered endpoint ownership/verification where practical;
- signing secret per destination;
- retry with backoff;
- dead-letter delivery state;
- event delivery log;
- idempotent payload design;
- versioned event payloads;
- tenant/account scope isolation.

---

## 15. Observability and Operations

Every API/event flow must be diagnosable.

Required fields for logs and traces where applicable:

- request_id;
- correlation_id;
- trace_id;
- actor_id or service actor;
- tenant/account/workspace/project context;
- route/operation/event name;
- status/decision;
- duration;
- dependency calls;
- validation failures;
- authorization denials;
- retry/dead-letter outcomes.

Metrics to consider:

- request count by endpoint/status;
- latency percentiles;
- error rates;
- validation failure rates;
- auth denial rates;
- queue depth;
- consumer lag;
- retry count;
- dead-letter count;
- webhook delivery success/failure;
- idempotency replay rate.

---

## 16. Versioning and Deprecation

Versioning applies to HTTP APIs, event payloads, webhooks, schema definitions, SDKs, and generated clients.

Rules:

1. Choose and document the API versioning strategy in `.qli/api-adapter.md`.
2. Do not mix multiple versioning strategies without reason.
3. Events should include explicit version in the event name or envelope.
4. Deprecations require replacement path, timeline, consumer impact, and tests.
5. Deprecated fields may remain in responses while marked as deprecated in the contract.
6. Breaking event changes should create a new event version.

---

## 17. Documentation and Developer Experience

A professional API foundation includes usable documentation.

Minimum docs:

- contract files;
- endpoint inventory;
- event inventory;
- schema inventory;
- auth guide;
- error guide;
- pagination/filtering guide;
- webhook guide when applicable;
- local development instructions;
- sample requests/responses;
- test matrix;
- review checklist.

Generated documentation is useful, but not sufficient if the operational conventions are unclear.

---

## 18. Testing Standard

Required test types where applicable:

| Test type | Purpose |
|---|---|
| Contract validation | OpenAPI/AsyncAPI/schema is syntactically valid. |
| Request validation | Invalid inputs are rejected before core logic. |
| Response validation | Implemented responses match contract. |
| Authorization tests | Protected endpoints and consumers enforce permissions. |
| Tenant/scope tests | Cross-scope access is denied. |
| Idempotency tests | Duplicate requests/messages do not duplicate side effects. |
| Event publication tests | Expected events are published with correct envelope/schema. |
| Event consumer tests | Valid events process; invalid events fail safely. |
| Retry/dead-letter tests | Failures produce expected retry/quarantine behavior. |
| Gateway/policy tests | Boundary policy is enforced. |
| Backward compatibility tests | Existing contract consumers are not broken. |
| Observability tests | request_id/correlation_id/audit logs are emitted. |

A feature that changes API behavior is incomplete without tests covering both success and failure cases.

---

## 19. Maturity Levels

Use these levels to scale implementation.

| Level | Description | Suitable for |
|---|---|---|
| 0 | No formal API foundation; ad hoc routes. | Disposable prototype only. |
| 1 | Basic documented endpoints and request validation. | Small internal tools. |
| 2 | OpenAPI contract, stable error shape, auth/authorization guards, endpoint inventory. | Serious monolith or MVP. |
| 3 | Ports/adapters, AsyncAPI/event inventory, idempotency, audit and observability. | SaaS, modular product, integration-heavy system. |
| 4 | Gateway, policy-as-code, contract tests, broker abstraction, outbox/inbox, DLQ. | Enterprise or high-scale product. |
| 5 | Multi-service governance, schema registry, consumer-driven contracts, replay, automated compatibility gates. | Platform ecosystem or mission-critical infrastructure. |

Do not overbuild. But do not build in ways that block reaching the next level.

---

## 20. New Project Implementation Path

For a new project, implement in this order:

1. Create `.qli/api-adapter.md`.
2. Define contract locations and naming conventions.
3. Create initial OpenAPI contract for current API surface.
4. Create AsyncAPI contract only if events are part of the current or near-term architecture.
5. Define canonical error shape, request ID/correlation ID, and validation standard.
6. Define port/adapter folder structure.
7. Implement minimal route/handler -> use case -> port -> adapter flow.
8. Add authorization hook points even if the first product role model is simple.
9. Add endpoint inventory and test matrix.
10. Add event inventory if events exist.
11. Add tests for validation, auth, success response, error response, and contract conformance.

---

## 21. Existing Project Review/Refactor Path

For an existing project, do not rewrite blindly.

1. Inventory existing endpoints, routes, controllers, handlers, APIs, jobs, webhooks, queues, events, DTOs, schemas, middleware, tests, and docs.
2. Classify each surface as contract-backed, partially documented, undocumented, deprecated, internal, public, or dev-only.
3. Identify duplicate API styles and inconsistent error shapes.
4. Identify business logic trapped in controllers/handlers/adapters.
5. Identify validation bypasses and raw request usage.
6. Identify missing authorization, tenant/scope checks, rate limits, and audit logging.
7. Create a compatibility-preserving migration plan.
8. Add contracts for existing behavior before changing behavior, unless fixing a security defect.
9. Refactor one vertical slice at a time.
10. Preserve old routes or add adapters/compatibility aliases when consumers still depend on them.
11. Add tests before and after behavior changes.

---

## 22. Required Repository Files

Recommended `.qli` files:

```text
docs/specs/
├── api-foundation-reference.md
├── api-adapter.md
├── api-contract-inventory.md
├── api-endpoint-inventory.md
├── api-event-inventory.md
├── api-test-matrix.md
└── api-review-checklist.md
```

Optional contract/spec folders:

```text
docs/api/
├── openapi.yaml
├── asyncapi.yaml
├── schemas/
├── examples/
└── changelog.md
```

Project-specific paths may differ, but they must be documented in `api-adapter.md`.

---

## 23. Agent Completion Checklist

The AI Coding Agent must report:

- contracts read;
- contracts changed;
- endpoints added/changed/deprecated;
- events added/changed/deprecated;
- schemas added/changed/deprecated;
- validation added;
- authorization/access-control added;
- ports/adapters reused or created;
- broker/gateway/policy changes;
- tests added;
- inventories updated;
- compatibility risks;
- deferred risks.

Do not claim completion when a contract, inventory, test matrix, or review checklist is stale.

---

## 24. Anti-Patterns

Avoid:

- code-first APIs with no contract;
- one-off response/error shapes;
- raw request payloads passed into domain entities;
- business logic inside controllers;
- business logic inside broker consumers;
- direct broker/database/cloud SDK usage inside core logic;
- events with no schema or version;
- consumers that are not idempotent;
- no dead-letter or failure handling;
- treating hidden UI controls as API security;
- relying only on gateway policy without service-side checks;
- using tenant IDs from clients without containment verification;
- hardcoding external integration assumptions in domain logic;
- unbounded pagination;
- unvalidated webhooks;
- storing secrets in logs;
- exposing dev/debug endpoints in production;
- adopting Node.js or Laravel as the core backend stack without explicit project approval.

---

## QLi v2 Addendum — Early API Spine

When a project exposes application behavior through HTTP, events, webhooks, integrations, SDKs, or internal service contracts, the API Foundation must be established early.

Minimum API spine evidence:

- API style and versioning decision.
- Health/status endpoint or equivalent runtime check where applicable.
- Request validation pattern.
- Response/error envelope convention.
- Pagination/filtering convention when lists exist.
- Authentication/authorization boundary with ACL handoff when protected behavior exists.
- Idempotency and correlation/request ID policy for operations that need them.
- Contract inventory location and update rule.

## Buildline Implementation Control

This foundation is governed operationally by `.qli/api/specs/api-implementation-control.md`.

Use the full reference for doctrine and vocabulary. Use the implementation-control file for the project-agnostic minimum spine, optional capability rules, deferral rules, evidence expectations, test/smoke expectations, common AI-agent failure modes, and definition of done.

Project-specific applicability is not decided inside this reference file. It is decided through `.qli/binding/` and recorded in `.qli/project/foundation-applicability.yml`.
