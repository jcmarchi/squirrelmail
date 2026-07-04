# Data Review Checklist

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Location:** `.qli/data-review-checklist.md`  
**Purpose:** Use this checklist before accepting data-related work.

## Required Review Items

- [ ] Entity or dataset is classified.
- [ ] Source of truth is identified.
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

## Critical Blockers

- [ ] Unclassified record of truth.
- [ ] Missing migration for schema change.
- [ ] Hard delete of sensitive/regulated/auditable data without policy.
- [ ] Exposed internal IDs without approved external ID strategy.
- [ ] Money stored in floating point.
- [ ] Tenant/scope data mixed in cache, file paths, queues, reports, or exports.
- [ ] Cache, search index, projection, or analytical table treated as source of truth.
- [ ] Event consumer not idempotent.
- [ ] Breaking API/export/event schema change without versioning.
