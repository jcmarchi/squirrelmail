# Data Adapter — [Project Name]

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Location:** `.qli/data-adapter.md`  
**Purpose:** Map the Universal Data Foundation to this repository's actual stack, schema tools, storage adapters, and data workflows.

---

## 1. Project Data Context

| Field | Decision |
|---|---|
| Product | [Project Name] |
| Primary stack | [PHP / Go / Python / C# / Java / etc.] |
| Core backend restriction | Node.js and Laravel are not allowed as the core application stack unless explicitly approved. Modules/tools may be used where appropriate. |
| Rendering/API mode | [server-rendered / SPA / API-first / hybrid / CLI / workers] |
| Tenancy model | [single-tenant / tenant-ready / multi-tenant / organization-based / project-based] |
| Data maturity level | [0-5] |

---

## 2. Approved Storage Adapters

| Adapter | Status | Purpose | Notes |
|---|---|---|---|
| Relational DB | [approved/planned/rejected] | Records of truth, constraints, transactional writes | |
| Document store | [approved/planned/rejected] | Nested/evolving aggregates | |
| Object storage | [approved/planned/rejected] | Files, exports, archives | |
| Search index | [approved/planned/rejected] | Search projections | |
| Cache / key-value | [approved/planned/rejected] | Temporary performance layer | |
| Event broker/stream | [approved/planned/rejected] | Events, queues, async processing | |
| Analytical warehouse/lake | [approved/planned/rejected] | BI/reporting datasets | |
| Vector store | [approved/planned/rejected] | Embeddings/semantic search | |

---

## 3. Contract Locations

| Contract type | Location |
|---|---|
| Entity schemas | [path] |
| OpenAPI schemas | [path] |
| AsyncAPI schemas | [path] |
| Event schemas | [path] |
| Import/export schemas | [path] |
| Dataset schemas | [path] |

---

## 4. Identifier Strategy

| Entity category | Identifier rule |
|---|---|
| Public/external records | [UUIDv7 / ULID / other approved] |
| Internal-only records | [rule] |
| Tenant-local numbering | [rule] |
| External system mirrors | Store source system and source ID |

---

## 5. Migration Strategy

| Topic | Decision |
|---|---|
| Migration tool | [tool] |
| Migration naming | [convention] |
| Rollback policy | [policy] |
| Backfill policy | [policy] |
| Breaking changes | Require ADR and schema evolution log entry |
| Seed/reference data | [policy] |

---

## 6. Data Lifecycle Defaults

| Category | Default behavior |
|---|---|
| Draft data | [policy] |
| Active records | [policy] |
| Archived records | [policy] |
| Soft-deleted records | [policy] |
| Audit/ledger records | [policy] |
| Temporary data | [policy] |
| Files/exports | [policy] |
| AI/analytics datasets | [policy] |

---

## 7. Data Testing Requirements

| Test type | Required? | Notes |
|---|---|---|
| Migration tests | yes | |
| Schema validation tests | yes | |
| Tenancy/scope tests | if scoped | |
| Import/export tests | if applicable | |
| Event idempotency tests | if events exist | |
| Projection rebuild tests | if projections exist | |
| Retention/deletion tests | if lifecycle rules exist | |

---

## 8. Project-Specific Deviations

| Deviation | Reason | Risk | Approval |
|---|---|---|---|
| | | | |
