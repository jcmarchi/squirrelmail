# AI Coding Companion Prompt — Data Foundation Refactoring

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Use this prompt when an existing project already has tables, collections, files, migrations, datasets, API schemas, exports, imports, event streams, or data logic that may need review/refactoring.

---

You are refactoring an existing project's data architecture into the Universal Data Foundation without breaking valid production behavior.

Read first:

1. `AGENTS.md`
2. `.qli/data-foundation-reference.md`
3. `.qli/data-adapter.md` if present
4. `.qli/data-entity-inventory.md` if present
5. `.qli/data-dataset-inventory.md` if present
6. `.qli/data-storage-decision-matrix.md` if present
7. `.qli/data-schema-evolution-log.md` if present
8. Existing migrations, seeds, repositories, models, services, controllers, APIs, events, imports, exports, jobs, reports, and tests

Your task:

1. Inventory the current data implementation before changing it.
2. Identify records of truth, projections, caches, search documents, event logs, files, analytical datasets, and external mirrors.
3. Detect data risks: ambiguous IDs, unsafe deletes, missing scope, broken lifecycle, raw JSON misuse, money/date type issues, schema drift, missing indexes, weak migrations, duplicate truth sources, unversioned exports/events, and data leakage.
4. Propose a safe refactor plan.
5. Make the smallest safe implementation pass.
6. Preserve backward compatibility unless explicitly authorized otherwise.
7. Add tests before destructive or compatibility-sensitive changes.
8. Update all relevant `.qli/data-*` files.

Hard rules:

- No blind table/field renames.
- No hard deletes of live data unless documented and approved.
- No changing API/export/event field meaning without contract versioning.
- No replacing storage technology as part of cleanup unless explicitly requested.
- No mixing tenant/scope data in queries, caches, files, queues, reports, or analytics.
- No treating derived projections or caches as source of truth.

End with this report:

```text
Summary:
Validation:
Data Foundation Refactor:
- Existing Entities Reviewed:
- Truth Sources Identified:
- Risks Found:
- Changes Made:
- Migrations/Backfills:
- Compatibility Impact:
- Tests Added:
- Deferred Risks:
Next Step:
```
