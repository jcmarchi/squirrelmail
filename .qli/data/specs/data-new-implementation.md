# AI Coding Companion Prompt — Data Foundation New Implementation

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Use this prompt when a project is new or has only a basic structure and no reliable data foundation yet.

---

You are implementing the Universal Data Foundation for a new project.

Read first:

1. `AGENTS.md`
2. `.qli/data-foundation-reference.md`
3. `.qli/data-adapter.md` if present
4. `.qli/access-control-reference.md` if the project has users, roles, tenants, organizations, accounts, or protected records
5. `.qli/api-foundation-reference.md` if APIs/events/imports/exports are involved
6. `ROADMAP.md`, recent ADRs, and existing code

Your task:

1. Create or update `.qli/data-adapter.md`.
2. Create or update `.qli/data-entity-inventory.md`.
3. Create or update `.qli/data-dataset-inventory.md`.
4. Create or update `.qli/data-storage-decision-matrix.md`.
5. Create or update `.qli/data-lifecycle-matrix.md`.
6. Create or update `.qli/data-schema-evolution-log.md`.
7. Create or update `.qli/data-test-matrix.md`.
8. Implement only the first scoped vertical slice unless explicitly instructed otherwise.

Rules:

- Do not choose a database/storage tool before classifying entities.
- Do not expose internal auto-increment IDs as public identifiers unless a stable external ID also exists.
- Define schema contracts before physical persistence.
- Use standard data types for time, money, decimals, measurements, enums, files, and IDs.
- Model tenancy/scope/ownership even if the first release is single-tenant.
- Define lifecycle/deletion/retention behavior for every record of truth.
- Add migration and validation tests.
- Keep business logic behind ports/repositories/adapters.
- Preserve compatibility with the API and Access Control foundations.

End with this report:

```text
Summary:
Validation:
Data Foundation:
- Maturity Level:
- Entities Classified:
- Datasets Classified:
- Contracts Added/Updated:
- Storage Decisions:
- Migrations:
- Tests Added:
- Deferred Risks:
Next Step:
```
