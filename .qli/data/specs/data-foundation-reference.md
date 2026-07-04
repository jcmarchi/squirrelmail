# Universal Data Foundation Reference

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Version:** 1.0-Universal  
**Intended location:** `.qli/data-foundation-reference.md`  
**Audience:** AI Coding Companions, human architects, implementation reviewers  
**Purpose:** Define a reusable, technology-agnostic data modeling, dataset, schema-evolution, lifecycle, and storage-decision foundation that can be applied to new and existing applications.

---

## 0. Mandatory Instruction to the AI Coding Companion

Before creating, modifying, migrating, deleting, importing, exporting, caching, indexing, eventing, reporting, or refactoring data-related code, read this file and treat it as the repository's data architecture source of truth.

The AI Coding Companion must not jump directly to choosing PostgreSQL, MySQL, SQLite, MongoDB, Redis-compatible storage, object storage, search engines, queues, event streams, vector stores, or analytical databases. First classify the data entity, dataset, event, file, projection, cache, and lifecycle requirement. Storage is an adapter decision, not the data model itself.

Implementation sequence:

1. Inspect the roadmap, existing data model, migrations, seeds, schemas, API contracts, event contracts, repositories, services, jobs, imports, exports, reports, analytics, and tests.
2. Read `.qli/data-adapter.md` if present.
3. Read `.qli/data-entity-inventory.md`, `.qli/data-dataset-inventory.md`, `.qli/data-storage-decision-matrix.md`, `.qli/data-lifecycle-matrix.md`, and `.qli/data-schema-evolution-log.md` if present.
4. Classify each new or affected entity using the decision matrix in this reference.
5. Define or update the language-neutral schema contract before changing physical storage.
6. Preserve backward compatibility unless a documented migration plan explicitly allows a breaking change.
7. Use universal identifiers and standard data types.
8. Enforce tenancy/scope, lifecycle, retention, auditability, validation, and access-control implications.
9. Add tests for data validity, migration, containment, retention, idempotency, and failure modes.
10. Update the relevant inventories and matrix files before declaring the implementation complete.

---

## 1. What This Foundation Is

The Universal Data Foundation is not a database preference. It is a decision framework for turning product requirements into stable data contracts, safe schemas, explicit lifecycle rules, reliable datasets, and replaceable storage adapters.

It applies to SaaS, single-tenant applications, public websites, modular business systems, internal tools, API platforms, event-driven systems, analytics products, AI-enabled systems, and offline-capable applications. Not every application needs advanced tenancy, event sourcing, ledger storage, physical data silos, or analytical tiering on day one. However, the architecture must make those decisions explicit instead of accidental.

The foundation separates five concerns:

| Concern | Meaning |
|---|---|
| Conceptual model | The business meaning of the entity or dataset. |
| Logical contract | The language-neutral schema, identifiers, validation, and compatibility rules. |
| Access and consistency profile | How data is read, written, contested, synchronized, and allowed to fail. |
| Lifecycle and governance | Retention, auditability, deletion, residency, privacy, sensitivity, and archival behavior. |
| Physical adapter | Tables, collections, streams, files, indexes, caches, projections, warehouses, vector stores, or other implementation details. |

---

## 2. Relationship to UI, API, and Access-Control Foundations

Data decisions are not isolated.

The UI Foundation consumes data through views, forms, tables, filters, pagination, validation states, empty states, and export workflows. The UI must not invent data shapes.

The API Foundation exposes data through OpenAPI contracts, AsyncAPI contracts, event schemas, request/response DTOs, idempotent commands, and integration boundaries. API contracts should reference or align with the data foundation's logical schema contracts.

The Access-Control Foundation determines who can read, write, export, delete, mask, redact, restore, approve, publish, or administer data. Data models must include ownership, scope, sensitivity, and audit metadata where required.

The Data Foundation is the bridge between product meaning and implementation mechanics.

---

## 3. Core Data Principles

1. **Contract before storage.** Define the entity contract, schema, events, and lifecycle before choosing or changing storage.
2. **Data models must serve the product roadmap.** Do not over-normalize, denormalize, event-source, or distribute without a clear access pattern and lifecycle need.
3. **One entity may require multiple physical forms.** A record of truth, read projection, search document, cache entry, event log, analytical fact, and export file may all represent the same business concept differently.
4. **Storage adapters are replaceable.** Business logic must depend on ports/interfaces/repositories, not direct database details.
5. **Schema-on-write for records of truth.** Primary records must reject invalid data at the boundary.
6. **Schema-on-read is acceptable for exploratory or evolving datasets only when documented.** It is not a substitute for contract discipline.
7. **Universal identifiers are mandatory for portable records.** Externally visible records should use UUIDv7, ULID, or another approved globally unique identifier.
8. **No casual hard deletes.** Deletion, redaction, anonymization, archival, and retention must be explicit per entity.
9. **Auditability is a data requirement, not only an application feature.** High-risk entities need append-only history or ledger-style mutation records.
10. **Every data entity must define its failure mode.** Decide what happens during conflict, delay, partition, outage, duplicate delivery, partial migration, or stale read.

---

## 4. Data Classification Model

Every entity, dataset, stream, file, or projection must be classified before implementation.

### 4.1 Truth Category

| Category | Meaning | Typical treatment |
|---|---|---|
| Record of Truth | Canonical business state. | Strong validation, migrations, audit trail, backup, controlled updates. |
| Derived Projection | Query-optimized view of truth data. | Rebuildable, versioned, eventually consistent where acceptable. |
| Event / Ledger | Append-only fact that something happened. | Immutable, ordered where needed, idempotent consumers. |
| Operational Log | Runtime diagnostic or activity trail. | Retained by policy, searchable, privacy-screened. |
| Analytical Dataset | Aggregated or transformed reporting/BI data. | ETL/ELT, lineage, delayed freshness, columnar/warehouse adapter optional. |
| Reference Data | Stable lookup/configuration values. | Seeded, versioned, governed, low-churn. |
| Tenant Configuration | Customer/account-specific settings. | Scoped, audited, validation-heavy. |
| Cache | Temporary performance copy. | Rebuildable, TTL, never sole authority. |
| Search Document | Search-optimized representation. | Rebuildable, denormalized, stale-tolerant by design. |
| File / Blob | Binary or large object. | Metadata record plus storage adapter, checksum, retention. |
| Secret / Credential | Sensitive operational data. | Encrypted/managed outside ordinary application tables. |
| ML / Vector Data | Embeddings, features, prompts, model outputs, labels. | Lineage, versioning, privacy, reproducibility. |
| External Mirror | Copy of third-party data. | Sync state, source attribution, freshness, reconciliation rules. |

### 4.2 Entity Decision Record

Each entity should have an entity decision record in `.qli/data-entity-inventory.md` with these fields:

```text
Entity Name:
Business Purpose:
Truth Category:
Owner / Module:
Scope / Tenancy:
Primary Identifier:
External Identifier Exposure:
Access Pattern:
Read/Write Ratio:
Write Contention:
Consistency Requirement:
Failure Mode:
Lifecycle / Retention:
Sensitivity / Classification:
Audit Requirement:
Deletion Behavior:
Schema Contract:
Physical Adapter:
Indexes / Query Shapes:
Events Produced:
Events Consumed:
API Contracts:
Migration Notes:
Tests Required:
```

---

## 5. Multidimensional Data Decision Matrix

The AI Coding Companion must evaluate every non-trivial entity through this matrix.

| Dimension | Required decision |
|---|---|
| Business criticality | Informational, operational, contractual, financial, legal, safety-critical, regulated. |
| Truth status | Record of truth, projection, cache, event, file, analytical dataset, external mirror. |
| Access pattern | Read-heavy, write-heavy, append-only, aggregate-heavy, search-heavy, graph-like, time-series, batch. |
| Predictability | Structured/repetitive, semi-structured, nested/evolving, sparse, high-variance. |
| Write contention | Single writer, low contention, high contention, collaborative, append-only. |
| Read latency | Interactive, background, batch, analytical, offline. |
| Throughput | Low, moderate, high, bursty, streaming. |
| Consistency | Strong, bounded stale, eventual, read-your-writes, monotonic reads, ledger immutable. |
| Failure mode | Deny, queue, retry, stale read, degraded read-only, reconcile later, manual review. |
| Lifecycle | Temporary, active, retained, archived, immutable, expiring, regulated. |
| Sensitivity | Public, internal, confidential, restricted, regulated, secret. |
| Scope | Global, platform, organization, tenant, workspace, project, resource, field, self. |
| Residency | No restriction, tenant region, legal region, customer-specific, physical silo candidate. |
| Auditability | None, standard change log, privileged audit, append-only ledger, external evidence. |
| Schema evolution | Additive, transformable, versioned, breaking migration required, dual-write period. |
| Portability | Local only, API-exposed, import/export, cross-stack merge, multi-region, offline sync. |

---

## 6. Integrity Gate: Safety First

The first decision is whether the data is a primary record of truth or otherwise safety-critical.

If yes, the implementation must prioritize:

- schema-on-write validation;
- controlled migrations;
- ACID-style transactional behavior where the adapter supports it;
- optimistic or pessimistic concurrency control;
- audit trail or ledger history;
- explicit deletion/retention policy;
- backup and restore expectations;
- server-side authorization and tenancy containment;
- tests for invalid data rejection and migration safety.

Examples: invoices, bids, payments, inspections, legal records, role assignments, user identity, signed documents, safety logs, inventory counts, publishing state, tenant configuration, and security settings.

If no, the entity may favor availability, throughput, append-only processing, denormalized projections, eventual consistency, or schema-on-read, but only when the decision is documented.

---

## 7. Access Pattern Profile

### 7.1 Read-Heavy Data

Read-heavy data is read far more often than it is modified. Typical strategies include query indexes, read projections, denormalized views, materialized summaries, cache with invalidation, and CQRS read models.

Rules:

- Do not denormalize the record of truth casually.
- Prefer rebuilding read models from truth records or events.
- Document freshness expectations.
- Document cache invalidation and rebuild paths.

### 7.2 Write-Heavy Data

Write-heavy data should avoid unnecessary locking and synchronous fan-out. Typical strategies include append-only events, buffered writes, asynchronous workers, idempotent commands, batched processing, and conflict detection.

Rules:

- Require idempotency keys for retryable writes.
- Use event records or write logs when history matters.
- Avoid overwriting high-value history.
- Define backpressure and retry behavior.

### 7.3 Search-Heavy Data

Search-heavy data usually needs an index or search document separate from the record of truth.

Rules:

- Treat search documents as projections.
- Define rebuild strategy.
- Define stale-search tolerance.
- Redact sensitive fields before indexing.

### 7.4 Analytical Data

Analytical data is optimized for reporting, aggregates, cohorts, forecasts, metrics, or BI.

Rules:

- Do not make operational transactions depend on analytics stores.
- Track lineage from source records/events to analytical facts.
- Define freshness SLA.
- Separate personally identifiable data or apply pseudonymization where appropriate.

### 7.5 Graph-Like Data

Graph-like access appears when relationships are the dominant query model: dependencies, permissions, recommendations, supply chains, social links, ownership trees, or workflow routing.

Rules:

- Start with explicit relationship entities unless graph depth/performance justifies a graph adapter.
- Avoid hidden many-to-many logic in JSON blobs when relationships need permissions, history, or reporting.

---

## 8. Consistency and Failure-Mode Model

The AI Coding Companion must not use CAP theorem as a slogan. In distributed systems, partition tolerance becomes a practical reality when network or service partitions occur. The required decision is how the entity should behave under failure or delay.

| Consistency model | Use when | Failure-mode expectation |
|---|---|---|
| Strong consistency | Financial, inventory, security, ownership, legal, safety, role assignment. | Reject or block conflicting operations until safe. |
| Read-your-writes | User expects immediate visibility after saving. | Route reads to authoritative store or session-aware projection. |
| Bounded staleness | Slight delay is acceptable but bounded. | Show freshness indicator or retry. |
| Eventual consistency | Feeds, notifications, search indexes, analytics, projections. | Accept stale reads and reconcile asynchronously. |
| Append-only immutability | Audit, ledger, irreversible operational facts. | Never update/delete original event; append correction/reversal. |
| Offline-first reconciliation | Mobile/offline/edge scenarios. | Detect conflicts and resolve by policy or human review. |

Every entity must define one of these, or a project-specific equivalent.

---

## 9. Universal Identity Standard

External and cross-system identifiers must be globally unique and portable.

Rules:

1. Prefer UUIDv7 or ULID for records exposed outside the local database.
2. Do not expose auto-increment integer IDs in public APIs unless a legacy adapter requires it and a stable external ID also exists.
3. Use stable IDs in OpenAPI/AsyncAPI schemas, events, logs, imports, exports, and object metadata.
4. Include source-system IDs when mirroring external data.
5. Preserve identifiers through migration; do not re-key live entities without a mapping table.
6. For tenant-scoped objects, global ID uniqueness remains preferred even when tenant-local slugs or numbers exist.

Recommended common fields:

```text
id
public_id or external_id when needed
tenant_id / organization_id / workspace_id / project_id where scoped
created_at
created_by
updated_at
updated_by
deleted_at / archived_at where applicable
version or revision
schema_version
trace_id / correlation_id where operationally useful
```

---

## 10. Standard Data Types and Semantics

All schemas must use stable semantic types, not ambiguous strings.

| Concept | Standard rule |
|---|---|
| Time | ISO-8601 timestamps, UTC at rest unless a local legal/business time must be stored separately. |
| Date-only | Store date without timezone only when the concept is truly date-only. |
| Currency | ISO-4217 currency code plus decimal amount or integer minor units. |
| Decimal | Use decimal-safe storage for money, quantities, rates, measurements. Avoid binary floating point for money. |
| Boolean | Use true/false; avoid yes/no strings. |
| Enum | Version and document allowed values. Add values carefully. |
| JSON | Allowed for extensibility, but not as a hiding place for core relational data. |
| File | Store metadata, checksum, MIME type, size, storage adapter key, retention class. |
| Measurement | Store value and unit explicitly. |
| Locale | Store language/locale codes explicitly where content is localized. |
| Address/location | Separate user-entered display address from normalized/geocoded components. |

---

## 11. Schema Contracts

A schema contract defines the portable logical shape of data before it is stored in a specific adapter.

Required contract layers:

1. **Entity schema** for records of truth.
2. **API schema** for public/internal HTTP request and response DTOs.
3. **Event schema** for emitted and consumed events.
4. **Import/export schema** for CSV, JSONL, XML, archive, spreadsheet, or external interchange formats.
5. **Projection schema** for query/search/reporting/read models.

Rules:

- Use JSON Schema or equivalent language-neutral schema as the baseline.
- Align API schemas with OpenAPI.
- Align event schemas with AsyncAPI.
- Validate external input before it reaches business logic.
- Version schemas when compatibility changes.
- Never assume database schema equals external API schema.

---

## 12. Schema Evolution and Migration

Schema changes must be compatible by default.

Safe changes:

- add nullable or defaulted fields;
- add optional enum values when consumers tolerate unknown values;
- add indexes;
- add projections;
- add new event types;
- add new API response fields when consumers ignore unknown properties.

Risky or breaking changes:

- rename fields;
- change field meaning;
- change type or precision;
- remove fields;
- make nullable fields required;
- split/merge entities;
- change identifier semantics;
- change deletion behavior;
- change event ordering or idempotency semantics.

For risky changes, require a migration plan:

```text
Change:
Reason:
Affected entities:
Backward compatibility:
Read path transition:
Write path transition:
Dual-write needed:
Backfill needed:
Rollback plan:
Data validation plan:
Contract version impact:
Tests:
```

---

## 13. Lifecycle, Retention, Deletion, and Archival

Every entity must specify lifecycle behavior.

| Lifecycle state | Meaning |
|---|---|
| Draft | User or system-created but not authoritative. |
| Active | Current operational record. |
| Locked | Cannot be edited except by privileged correction workflow. |
| Archived | Not active, retained for history or compliance. |
| Soft-deleted | Hidden but recoverable until retention expires. |
| Redacted | Sensitive fields removed/masked, record shell retained. |
| Anonymized | Personal identity irreversibly removed while aggregate value remains. |
| Expired | Past retention and eligible for deletion or destruction. |
| Immutable | Append-only; corrections are new records/events. |

Rules:

- Right-to-be-forgotten workflows must distinguish deletion, anonymization, redaction, and legal retention.
- Audit logs and financial/legal/safety records may be retained even when personal data is redacted.
- Cold storage must preserve restore and readability obligations.
- Archives must include schema/version context.
- Deletion jobs must be testable and auditable.

---

## 14. Data Sovereignty, Sensitivity, and Residency

Each entity must declare sensitivity and residency needs.

Sensitivity levels:

```text
public
internal
confidential
restricted
regulated
secret
```

Residency options:

```text
none
tenant_region
legal_region
customer_region
physical_silo_candidate
physical_silo_required
```

Rules:

- Tenant identifiers must be present on tenant-scoped records or derivable through enforced containment.
- Cache keys, storage paths, search indexes, queues, analytical datasets, and backups must preserve tenant/scope boundaries where needed.
- Sensitive fields must not be copied into logs, search indexes, events, analytics, or AI datasets unless explicitly approved and redacted where needed.
- Physical siloing is a project/tenant requirement, not a default for every product.

---

## 15. Polyglot Storage Strategy

The foundation does not prescribe one database. It tells the AI Companion how to justify a storage adapter.

| Storage pattern | Best for | Caution |
|---|---|---|
| Relational / SQL | Records of truth, transactions, constraints, reporting joins. | Avoid using one giant schema without boundaries. |
| Document | Nested, evolving, sparse data with aggregate access. | Avoid hiding core relationships and permissions in blobs. |
| Event stream / ledger | Append-only facts, workflow history, audit, replay. | Requires idempotent consumers and retention strategy. |
| Key-value / cache | Fast temporary reads, sessions, rate limits, computed fragments. | Never sole source of truth. |
| Search index | Full-text, faceted search, relevance ranking. | Projection only; rebuildable; redact sensitive data. |
| Object storage | Files, media, large exports, archives. | Needs metadata, checksum, ACL, lifecycle policy. |
| Time-series | Metrics, sensor data, operational telemetry. | Not ideal for transactional entity state. |
| Graph | Relationship traversal and dependency analysis. | Start with relationship tables unless graph depth justifies it. |
| Analytical warehouse/lake | BI, aggregates, long-term analysis. | Do not make operational workflows depend on delayed pipelines. |
| Vector store | Embeddings, semantic search, AI retrieval. | Requires source lineage, privacy controls, re-embedding strategy. |

Storage recommendation must include the reason, rejected alternatives, and adapter boundary.

---

## 16. Dataset Implementation Standard

A dataset is a governed collection of records used for operational work, reporting, import/export, AI, search, analytics, or integration.

Each dataset must define:

```text
Dataset Name:
Purpose:
Source Entities:
Truth Status:
Freshness SLA:
Transformation Logic:
Schema Version:
Owner:
Access Controls:
Sensitivity:
Retention:
Lineage:
Rebuild Process:
Export Format:
Import Format:
Quality Checks:
```

Dataset categories:

| Category | Description |
|---|---|
| Operational dataset | Used by the application for user-facing work. |
| Reference dataset | Controlled vocabulary, lookup, seed, or taxonomy. |
| Analytical dataset | Aggregated or transformed for reporting/BI. |
| Integration dataset | Imported/exported from external systems. |
| AI/ML dataset | Training, evaluation, embeddings, labels, generated outputs. |
| Audit/evidence dataset | Compliance, history, legal or review evidence. |

---

## 17. Metadata and Observability Fields

Data must be observable enough to debug production behavior.

Recommended metadata fields by category:

| Category | Fields |
|---|---|
| Creation/update | `created_at`, `created_by`, `updated_at`, `updated_by` |
| Scope | `tenant_id`, `organization_id`, `workspace_id`, `project_id` as applicable |
| Lifecycle | `status`, `archived_at`, `deleted_at`, `retention_until` |
| Versioning | `version`, `revision`, `schema_version`, `source_version` |
| Traceability | `request_id`, `trace_id`, `correlation_id`, `causation_id` |
| Import/export | `source_system`, `source_id`, `import_batch_id`, `export_batch_id` |
| Integrity | `checksum`, `hash`, `signature`, `lock_version` |

Do not add every field to every table blindly. Use the metadata needed by the entity classification.

---

## 18. Event and Queue Data Rules

For event-driven systems, event records and messages are data contracts.

Event requirements:

- stable event name;
- event version;
- unique event ID;
- occurred timestamp;
- producer;
- subject/entity ID;
- tenant/scope where applicable;
- correlation ID and causation ID;
- payload schema;
- idempotency strategy;
- retention policy;
- replay policy;
- dead-letter behavior.

Event naming recommendation:

```text
module.entity.event_name.v1
```

Examples:

```text
identity.user.created.v1
billing.invoice.approved.v1
content.article.published.v1
project.task.completed.v1
```

Events should represent facts that happened, not vague commands, unless the stream is explicitly a command queue.

---

## 19. Imports, Exports, and Interchange

Imports and exports are data products and must have contracts.

Rules:

1. Define schema before accepting import files.
2. Validate rows/records before mutation.
3. Support dry-run validation for risky imports.
4. Store import batch metadata and errors.
5. Use idempotency keys or external IDs to avoid duplicates.
6. Do not export sensitive fields without access-control and audit checks.
7. Export files should include schema/version metadata.
8. Large exports should be asynchronous and auditable.
9. CSV/spreadsheet formats must define encoding, delimiter, headers, date format, and null representation.

---

## 20. Tenant, Scope, and Ownership Modeling

Data scope must be explicit. The model may be single-tenant today and multi-tenant later, but it should not make future scope impossible.

Scope levels:

```text
platform > organization > tenant > workspace > project > resource > field > self
```

Rules:

- Tenant-scoped data must include tenant context or an enforced path to tenant context.
- Child records must not trust parent IDs from clients without containment verification.
- Ownership and assignment are not the same as tenancy.
- Public/shared/global records must be explicitly marked.
- Cross-tenant/shared records require documented policy and tests.

---

## 21. Validation and Quality Gates

Every data implementation must include validation at the correct layers.

| Layer | Validation responsibility |
|---|---|
| API boundary | Request schema, type, format, required fields, size, authorization context. |
| Application service | Business rules, state transitions, workflow constraints. |
| Data adapter | Constraints, indexes, transactions, uniqueness, referential integrity where supported. |
| Event consumer | Schema validation, idempotency, replay handling. |
| Import pipeline | File shape, row validation, dedupe, dry-run, batch errors. |
| Dataset pipeline | Transformation tests, freshness checks, lineage checks. |

Do not rely only on client-side validation.

---

## 22. Refactoring Existing Data Models

For existing applications, the AI Coding Companion must not rewrite data structures blindly.

Refactor sequence:

1. Inventory entities, tables, collections, files, streams, datasets, migrations, seeds, and API/event schemas.
2. Identify records of truth versus projections/caches/derived data.
3. Identify live contracts and consumers.
4. Identify risky fields: IDs, ownership, money, dates, status, permissions, deletion flags, external IDs.
5. Classify current deficiencies: duplication, nullable ambiguity, hidden JSON, inconsistent timestamps, unsafe deletes, missing tenancy, broken indexes, untracked migrations.
6. Propose a safe migration plan.
7. Preserve backwards read compatibility where possible.
8. Use dual-read, dual-write, backfill, view compatibility, or adapter translation where required.
9. Add migration tests before destructive changes.
10. Document unavoidable breaking changes.

---

## 23. New Project Implementation Sequence

For new projects, build the data foundation early and incrementally.

Recommended sequence:

1. Create `.qli/data-foundation-reference.md`.
2. Create `.qli/data-adapter.md`.
3. Create initial entity inventory for the first vertical slice.
4. Define the scope/tenancy model even if the first release is single-tenant.
5. Define universal ID strategy.
6. Define schema contract format and location.
7. Define migration strategy.
8. Define seed/reference data strategy.
9. Define event and dataset conventions if the project uses EDA or analytics.
10. Implement the first entity through a complete vertical slice: schema, repository/port, API contract, UI usage, authorization, tests, and migration docs.

---

## 24. Testing Standard

Data work is incomplete without tests.

Required test categories:

- schema validation accepts valid data and rejects invalid data;
- migrations run forward and backward where practical;
- old records remain readable after schema change;
- required indexes/constraints exist;
- duplicate/external IDs are handled correctly;
- tenancy/scope containment is enforced;
- soft delete/archival/redaction behaves correctly;
- retention jobs affect only eligible records;
- import dry-run reports errors without mutation;
- export respects access controls and schema version;
- event consumers are idempotent;
- projections can rebuild;
- caches are not treated as truth;
- analytical datasets have freshness and lineage checks;
- migration/backfill scripts are safe to re-run or explicitly guarded.

---

## 25. Anti-Patterns to Avoid

Do not allow these patterns:

- choosing a database before classifying the entity;
- making every entity a JSON blob;
- making every entity a relational table without understanding access patterns;
- exposing internal auto-increment IDs as portable public identifiers;
- changing field meaning without versioning;
- hard deleting records with legal, financial, audit, user, tenant, or security impact;
- storing money in floating-point fields;
- storing local times without timezone/locale meaning;
- using caches as records of truth;
- indexing sensitive data into search without redaction review;
- duplicating datasets without lineage;
- writing event consumers that are not idempotent;
- adding migrations with no tests;
- allowing AI agents to silently rename fields used by APIs or exports;
- mixing tenant data in cache keys, files, queues, or reports;
- adding analytics pipelines that operational workflows depend on synchronously.

---

## 26. Review Checklist

Before accepting data work, verify:

- [ ] Entity classification is documented.
- [ ] Truth source is identified.
- [ ] Schema contract exists or was updated.
- [ ] Storage choice is justified as an adapter decision.
- [ ] Identifier strategy follows the project standard.
- [ ] Standard data types are used.
- [ ] Tenancy/scope/ownership are modeled correctly.
- [ ] Access-control implications are documented.
- [ ] Lifecycle, retention, deletion, and archival behavior are defined.
- [ ] Audit requirements are satisfied.
- [ ] Consistency model and failure mode are defined.
- [ ] Migrations are safe and tested.
- [ ] Import/export contracts are versioned where applicable.
- [ ] Events/projections/caches are not confused with records of truth.
- [ ] Sensitive data is not leaked into logs, search, events, AI datasets, or analytics.
- [ ] Inventories and matrices are updated.

---

## 27. Minimum Acceptable MVP

For a serious application, the minimum acceptable data foundation includes:

1. Entity inventory for active product entities.
2. Data adapter note.
3. Universal ID strategy.
4. Migration strategy.
5. Schema contract strategy.
6. Basic lifecycle/deletion policy.
7. Basic tenancy/scope policy if the app has users, accounts, organizations, customers, or projects.
8. Tests for schema validation and migration.
9. Route/API/event alignment with data contracts.
10. Refactor rules protecting live data and contracts.

If these are absent, the project may have tables, but it does not have a controlled data architecture.

---

## QLi v2 Addendum — Early DATA Spine

The DATA Foundation must be established before persistent feature work accumulates.

Minimum DATA spine evidence:

- Source-of-truth policy for records, projections, caches, files, events, analytics, and imports.
- Data classification: public, internal, confidential, regulated, temporary, fixture/demo, or derived.
- Identifier strategy for internal and externally visible records.
- Migration/schema evolution convention.
- Seed/demo data convention sufficient for UI and smoke review when applicable.
- Tenancy/scope containment rule when the operating profile includes tenant or organization boundaries.
- Lifecycle policy for creation, update, deletion, archival, redaction, and export where applicable.

## Buildline Implementation Control

This foundation is governed operationally by `.qli/data/specs/data-implementation-control.md`.

Use the full reference for doctrine and vocabulary. Use the implementation-control file for the project-agnostic minimum spine, optional capability rules, deferral rules, evidence expectations, test/smoke expectations, common AI-agent failure modes, and definition of done.

Project-specific applicability is not decided inside this reference file. It is decided through `.qli/binding/` and recorded in `.qli/project/foundation-applicability.yml`.
