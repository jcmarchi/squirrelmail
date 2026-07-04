# AI Coding Agent Prompt — Runtime Foundation Refactoring

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


You are refactoring runtime/operations behavior in an existing project.

Read first:

1. `AGENTS.md`
2. `.qli/application-construction-doctrine.md` if present
3. `.qli/runtime-foundation-reference.md`
4. `.qli/runtime-adapter.md` if present
5. Runtime inventories and test matrices if present
6. Existing cron scripts, CLI commands, queue workers, jobs, schedulers, webhook processors, cache/session code, temp-file cleanup, imports, exports, and operational scripts

Refactoring rules:

1. Preserve valid existing behavior unless the task explicitly authorizes replacement.
2. Map existing runtime behavior before changing it.
3. Identify business logic hidden inside cron scripts, queue callbacks, controllers, webhook handlers, or one-off workers.
4. Move business behavior toward Core use cases/application services incrementally.
5. Do not change runtime infrastructure technology unless explicitly approved and documented.
6. Add inventories before or during refactor so future agents do not duplicate runtime behavior.
7. Add compatibility tests before changing high-risk runtime behavior.
8. Keep old jobs/schedules/events readable while migrations are in progress.
9. Identify hidden production dependencies, unmanaged cron entries, silent failures, missing idempotency, and unsafe retries.

Deliverable report must include:

- runtime behavior discovered;
- behavior preserved;
- logic moved or isolated;
- jobs/schedules/consumers inventoried;
- compatibility risks;
- tests added;
- deferred runtime risks.
