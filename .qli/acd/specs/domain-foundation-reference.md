# Application Core / Domain Foundation Reference

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Version:** 1.0-Universal  
**Intended location:** `.qli/domain-foundation-reference.md`  
**Audience:** AI Coding Agents, human architects, implementation reviewers  
**Purpose:** Define a reusable, technology-agnostic standard for organizing business logic, domain modules, use cases, workflows, commands, queries, events, validation, and feature slices in new and existing applications.

---

## 0. Mandatory Instruction to the AI Coding Agent

Before creating, modifying, or refactoring business behavior, feature logic, workflows, services, commands, queries, module boundaries, domain events, lifecycle rules, validators, or application services, read this file and treat it as the Application Core source of truth.

This foundation exists to prevent business logic from being scattered across controllers, API handlers, UI components, templates, database models, migrations, jobs, queue consumers, or ad hoc helper files.

The correct implementation sequence is:

1. Read `.qli/application-construction-doctrine.md` if present.
2. Read this file.
3. Read `.qli/domain-adapter.md` if present.
4. Read `.qli/domain-module-inventory.md`, `.qli/domain-usecase-inventory.md`, `.qli/domain-workflow-inventory.md`, `.qli/domain-event-inventory.md`, `.qli/domain-rule-inventory.md`, and `.qli/domain-test-matrix.md` if present.
5. Inspect existing feature, service, controller, data, API, UI, job, and test code before changing architecture.
6. Reuse or extend existing domain modules, use cases, workflows, events, and policies before adding new ones.
7. Deliver features as vertical slices across Core + Data + API + Test + UI whenever practical, with ACL/Security included where applicable.

---

## 1. What the Application Core Is

The Application Core is the technology-neutral center of the application. It contains the business behavior that makes the product valuable: use cases, workflows, domain rules, lifecycle transitions, commands, queries, domain events, validations, policies, and orchestration that should survive changes in UI, database, API framework, queue broker, or hosting environment.

The Application Core is not the database model, not the controller layer, not the API schema, not the UI, and not the background worker runtime. Those are adapters or delivery mechanisms around the core.

The core answers questions such as:

- What feature is being executed?
- What business rule must be enforced?
- What state transition is valid?
- What command or query is being handled?
- What domain event should be emitted?
- What data must be requested from repositories or ports?
- What result, error, or next step should be returned?

---

## 2. Relationship to the Other Foundations

| Foundation | Responsibility | Relationship to Application Core |
|---|---|---|
| Construction Doctrine | Defines product-to-architecture-to-code execution and vertical-slice delivery. | Core implements the business behavior inside each slice. |
| UI Foundation | Defines reusable user-facing components and workflows. | UI presents use cases; it does not own business rules. |
| Data Foundation | Defines entities, records of truth, schema evolution, datasets, storage decisions, and persistence adapters. | Core asks data ports/repositories for state; it does not know storage details. |
| API Foundation | Defines OpenAPI/AsyncAPI, contracts, gateways, events, and interface boundaries. | API calls use cases; API does not contain core business logic. |
| Access Control Foundation | Defines who may do what, where, and under which policy. | Core may require authorization decisions but does not replace ACL policy enforcement. |
| Runtime / Operations | Defines jobs, queues, retries, schedulers, workers, locks, and operational execution. | Runtime invokes use cases; jobs do not own business rules. |

---

## 3. Core Architecture Layers

A healthy application core uses explicit layers. The names may vary by stack, but the responsibilities must remain clear.

| Layer | Purpose | Examples |
|---|---|---|
| Domain Model | Business concepts, invariants, lifecycle states, domain terminology. | `Bid`, `Order`, `Publication`, `Project`, `Inspection`, `Account`. |
| Use Cases / Application Services | Orchestrate a business operation from input to result. | `CreateBid`, `PublishArticle`, `AssignUserToProject`, `ApproveInspection`. |
| Commands | Intent to change system state. | `CreateProjectCommand`, `SubmitInvoiceCommand`. |
| Queries | Intent to read or calculate system state without mutation. | `GetProjectDashboardQuery`, `ListUserAssignmentsQuery`. |
| Domain Events | Facts that happened in the domain. | `BidSubmitted`, `UserInvited`, `ContentPublished`. |
| Ports | Interfaces the core depends on. | Repository port, event publisher port, clock port, ID generator port, notification port. |
| Adapters | Technology-specific implementations of ports. | SQL repository, file storage adapter, mail provider, broker producer, API controller. |
| Policies / Specifications | Business predicates and decision rules. | `CanPublishContent`, `BidCanBeEdited`, `TenantIsActive`. |
| Results / Errors | Standard outcome objects. | `Success`, `ValidationError`, `Forbidden`, `Conflict`, `NotFound`. |

---

## 4. Dependency Direction Rule

Dependencies must point inward toward the Application Core.

The core may depend on:

- language primitives;
- stable domain objects;
- interfaces/ports;
- pure validation and calculation helpers;
- domain result/error types.

The core must not depend directly on:

- HTTP request/response objects;
- framework controllers or routing objects;
- database query builders or ORM-specific APIs unless the project explicitly chooses an active-record compromise and documents it;
- UI components, templates, DOM objects, browser APIs;
- queue broker clients;
- cloud SDKs;
- payment provider SDKs;
- global session state;
- environment variables directly;
- raw superglobals or request globals.

When the core needs external capability, define a port and implement it through an adapter.

---

## 5. Business Logic Placement Rules

| Logic type | Correct location | Must not live primarily in |
|---|---|---|
| Business rule | Domain policy/specification, entity method, or use case | Controller, view, migration, UI handler |
| Workflow orchestration | Use case/application service | API route, worker script, template |
| State transition | Domain model or workflow service | Raw SQL update, UI button handler |
| Validation of business meaning | Domain validator/use case | Only frontend form validation |
| Input format validation | API/UI adapter boundary | Deep inside domain model only |
| Authorization decision | ACL policy/guard with domain context | UI hiding alone |
| Persistence mapping | Repository/data adapter | Domain use case internals |
| External service call | Port + adapter | Domain entity |
| Event emission | Use case after successful state change | Database trigger unless intentionally documented |

---

## 6. Module Model

A domain module is a bounded area of business capability. Modules should map to product features and business concepts, not arbitrary technical folders.

A module may contain:

```text
modules/[module-name]/
├── domain/             # entities, value objects, domain rules, lifecycle states
├── application/        # use cases, commands, queries, application services
├── ports/              # repository, event, notification, clock, ID interfaces
├── adapters/           # framework/database/API/runtime implementations if local to module
├── contracts/          # schemas/events/interfaces owned by the module when applicable
├── tests/              # module-focused tests
└── README.md           # module purpose and boundaries
```

Alternative stacks may place these folders elsewhere, but the responsibilities must remain visible.

---

## 7. Entity, Value Object, DTO, and Record Distinctions

AI agents must not collapse every data shape into a single “model.”

| Type | Meaning | Example |
|---|---|---|
| Domain Entity | Business object with identity and lifecycle. | `Project`, `Tenant`, `Bid`, `Invoice`. |
| Value Object | Immutable concept defined by value, not identity. | `Money`, `EmailAddress`, `DateRange`, `Measurement`. |
| Data Record | Persistence shape used by storage. | SQL row, document, key-value entry. |
| DTO | Transfer shape crossing process/API/UI boundaries. | `CreateProjectRequest`, `ProjectSummaryResponse`. |
| Projection | Read-optimized derived view. | Dashboard card, search document, report row. |
| Event Payload | Fact emitted after state change. | `ProjectCreated.v1`. |

Domain entities may map to data records, but they are not the same thing. DTOs and API schemas may expose domain concepts, but they should not become the domain model by accident.

---

## 8. Use Case Standard

A use case represents one business operation. It should have a stable name, explicit input, explicit output, declared dependencies, validation, authorization context where applicable, and tests.

Recommended use-case structure:

```text
Use Case: PublishContent
Purpose: Publish approved content to a target channel.
Input: PublishContentCommand
Output: PublishContentResult
Dependencies: ContentRepositoryPort, EventPublisherPort, ClockPort, AuthorizationPort
Preconditions: content exists, actor has permission, content is approved, tenant is active
Postconditions: content status is published, publication timestamp set, ContentPublished event emitted
Errors: NotFound, Forbidden, InvalidState, Conflict
Tests: allowed path, missing content, unauthorized actor, invalid state, event emitted
```

Use cases should be boring, explicit, and testable.

---

## 9. Commands and Queries

Use commands for operations that change state. Use queries for operations that retrieve or calculate state without mutation.

Command rules:

- Commands must express user/system intent.
- Commands must be validated at the boundary and again for business meaning in the use case.
- Commands should be idempotent when retries or external requests are possible.
- Commands should return stable result objects, not framework responses.

Query rules:

- Queries must not mutate business state.
- Queries may read projections, repositories, or read models.
- Queries must respect ACL and data scope.
- Queries should define pagination, filtering, sorting, and projection expectations where applicable.

---

## 10. Workflow and Lifecycle Rules

Many products are built around lifecycle states. These must be explicit and testable.

A workflow should define:

- states;
- allowed transitions;
- forbidden transitions;
- actors/capabilities required for transitions;
- side effects;
- emitted events;
- audit needs;
- rollback/cancel behavior;
- concurrency/conflict behavior.

Example:

```text
Draft -> Submitted -> Approved -> Published -> Archived
Draft -> Deleted
Submitted -> Rejected -> Draft
```

Do not encode lifecycle rules only as UI dropdown options or database enum values. The domain layer must enforce transition validity.

---

## 11. Domain Events

A domain event is a fact that already happened inside the business domain. Name events in past tense.

Good event names:

- `UserInvited`
- `ProjectCreated`
- `BidSubmitted`
- `InvoiceApproved`
- `ContentPublished`

Event rules:

1. Events must be emitted after the corresponding state change is accepted.
2. Events must include stable identifiers, schema version, occurred timestamp, actor/context where appropriate, tenant/scope where applicable, and correlation ID when available.
3. Event payloads must be versioned and compatible with the API/Data foundations.
4. Events must not leak sensitive fields unless explicitly allowed.
5. Event handlers must be idempotent.
6. Event emission should be observable and testable.

---

## 12. Validation Model

Validation has layers. AI agents must not put all validation in the same place.

| Layer | Responsibility |
|---|---|
| UI validation | Immediate user feedback, input affordances, formatting hints. |
| API/boundary validation | Required fields, type/format/schema validation, rejected unknown fields, size limits. |
| Domain validation | Business meaning, invariants, lifecycle rules, cross-field rules. |
| Data validation | Persistence constraints, uniqueness, referential integrity, storage-level safety. |
| ACL validation | Actor permission, scope, policy conditions. |

The backend must enforce all security and business-critical validation even if the UI already checks it.

---

## 13. Error and Result Standard

Use cases should return structured outcomes. Do not throw generic exceptions for ordinary business outcomes.

Recommended categories:

| Category | Meaning |
|---|---|
| Success | Operation completed. |
| ValidationError | Input or business validation failed. |
| Forbidden | Actor lacks permission or policy denies action. |
| NotFound | Required resource was not found or not visible. |
| Conflict | State, version, lock, or concurrency conflict. |
| InvalidState | Operation is not valid for current lifecycle state. |
| DependencyFailure | External dependency failed. |
| RateLimited | Operation exceeds policy or resource limits. |

Transport adapters map these outcomes to HTTP responses, CLI output, UI messages, or job failure states.

---

## 14. Transaction and Consistency Boundaries

The use case must define the consistency boundary of the operation.

For each state-changing use case, document:

- what must commit atomically;
- what can happen asynchronously;
- what events are emitted;
- what projections/caches/search indexes must update;
- what happens on partial failure;
- whether retry is safe;
- whether idempotency is required.

Do not bury transaction decisions only inside repository code.

---

## 15. Anti-Corruption and External Integration Rules

External services must not leak their models into the domain core.

Use anti-corruption adapters for:

- payment processors;
- identity providers;
- email/SMS providers;
- AI model providers;
- third-party APIs;
- legacy systems;
- imported datasets;
- external webhooks.

The adapter translates external vocabulary into domain vocabulary and isolates provider-specific errors.

---

## 16. New Project Procedure

For a new project, the AI Coding Agent must:

1. Read the product/feature context and construction doctrine.
2. Identify initial domain modules from the feature map.
3. Define module boundaries before implementing broad code.
4. Create `.qli/domain-adapter.md`.
5. Create or initialize inventories for modules, use cases, workflows, domain events, domain rules, and tests.
6. Define the first vertical slice across Core + Data + API + UI + Test, with ACL/Security if applicable.
7. Build the UI foundation early enough for the first feature to be human-reviewable.
8. Keep domain behavior independent from chosen frameworks and infrastructure.

---

## 17. Existing / Refactoring Procedure

For an existing project, the AI Coding Agent must:

1. Inspect current modules, controllers, services, models, jobs, templates, UI handlers, APIs, data access, and tests.
2. Identify where business logic currently lives.
3. Preserve valid behavior before refactoring.
4. Create a domain mapping rather than imposing a foreign structure.
5. Move logic incrementally into use cases, domain services, policies, value objects, or workflows.
6. Add tests around behavior before extraction when feasible.
7. Keep existing routes/API/UI stable unless a versioned migration is approved.
8. Update inventories and technical-debt notes.

Refactoring must be controlled. Do not rewrite a working application into a theoretical architecture without preserving behavior.

---

## 18. Testing Requirements

Every domain feature should include tests appropriate to its risk.

Required test categories where applicable:

- use case success path;
- validation failure;
- authorization denial;
- invalid lifecycle transition;
- missing resource;
- conflict/concurrency case;
- emitted events;
- repository/port interaction;
- API contract behavior;
- UI smoke path for user-facing features;
- data persistence/migration effect;
- idempotency/retry behavior.

A domain feature without tests is not mature.

---

## 19. Domain Review Checklist

Before accepting domain/application-core work, verify:

- [ ] Business logic is not primarily in controllers, UI, templates, migrations, or raw persistence code.
- [ ] Use cases are explicit and named after business intent.
- [ ] Commands and queries are separated where meaningful.
- [ ] Domain entities and data records are not conflated.
- [ ] Lifecycle states and transitions are enforced in the core.
- [ ] Domain events are past-tense, versioned, and tested where applicable.
- [ ] External dependencies are behind ports/adapters.
- [ ] Errors/results are structured and mapped at adapters.
- [ ] Feature was delivered or planned as a vertical slice.
- [ ] Existing behavior was preserved during refactoring.
- [ ] Inventories and test matrices were updated.

---

## 20. Minimum Acceptable MVP

For a serious application, the minimum acceptable Application Core includes:

1. documented domain modules;
2. at least one explicit use-case/application-service layer;
3. clear separation between domain behavior and controllers/API/UI/database adapters;
4. stable result/error pattern;
5. testable business rules;
6. documented workflow/lifecycle rules where applicable;
7. explicit dependencies through ports/adapters where infrastructure is involved;
8. integration with Data, API, UI, and ACL foundations.

Without this, the project may have features, but it does not have a reliable application core.

---

## 21. Anti-Patterns to Avoid

Do not use these patterns:

- controllers containing business workflows;
- UI handlers deciding business rules;
- ORM/database models acting as the entire domain model by accident;
- raw SQL updates bypassing lifecycle rules;
- queue workers duplicating controller logic;
- external provider objects leaking into domain logic;
- one giant `Service` class for unrelated use cases;
- helper files full of undocumented business rules;
- implicit status transitions with no transition map;
- events named as commands, such as `PublishContent` instead of `ContentPublished`;
- feature branches that add backend logic but no reviewable UI or test path;
- refactors that rename everything without preserving behavior.
