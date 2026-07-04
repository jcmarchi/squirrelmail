# DATA Foundation — Buildline Implementation Control

**Buildline version:** 2.0  
**Canonical reference:** `.qli/data/specs/data-foundation-reference.md`  
**Layer:** QLi Foundations / implementation control  
**Scope:** Generic and project-agnostic. Project-specific applicability is decided by `.qli/project/foundation-applicability.yml` through `.qli/binding/` rules.

## 1. Purpose

Controls records of truth, storage boundaries, schema evolution, lifecycle, tenancy, fixtures, and data integrity across product slices.

This file is not a replacement for the full foundation reference. It is the operational control used by AI coding agents and human reviewers to determine what must exist upfront, what may be deferred, and what evidence proves completion.

## 2. What This Foundation Controls

- entity inventory
- record-of-truth decisions
- schema/migration discipline
- seed/demo data
- lifecycle and retention
- data classification
- tenancy boundaries
- query/persistence adapters

## 3. Minimum Upfront Spine

The following items are required early when this foundation is marked `required`, `spine_required`, or `minimum_required` in `.qli/project/foundation-applicability.yml`:

- primary entities for the first slice are named
- record-of-truth and derived/projection/cache distinctions are declared
- migration or schema-change method is known
- seed/demo data strategy exists for UI/human review
- data sensitivity and tenancy classification are captured
- basic validation and constraints are implemented where data is accepted
- rollback/repair expectation is documented for schema changes

If a spine item does not apply, the reason must be recorded in `.qli/project/foundation-applicability.yml` or `.qli/project/deferral-register.md`. Silent omission is not allowed.

## 4. Optional / Advanced Capabilities

The following capabilities are valid but should activate only when the project profile, target level, or slice scope requires them:

- data warehouse/analytics projections
- event-sourced histories
- multi-region data strategy
- advanced retention automation
- data import/export pipelines
- field-level encryption beyond baseline

Optional does not mean unimportant. It means the capability is not automatically required for every product at every stage.

## 5. Deferral Rules

- A data artifact may be deferred only if no current slice stores or reads that data.
- Demo/seed data may not be deferred when UI review depends on populated screens.
- Tenancy decisions may not be deferred in multi-tenant products.

Every deferral must include reason, risk, activation trigger, review point, and owner/responsible role in `.qli/project/deferral-register.md`.

## 6. Implementation Evidence

A completed slice that touches this foundation should produce evidence such as:

- entity/storage inventory update
- migration/schema file or documented non-migration reason
- seed/demo data update
- data classification entry
- tests for constraints/lifecycle where applicable

Evidence belongs in the implementation report and, when durable, in `.qli/project/evidence-log.md` or the relevant inventory/status file.

## 7. Tests and Human Smoke Checks

Minimum validation expectations:

- migrations run/revert or have explicit constraint
- UI/API uses the intended source of truth
- fixtures support smoke review
- sensitive data is not logged or seeded unsafely

The selected test tier must be proportional to the change. Full regression is required only when the gate triggers it; targeted tests and smoke checks are required for the changed slice.

## 8. Common AI-Agent Failure Modes

Reject or correct implementation reports showing these patterns:

- schema changes without inventory
- mock-only UI with no data path
- tenant_id/ownership added inconsistently
- temporary data becomes permanent architecture

## 9. Definition of Done

- The slice data is classified, persisted or intentionally not persisted, migratable, reviewable with representative data, and aligned with API/UI/ACL expectations.

The foundation is not "done" because its document exists. It is done only when the applicable product code, inventories, tests, smoke paths, status files, and evidence prove that the foundation has become part of the product.
