# Data Test Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Location:** `.qli/data-test-matrix.md`  
**Purpose:** Track required tests for data model, migration, lifecycle, import/export, event, projection, and dataset work.

| Area | Entity/Dataset | Positive Tests | Negative Tests | Migration Tests | Lifecycle Tests | Status | Notes |
|---|---|---|---|---|---|---|---|
| Schema validation | [entity] | valid payload accepted | invalid payload rejected | n/a | n/a | planned | |
| Migration | [entity] | migration applies | invalid old data handled | rollback/backfill | n/a | planned | |
| Tenancy/scope | [entity] | scoped access works | cross-scope denied | n/a | n/a | planned | |
| Import/export | [dataset] | valid file accepted/exported | malformed rows fail safely | n/a | retention if applicable | planned | |
| Events/projections | [event/projection] | consumer handles valid event | duplicate/out-of-order safe | rebuild path | retention | planned | |

## Minimum Test Categories

- Schema validation.
- Migration safety.
- Old-record readability.
- Identifier uniqueness.
- Tenancy/scope containment.
- Lifecycle/deletion/retention.
- Import/export validation.
- Event idempotency.
- Projection rebuild.
- Sensitive-data leakage prevention.
