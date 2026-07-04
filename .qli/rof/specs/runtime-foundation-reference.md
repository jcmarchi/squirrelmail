# Runtime / Operations Foundation Reference

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Version:** 1.0-Universal  
**Intended location:** `.qli/runtime-foundation-reference.md`  
**Audience:** AI Coding Companions, human architects, implementation reviewers  
**Purpose:** Define a reusable, stack-agnostic runtime and operations foundation for how application work is executed, queued, scheduled, retried, coordinated, cached, recovered, and observed.

---

## 0. Mandatory Instruction to the AI Coding Companion

Before creating, modifying, or refactoring runtime behavior, read this file and treat it as the runtime source of truth for the repository.

Runtime work includes web-request execution, API-request execution, background jobs, queues, event consumers, schedulers, cron tasks, workers, daemons, webhooks, imports, exports, cache, session behavior, locks, retries, timeouts, temporary files, progress tracking, maintenance tasks, reconciliation tasks, and any non-trivial asynchronous operation.

The AI Coding Companion must not scatter runtime behavior across controllers, route handlers, templates, UI handlers, random cron scripts, queue callbacks, or one-off service files. Runtime executes work; it does not own business rules. Business rules belong in the Application Core / Domain layer.

Required sequence:

1. Read `.qli/application-construction-doctrine.md` if present.
2. Read `.qli/domain-foundation-reference.md` if present.
3. Read `.qli/data-foundation-reference.md` if data is created, changed, cached, queued, imported, exported, or synchronized.
4. Read `.qli/api-foundation-reference.md` if API endpoints, events, webhooks, contracts, queues, or integrations are involved.
5. Read `.qli/access-control-reference.md` if users, permissions, tokens, privileged actions, files, exports, admin routes, or public exposure are involved.
6. Read this runtime reference and all present runtime inventories before implementation.
7. Inspect existing jobs, schedulers, queues, workers, cron tasks, cache/session code, locks, temporary files, and operational scripts before adding new runtime behavior.
8. Update runtime inventories, failure policies, and test matrix whenever runtime behavior changes.

---

## 1. What This Foundation Is

The Runtime / Operations Foundation defines how application work is executed after a trigger occurs. A trigger may be a user action, API call, form submission, event, webhook, scheduled time, CLI command, queue message, system lifecycle event, import, export, or maintenance action.

This foundation is not DevOps. It does not define deployment pipelines, server provisioning, Kubernetes, hosting, release management, DNS, or infrastructure procurement. It defines the application runtime model: how work is handled safely inside the application once the application is running.

The foundation is intentionally infrastructure-agnostic. It must work for small shared-hosting applications with cron and database-backed jobs, open-source distributable applications, VPS/self-hosted applications, on-prem systems, and scalable queue/broker-based platforms.

---

## 2. Relationship to Other Foundations

| Foundation | Runtime relationship |
|---|---|
| Application Construction Doctrine | Runtime work must fit the Core + Data + API + UI vertical-slice model. |
| Domain Foundation | Runtime handlers call use cases/application services. They do not contain business rules. |
| Data Foundation | Runtime defines execution and recovery; Data defines records, state, lifecycle, storage, and migrations. |
| API Foundation | Runtime executes API-side work, events, webhooks, and asynchronous contract behavior. |
| Access Control Foundation | Runtime enforces actor, scope, capability, token, and privileged-action checks where needed. |
| UI Foundation | Runtime exposes progress, status, errors, retries, and completion states to the user where appropriate. |
| Observability Foundation, when present | Runtime emits logs, metrics, traces, job events, failure signals, and diagnostic context. |

---

## 3. Runtime Doctrine

1. Business logic belongs in Core, not in runtime handlers.
2. Runtime code should be thin orchestration around commands, use cases, domain services, and adapters.
3. Every non-trivial runtime operation must have a clear trigger, actor/system context, idempotency model, timeout policy, retry policy, failure policy, and observability policy.
4. Synchronous work should stay small and user-relevant. Slow, fragile, external, high-volume, repeatable, or recoverable work should move to a runtime process.
5. Queues, schedulers, workers, and cache are implementation adapters, not domain architecture.
6. Every queued or scheduled action must be safe to retry unless explicitly documented otherwise.
7. Runtime state must be inspectable by humans and testable by automation.
8. Failure is a first-class design concern, not an afterthought.

---

## 4. Runtime Modes

| Mode | Description | Typical use |
|---|---|---|
| Web request | Work executed during a browser/page request. | Simple form actions, page render, short CRUD. |
| API request | Work executed during an API call. | Contracted commands, queries, webhooks. |
| CLI command | Work triggered manually or by deployment/runtime scripts. | Maintenance, imports, diagnostics. |
| Scheduled job | Work triggered by cron, scheduler, or timer. | Cleanup, reminders, syncs, billing runs. |
| Background job | Queued work processed asynchronously. | Email, exports, heavy computation, retries. |
| Event consumer | Work triggered by a domain/integration event. | Notifications, projections, syncs, workflows. |
| Webhook processor | Work triggered by external systems. | Payment callbacks, CRM sync, external integrations. |
| Worker daemon | Long-running process that consumes work continuously. | Queue workers, event streams. |
| Batch/import/export task | Large-volume data operation with progress and resumability. | CSV import, report generation, media processing. |
| Maintenance/reconciliation task | Corrective or periodic operational work. | Rebuild projections, retry failed syncs, cleanup stale sessions. |

---

## 5. Runtime Architecture Layers

| Layer | Responsibility |
|---|---|
| Trigger adapter | HTTP route, API handler, cron entry, CLI command, queue consumer, webhook receiver. |
| Runtime envelope | Actor/system context, tenant/scope, request/job ID, trace ID, idempotency key, deadline, priority. |
| Runtime orchestrator | Loads context, validates operational constraints, calls the correct Core use case. |
| Core use case | Owns business behavior and returns a result/event/decision. |
| Infrastructure adapter | Queue, mailer, cache, filesystem, broker, external API, storage, lock provider. |
| State recorder | Records job state, progress, retries, failures, outcomes, and audit/diagnostic metadata. |
| Observer | Emits logs, metrics, traces, events, or alerts. |

Dependency rule: outer runtime layers may depend on Core ports/interfaces, but Core must not depend on cron, queue libraries, worker frameworks, HTTP frameworks, or cache libraries.

---

## 6. Synchronous vs Asynchronous Decision Matrix

| Question | Prefer synchronous | Prefer asynchronous |
|---|---|---|
| Must user immediately see the result? | Yes | No |
| Expected duration | Under project-defined safe threshold | Above safe threshold or unpredictable |
| External dependency involved? | Only fast and reliable | Yes, especially if slow/unreliable |
| Can operation be retried safely? | Not relevant or trivial | Yes or can be made idempotent |
| User experience | Blocking is acceptable | Progress/status is better |
| Volume | Low | High, bursty, or scheduled |
| Failure recovery | Immediate user correction | Retry, reconciliation, manual review |
| Data integrity | Must complete in one transaction | Can use outbox, saga, or compensation |

Default rule: keep command validation and user-critical state changes synchronous when small; move non-critical side effects to asynchronous runtime.

---

## 7. Job and Queue Standard

A job is a durable unit of work that can be executed outside the initial request.

Each job should declare:

- job key/name;
- trigger source;
- owning domain module;
- input schema/version;
- actor/system context rules;
- tenant/scope context where applicable;
- idempotency key strategy;
- timeout;
- retry policy;
- dead-letter policy;
- priority;
- concurrency/lock requirements;
- audit/observability requirements;
- expected success and failure outcomes.

Jobs must not accept arbitrary unvalidated payloads. The job payload is a contract and should be versioned when persistent queues or delayed jobs may outlive deployments.

---

## 8. Scheduling Standard

Scheduled tasks should be explicit, inventoried, and safe to run more than once. A scheduled task may be triggered by system cron, application scheduler, database scheduler, hosting control panel, cloud scheduler, or manual CLI execution.

Each scheduled task should declare:

- schedule expression or operational trigger;
- timezone assumptions;
- production/staging/dev availability;
- maximum expected duration;
- overlap policy;
- lock key;
- retry/failure behavior;
- alert/escalation behavior;
- dry-run capability when destructive or high-risk;
- observability and audit requirements.

Never hide critical production logic in undocumented cron entries.

---

## 9. Event Consumer and Webhook Standard

Event consumers and webhooks must be contract-driven and idempotent.

Required controls:

1. Validate message/event schema before processing.
2. Record event/message ID where possible.
3. Prevent duplicate processing through an inbox, idempotency table, natural key, or equivalent strategy.
4. Verify signatures/secrets for external webhooks.
5. Separate external webhook receipt from internal processing where work may be slow.
6. Preserve raw event safely when needed for audit/debugging, but redact secrets and sensitive data.
7. Define retry, poison-message, and manual-review behavior.
8. Emit a clear outcome: accepted, ignored, processed, failed, retried, dead-lettered, or manually reviewed.

---

## 10. Idempotency and Deduplication

All background jobs, retries, webhook handlers, event consumers, imports, exports, and payment/billing-like operations must define an idempotency strategy.

Common strategies:

- client-supplied idempotency key;
- server-generated operation ID;
- event/message ID;
- natural business key;
- unique database constraint;
- inbox/outbox record;
- content hash;
- lock plus state transition guard.

A retry must not accidentally duplicate invoices, emails, user accounts, payments, role assignments, file exports, notifications, or external API calls.

---

## 11. Retry, Timeout, and Dead-Letter Policy

Every runtime operation must define what happens when it fails.

| Failure type | Recommended treatment |
|---|---|
| Validation failure | Do not retry. Mark failed with reason. |
| Authorization failure | Do not retry unless context was temporary. Log/audit if privileged. |
| Transient network/API failure | Retry with backoff and jitter. |
| Rate limit | Retry after delay or schedule according to provider guidance. |
| Lock contention | Retry with small delay or skip if safe. |
| Data conflict | Re-read and retry only if operation is designed for it. |
| Poison message | Stop retrying and dead-letter/manual review. |
| Unknown exception | Retry within limit, then dead-letter/escalate. |

Retries should have a maximum attempt count, backoff strategy, and terminal state. Infinite silent retries are forbidden.

---

## 12. Runtime State Model

Longer-running or asynchronous work should expose a state model.

Recommended states:

```text
pending
queued
scheduled
running
waiting
retrying
succeeded
partially_succeeded
failed
cancelled
expired
dead_lettered
manual_review
```

State transitions should be explicit. High-risk operations should record actor, scope, operation ID, reason, and outcome.

---

## 13. Locks and Concurrency

Use locks when duplicate or concurrent execution can corrupt data, overload systems, or violate business rules.

Lock types:

- per-tenant lock;
- per-resource lock;
- per-job-key lock;
- per-external-provider lock;
- distributed lock where infrastructure supports it;
- database advisory/row lock;
- file lock for shared-hosting or small deployments.

Locks must have expiration/lease behavior where possible. A lock that can never clear is an outage risk.

---

## 14. Cache, Sessions, and Temporary Runtime Data

Cache and session storage are runtime accelerators, not records of truth.

Rules:

1. Cache keys must include tenant/scope/user context where data is scoped.
2. Caches must have clear invalidation or TTL policy.
3. Cached permissions/capabilities must not create stale privilege escalation.
4. Sessions must not store large or sensitive datasets unnecessarily.
5. Temporary files must have retention, cleanup, and access-control rules.
6. Exports and generated files must expire unless policy requires retention.
7. Rebuildable projections must be documented as rebuildable.

---

## 15. Batch, Import, Export, and Long-Running Tasks

Large operations need operational structure.

Required considerations:

- chunking/batching strategy;
- progress tracking;
- resumability;
- cancellation;
- partial success behavior;
- validation report;
- duplicate detection;
- error export/report;
- sensitive-data handling;
- retention and cleanup;
- user notification;
- audit trail for privileged imports/exports.

A large import/export is not a single opaque request. It is a managed runtime operation.

---

## 16. Outbox, Inbox, and Transaction Boundaries

When a database transaction must also emit an event, enqueue a job, send a webhook, or call an external system, use an outbox or equivalent pattern unless the project has a documented alternative.

Rules:

1. Commit record-of-truth changes and outbound intent atomically where possible.
2. Process outbound work asynchronously.
3. Record inbound event/message processing when duplicates are possible.
4. Never assume an external side effect happened just because a database transaction committed.
5. Never assume a database change committed just because an external call succeeded.

For multi-step workflows that cannot be one transaction, use saga/compensation or documented reconciliation.

---

## 17. Runtime Profiles

| Profile | Description | Acceptable runtime adapters |
|---|---|---|
| Shared hosting | Limited control, often PHP, cron, database, filesystem. | Cron, DB-backed jobs, filesystem locks, simple mail queue. |
| Open-source distributable | Must run in varied user environments. | Pluggable adapters, optional queues, safe fallbacks. |
| VPS/self-hosted | More control over daemons and services. | Supervisor/systemd workers, Redis-compatible queues, DB queues, cron. |
| On-prem/private server | Security, local control, limited external dependencies. | Internal brokers, scheduled workers, local queues, offline reconciliation. |
| Scalable SaaS | High volume, multi-tenant, externally exposed. | Dedicated brokers, worker pools, event mesh, DLQs, distributed locks. |
| Cloud-native | Managed services acceptable when chosen. | Cloud queues, cloud schedulers, event buses, managed cache. |

The project adapter must declare which runtime profile applies. Do not impose Kafka, Kubernetes, Redis, RabbitMQ, or cloud queues on projects that do not need or cannot support them.

---

## 18. Technology-Agnostic Adapter Contract

Every repository should define `.qli/runtime-adapter.md` with:

- runtime profile;
- queue technology or fallback;
- scheduler technology;
- worker execution model;
- lock provider;
- cache provider;
- session provider;
- temp file strategy;
- job state storage;
- retry/dead-letter mechanism;
- observability hooks;
- local development behavior;
- production behavior;
- unsupported technologies or forbidden core technologies.

Adapters can change. Runtime contracts and business logic should survive adapter changes.

---

## 19. Testing Standard

Runtime tests should prove execution, failure, retry, idempotency, and recovery.

Required test categories where applicable:

1. Job payload schema validation.
2. Job executes the correct Core use case.
3. Duplicate job/event/webhook does not duplicate side effects.
4. Retry policy works for transient failures.
5. Non-retryable failures stop correctly.
6. Dead-letter/manual-review state is reachable.
7. Scheduled task does not overlap when overlap is forbidden.
8. Lock prevents unsafe concurrent execution.
9. Cache invalidation does not expose stale unauthorized data.
10. Batch import/export can resume or fail safely.
11. Outbox/inbox processing preserves consistency.
12. Runtime state and progress are visible where required.
13. Privileged runtime operations are audited.

---

## 20. Review Checklist

Before accepting runtime work:

- [ ] The trigger and runtime mode are identified.
- [ ] Business logic remains in Core/use cases.
- [ ] Runtime handler is thin and adapter-oriented.
- [ ] The operation has timeout, retry, and terminal failure behavior.
- [ ] Idempotency/deduplication is defined where retries or external events exist.
- [ ] Lock/concurrency policy is defined where needed.
- [ ] Queue/schedule/event/job inventory is updated.
- [ ] Runtime state and progress are recorded where needed.
- [ ] Cache/session/temp-file behavior is safe and scoped.
- [ ] Access-control and data-scope rules are enforced where applicable.
- [ ] Observability/audit hooks exist for significant operations.
- [ ] Tests include success and failure paths.
- [ ] Shared-hosting/open-source/self-hosted/scalable constraints are respected.

---

## 21. Anti-Patterns

Do not:

- put business rules directly in cron scripts, queue callbacks, webhook handlers, or controllers;
- create anonymous one-off jobs with no inventory entry;
- retry non-idempotent operations without protection;
- silently swallow background job failures;
- make external API calls inside database transactions without a documented reason;
- rely on cache as source of truth;
- store tenant-scoped data in unscoped cache keys;
- run scheduled jobs without overlap control when unsafe;
- leave failed jobs invisible to operators;
- create runtime behavior that only works in one hosting model unless explicitly approved;
- introduce heavyweight infrastructure when a project profile requires shared-hosting or simple self-hosted compatibility.

---

## 22. Minimum Acceptable MVP

A serious application runtime MVP should include:

1. documented runtime adapter;
2. clear sync/async decision rule;
3. job/scheduled task inventory if background work exists;
4. retry/failure policy for background work;
5. idempotency for retryable or external-triggered work;
6. basic logging with request/job/trace identifiers;
7. safe cache/session/temp-file rules if used;
8. tests for success and failure paths;
9. no business logic buried in runtime adapters;
10. documentation of deferred runtime risks.

---

## QLi v2 Addendum — Runtime Applicability and Spine

Runtime Operations are profile-triggered. A simple request/response application may start with no queue, scheduler, cache, or worker, but that decision must be explicit.

Minimum runtime spine evidence:

- Runtime model selected in `.qli/project/operating-profile.yml`.
- Start/stop/smoke commands documented.
- Session/cache decision documented if the app has login, personalization, or temporary state.
- Job/queue/scheduler decision documented if background work is planned or explicitly deferred.
- Idempotency/failure policy documented for jobs, webhooks, imports, exports, or retries.
- Locking/concurrency policy documented when duplicate side effects are possible.

## Buildline Implementation Control

This foundation is governed operationally by `.qli/rof/specs/runtime-implementation-control.md`.

Use the full reference for doctrine and vocabulary. Use the implementation-control file for the project-agnostic minimum spine, optional capability rules, deferral rules, evidence expectations, test/smoke expectations, common AI-agent failure modes, and definition of done.

Project-specific applicability is not decided inside this reference file. It is decided through `.qli/binding/` and recorded in `.qli/project/foundation-applicability.yml`.
