# Observability / Audit / Telemetry Foundation Reference

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Version:** 1.0-Universal  
**Intended location:** `.qli/observability-foundation-reference.md`  
**Audience:** AI Coding Companions, human architects, implementation reviewers, operators  
**Purpose:** Define a reusable, stack-agnostic observability, audit, and telemetry foundation that applies to new and existing applications without forcing a specific hosting model, vendor, logging library, APM tool, or cloud provider.

---

## 0. Mandatory Instruction to the AI Coding Companion

Before creating, modifying, refactoring, or reviewing any logging, metrics, traces, audit events, diagnostics, health checks, dashboards, alerts, operational telemetry, correlation IDs, error reporting, security logging, job telemetry, API telemetry, data telemetry, or runtime telemetry, read this file and treat it as the observability source of truth for the repository.

Do not add ad hoc `console.log`, `print`, `var_dump`, unstructured debug output, raw stack traces, sensitive payload dumps, or one-off audit rows when an existing signal, event, logger, metric, trace, audit model, diagnostic screen, or instrumentation convention can be reused or extended.

The implementation sequence is mandatory:

1. Inspect the application stack, runtime model, existing logs, audits, metrics, tracing, error handling, health endpoints, dashboards, alerts, queues, jobs, API handlers, and tests.
2. Read `.qli/observability-adapter.md` if present.
3. Read signal, audit-event, log-event, metric, trace, dashboard, alert/runbook, privacy, and test inventories if present.
4. Classify the required signal before writing instrumentation code.
5. Reuse or extend existing signal contracts before adding new ones.
6. Ensure the signal is correlated to request, actor, tenant/scope, job, event, trace, or domain operation where applicable.
7. Protect sensitive data. Never log secrets, credentials, tokens, raw regulated data, private records, or full request bodies by default.
8. Update observability inventories and tests when signals change.
9. Report what was added, what was reused, what was intentionally omitted, and what operational risk remains.

---

## 1. What This Foundation Is

The Observability / Audit / Telemetry Foundation is the application’s diagnostic and accountability layer. It defines how the system makes behavior visible to humans and machines without coupling the core business logic to a specific tool or vendor.

This foundation does not require a large APM stack. It must work for shared hosting, open-source packages, local demos, self-hosted servers, VPS deployments, on-prem installations, single-node systems, scalable SaaS platforms, queue-heavy systems, and event-driven architectures.

The purpose is not to collect noise. The purpose is to answer four operational questions:

1. What happened?
2. Where did it happen?
3. Who or what caused it?
4. What should be done next?

---

## 2. Relationship to the Other Foundations

| Foundation | Relationship |
|---|---|
| Application Construction Doctrine | Requires every vertical slice to be reviewable and diagnosable, not merely coded. |
| Application Core / Domain | Emits domain events, business telemetry, rule outcomes, lifecycle transitions, and meaningful errors. |
| Data | Defines entity lifecycle, data lineage, schema evolution, import/export telemetry, migration telemetry, and data-quality signals. |
| API | Adds request IDs, correlation IDs, contract validation signals, endpoint metrics, webhook telemetry, and event-contract visibility. |
| Access Control | Produces security-relevant audit events, denied-access signals, impersonation logs, privilege-change logs, and route classification evidence. |
| UI | Reflects safe user-facing error states, diagnostic IDs, status banners, support references, and client-side telemetry where applicable. |
| Runtime / Operations | Instruments jobs, queues, retries, schedules, locks, dead letters, progress, and failure policies. |
| Testing / Quality | Verifies telemetry, audit events, health checks, failure visibility, and logging/privacy rules. |

Observability is cross-cutting. It must not own business rules, data models, UI behavior, API contracts, or runtime execution. It observes them and records evidence.

---

## 3. Signal Taxonomy

Every emitted signal must belong to one or more of these categories.

| Signal Type | Purpose | Mutability | Typical Consumer |
|---|---|---:|---|
| Structured log | Human/debug diagnostic event | Append-only logs; retention varies | Developer, operator, support |
| Audit event | Accountability record for security/business-sensitive action | Append-only/immutable from app perspective | Compliance, admin, security, customer admin |
| Metric | Numeric measurement over time | Aggregated | Operator, dashboard, alerting |
| Trace/span | Request, job, event, or workflow path across components | Time-bounded trace data | Developer, operator |
| Error event | Exception/failure record with context | Append-only | Developer, support |
| Business event | Meaningful business/domain occurrence | Usually append-only | Product, analytics, workflow |
| Health signal | Readiness/liveness/dependency status | Current-state | Runtime, monitor, deployer |
| Diagnostic snapshot | Safe summary of current environment/state | Generated on demand | Support, operator |

Do not confuse audit events with logs. Logs explain system behavior. Audit events prove accountability.

---

## 4. Minimum Universal Context

Every meaningful backend signal should include as many of the following fields as the project can safely provide:

| Field | Purpose |
|---|---|
| `timestamp` | ISO-8601 UTC event time. |
| `event_name` | Stable machine-readable name. |
| `severity` | Debug, info, notice, warning, error, critical, alert, emergency, or project-approved equivalent. |
| `environment` | local, dev, test, staging, production, or equivalent. |
| `service` | Application/service/module emitting the signal. |
| `version` | Application build, release, or package version when known. |
| `request_id` | Single request or command ID. |
| `correlation_id` | Cross-boundary chain ID across API, job, event, webhook, and worker flows. |
| `trace_id` / `span_id` | Distributed trace identifiers when tracing exists. |
| `actor_id` | Authenticated human or service account when applicable. |
| `effective_actor_id` | Impersonated/delegated actor when applicable. |
| `tenant_id` / `scope_id` | Scope context when the application has tenancy or scoped access. |
| `resource_type` / `resource_id` | Protected or affected object when applicable. |
| `operation` | Use case, command, job, endpoint, event handler, or workflow step. |
| `decision` | allowed, denied, accepted, rejected, succeeded, failed, retried, skipped, redacted. |
| `reason` | Safe short explanation. |
| `duration_ms` | Runtime duration when measurable. |
| `metadata` | Safe structured metadata only. |

The absence of tenant or actor context must be intentional and explainable. Public, anonymous, internal, and system events should still carry request/correlation IDs.

---

## 5. Naming Standard

Signal names must be stable, predictable, and domain-aware.

Recommended format:

```text
area.resource.action.result
```

Examples:

```text
api.users.create.accepted
api.users.create.failed
acl.roles.assign.denied
data.invoice.migration.completed
runtime.email.send.retrying
runtime.import.batch.failed
security.impersonation.started
audit.user.role_revoked
ui.session.expired.visible
```

Rules:

1. Do not name events after implementation accidents such as `foo_error`, `debug1`, `handler_failed`, or `new_log`.
2. Do not rename signal names casually. Deprecate and map forward.
3. Do not use user-facing prose as event names.
4. Keep event names language-neutral and stable across localization.
5. Use the same vocabulary across logs, audit events, metrics, traces, and dashboards where possible.

---

## 6. Severity and Level Standard

Recommended levels:

| Level | Meaning | Example |
|---|---|---|
| debug | Developer-only details; disabled or sampled in production | SQL timing in local dev |
| info | Normal lifecycle event | Job completed |
| notice | Important normal event | Tenant plan changed |
| warning | Recoverable abnormal condition | Retry scheduled |
| error | Operation failed but system remains available | Import failed |
| critical | Major function unavailable or data risk | Payment processing unavailable |
| alert | Immediate operator action required | Queue dead-letter spike |
| emergency | System-wide failure | Production unavailable |

Do not use `error` for expected authorization denials or user validation failures unless they indicate a system defect. Denials are usually audit/security events plus info/notice logs, not application errors.

---

## 7. Logs

Logs must be structured and machine-readable where practical. Plain text logs are acceptable only for minimal/shared-hosting environments, but even then the log message should follow a stable key/value pattern.

Required rules:

1. Use structured logging when the stack allows it.
2. Include request/correlation context.
3. Never log secrets, passwords, API keys, raw tokens, private keys, session IDs, full cookies, or authorization headers.
4. Never dump full request/response bodies by default.
5. Never log regulated/private data unless explicitly redacted, masked, or policy-approved.
6. Prefer stable error codes and event names over free-form prose.
7. Use sampling or rate controls for high-volume signals.
8. Ensure logs rotate or expire according to project profile.

---

## 8. Audit Events

Audit events are security and accountability records. They must be append-only from the application perspective and must survive ordinary application debugging practices.

Audit events are required for:

- login success/failure when relevant;
- logout;
- MFA/security changes;
- role assignment and revocation;
- permission/policy changes;
- impersonation start/end;
- tenant/account/workspace creation or ownership changes;
- billing plan, payment, or entitlement changes;
- API token/service-account creation, rotation, revocation;
- integration configuration changes;
- data export/download of sensitive records;
- destructive actions;
- failed privileged authorization attempts;
- privacy/compliance actions such as deletion, anonymization, retention hold, or data subject request processing.

Audit events must include original actor and effective actor where impersonation or delegation exists.

Audit records must be queryable by actor, tenant/scope, resource, action, time range, decision, and request/correlation ID where applicable.

---

## 9. Metrics

Metrics answer aggregate operational questions. Use them for rate, latency, volume, saturation, error ratios, queue depth, cache effectiveness, job health, and business throughput.

Recommended metric categories:

| Category | Examples |
|---|---|
| Traffic | request count, event count, webhook count |
| Latency | request duration, job duration, query duration |
| Errors | error count, failed jobs, failed events, validation failures |
| Saturation | queue depth, worker concurrency, storage usage, cache size |
| Availability | uptime, dependency health, failed health checks |
| Business | signups, publications, imports, invoices, approvals, conversions |
| Security | denied privileged attempts, token revocations, impersonation count |

Metric names should be stable, unit-aware, and low-cardinality. Never use user IDs, emails, raw URLs, or arbitrary resource IDs as metric labels.

---

## 10. Traces and Spans

Traces show how a request, command, job, webhook, or event travels through the application. Distributed tracing is optional for small applications but the trace model should still be respected through correlation IDs.

Trace spans should exist around:

- inbound HTTP/API request;
- controller/handler boundary;
- use case/application service execution;
- authorization decision;
- database transaction or repository call where useful;
- external service call;
- queue publish;
- queue consume;
- scheduled job execution;
- file import/export;
- long-running task segment.

Rules:

1. Do not put secrets or raw payloads in span attributes.
2. Use correlation IDs even when a full tracing backend is unavailable.
3. Propagate trace/correlation context across API calls, queues, events, and jobs.
4. Link asynchronous work back to the triggering request or event where possible.

---

## 11. Error and Exception Telemetry

Every handled failure path should answer:

1. What failed?
2. Was it expected or unexpected?
3. Was it visible to the user?
4. Was it retried or abandoned?
5. Is operator action required?
6. What request/correlation ID should support use to find it?

Rules:

- Domain validation failures are not system exceptions.
- Authorization denials are not ordinary application errors.
- Runtime retries should log attempt count and next retry time.
- Dead-lettered work must emit a high-severity signal and link to a runbook or review path.
- Public errors must show safe messages and diagnostic references, not stack traces.

---

## 12. Health, Status, and Diagnostics

Applications should expose safe health and diagnostic surfaces appropriate to their deployment profile.

| Surface | Purpose | Exposure |
|---|---|---|
| Liveness | Is the process responding? | Internal or deployment monitor |
| Readiness | Can the app serve traffic safely? | Internal/deployment monitor |
| Dependency health | Database, queue, storage, mail, cache, external services | Restricted/internal |
| Public status | Minimal user-safe status | Public only if product needs it |
| Diagnostic page | Detailed app state, version, queues, jobs, config, logs | Admin/dev only |

Do not expose secrets, environment variables, file paths, private network details, dependency credentials, stack traces, or tenant data in public diagnostics.

---

## 13. Dashboards, Alerts, and Runbooks

Dashboards are not a substitute for structured signals. Alerts are not useful unless they have an owner, threshold, severity, and action path.

Every production-relevant alert should define:

- signal/metric/event source;
- threshold or condition;
- severity;
- owner;
- expected action;
- runbook link or recovery procedure;
- suppression/sampling rule;
- false-positive notes;
- escalation path if applicable.

Alert anti-patterns:

- alerting on every error without context;
- alerting without ownership;
- alerting without runbook;
- alerting on user validation errors;
- alerting on high-cardinality noisy signals;
- ignoring queue/dead-letter failure signals.

---

## 14. Privacy and Sensitive Data Rules

Observability must not become a data leak.

Sensitive data includes:

- passwords, tokens, secrets, keys, cookies, session identifiers;
- personal identifiers, emails, phone numbers, addresses;
- financial data, health data, regulated data;
- private content, messages, uploaded files, internal notes;
- tenant-specific confidential records;
- authorization headers, OAuth/OIDC tokens, API keys;
- raw webhook payloads unless explicitly safe and redacted.

Redaction rules:

1. Redact before writing the signal when possible.
2. Do not rely only on downstream log scrubbers.
3. Keep a project-specific sensitive-field list.
4. Test that sensitive fields are not emitted.
5. If raw payload capture is temporarily required for debugging, it must be feature-flagged, time-limited, access-restricted, and never enabled casually in production.

---

## 15. Retention and Storage Profiles

Observability data has its own lifecycle.

| Signal | Typical retention guidance |
|---|---|
| Debug logs | Very short or disabled in production |
| Application logs | Short to medium, depending on support needs |
| Error events | Medium; long enough for release regression analysis |
| Audit events | Long; based on compliance/business policy |
| Metrics | Medium to long in aggregated form |
| Traces | Short to medium; often sampled |
| Business telemetry | Medium to long if used for product analytics |
| Diagnostic snapshots | Short; avoid retaining sensitive context |

Open-source or self-hosted applications should allow operators to configure retention. SaaS applications should centralize retention policy and document customer-visible audit retention separately.

---

## 16. New Project Procedure

For a new project, establish observability before the first real feature becomes complicated.

Minimum setup:

1. Create `.qli/observability-foundation-reference.md`.
2. Create `.qli/observability-adapter.md`.
3. Define request ID and correlation ID strategy.
4. Define structured logging convention.
5. Define audit event storage strategy if users, ACL, billing, files, or admin features exist.
6. Define basic health/status behavior.
7. Define error envelope and diagnostic ID behavior with the API foundation.
8. Add observability inventories.
9. Add tests for signal emission and sensitive-data exclusion.
10. Ensure the UI can display a safe diagnostic/support reference for failed operations.

---

## 17. Existing / Refactoring Project Procedure

For an existing project, do not rip out working logs or audit records blindly.

Refactoring sequence:

1. Inventory current logs, audit tables, metrics, traces, dashboards, health endpoints, alerts, debug routes, and error handling.
2. Identify sensitive data leaks first.
3. Identify missing correlation context.
4. Classify current signals into the taxonomy in this reference.
5. Preserve compatibility for existing support/compliance reports.
6. Introduce adapters or wrappers around existing logging/audit systems.
7. Migrate ad hoc logging gradually into structured signal contracts.
8. Add tests and smoke checks around high-risk signals.
9. Update inventories and deprecate old signal names explicitly.

---

## 18. Technology-Agnostic Adapter Model

The project adapter decides how this foundation maps to the stack.

Supported implementation profiles include:

- shared hosting with file/database logs and cron;
- open-source distributable app with pluggable logging backends;
- single VPS/self-hosted server;
- on-prem/private server;
- cloud-hosted application;
- scalable SaaS with centralized log/metric/trace pipelines;
- event-driven platform with queues and workers;
- hybrid server-rendered application;
- API-first service platform.

The foundation does not require a specific vendor. Common adapter choices may include local log files, database audit tables, syslog, structured JSON logs, OpenTelemetry-compatible instrumentation, application-specific dashboards, self-hosted logging stacks, cloud monitoring tools, or SaaS observability tools.

---

## 19. Review Checklist

Before accepting observability work, verify:

- [ ] Signals are classified as log, audit, metric, trace, error, health, business event, or diagnostic.
- [ ] Event names are stable and documented.
- [ ] Request/correlation IDs are present where applicable.
- [ ] Actor, tenant/scope, resource, and operation context are present where applicable.
- [ ] Sensitive data is redacted or omitted.
- [ ] Audit events are immutable from the application perspective.
- [ ] Metrics avoid high-cardinality labels.
- [ ] Errors have safe user-facing diagnostic references.
- [ ] Runtime retries/dead letters emit clear signals.
- [ ] Health/status endpoints do not leak private details.
- [ ] Dashboards and alerts have owners and runbooks where production-relevant.
- [ ] Tests verify signal emission and sensitive-data exclusion.
- [ ] Documentation and inventories match implementation.

---

## 20. Anti-Patterns

Avoid:

- scattering `console.log`, `print`, `echo`, `var_dump`, or temporary debug statements into production code;
- using logs as the only audit trail;
- storing secrets or raw tokens in logs;
- dumping full request bodies in production logs;
- adding metrics with user IDs or arbitrary resource IDs as labels;
- building dashboards from undefined signal names;
- alerting without ownership or recovery path;
- exposing `/debug`, `/status`, or `/health` with sensitive details;
- losing actor identity during impersonation;
- failing to correlate background jobs to the originating request or event;
- treating absence of logs as success.

---

## 21. Minimum Acceptable MVP

A serious application should have at minimum:

1. Structured or consistently formatted logs.
2. Request ID and correlation ID strategy.
3. Safe error reporting with diagnostic references.
4. Audit events for privileged/security-sensitive actions when those features exist.
5. Basic health/status behavior appropriate to deployment profile.
6. Runtime/job failure signals if background work exists.
7. Tests or smoke checks proving critical signals exist.
8. Redaction rules for sensitive fields.
9. Observability adapter documentation.
10. Signal inventories for audit events, metrics, and important logs.

Without these, the system may function, but it is not operationally trustworthy.

---

## QLi v2 Addendum — Minimum Observability Spine

Minimum observability should provide enough visibility to debug and review the product without over-instrumenting early prototypes.

Minimum observability spine evidence:

- Health/status signal where runtime exposure exists.
- Structured or consistently formatted error logging.
- Request/correlation ID policy where API/runtime diagnostics need traceability.
- Audit event classification for privileged, financial, tenant-sensitive, destructive, or security-relevant actions.
- Privacy-safe logging rule: no secrets, tokens, passwords, unnecessary PII, or sensitive payloads in logs.

## Buildline Implementation Control

This foundation is governed operationally by `.qli/oat/specs/observability-implementation-control.md`.

Use the full reference for doctrine and vocabulary. Use the implementation-control file for the project-agnostic minimum spine, optional capability rules, deferral rules, evidence expectations, test/smoke expectations, common AI-agent failure modes, and definition of done.

Project-specific applicability is not decided inside this reference file. It is decided through `.qli/binding/` and recorded in `.qli/project/foundation-applicability.yml`.
