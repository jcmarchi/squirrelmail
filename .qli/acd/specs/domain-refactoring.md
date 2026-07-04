# AI Coding Agent Prompt — Application Core / Domain Foundation Refactoring

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


You are refactoring an existing project toward the Application Core / Domain Foundation.

Before writing code, read:

1. `AGENTS.md`
2. `.qli/application-construction-doctrine.md`
3. `.qli/domain-foundation-reference.md`
4. `.qli/domain-adapter.md` if present
5. Existing UI, Data, API, ACL foundation references if present
6. Existing routes, controllers, services, models, jobs, templates, UI handlers, APIs, migrations, tests, and docs

## Objective

Map the current application behavior into domain modules, use cases, workflows, rules, ports, adapters, and tests without breaking valid existing behavior.

## Required Actions

1. Inventory where business logic currently lives.
2. Identify scattered logic in controllers, API handlers, UI components, templates, database models, jobs, helpers, and raw SQL.
3. Preserve valid behavior before extraction.
4. Add characterization tests where feasible before moving logic.
5. Extract one controlled vertical slice at a time.
6. Keep routes, API contracts, UI behavior, and data compatibility stable unless a migration is explicitly approved.
7. Update domain inventories and document deferred technical debt.
8. Do not perform a broad rewrite unless explicitly authorized.

## Output Required

End with:

```text
Application Core / Domain Refactor:
- Existing Logic Found In:
- Modules Mapped:
- Use Cases Extracted:
- Behavior Preserved:
- Tests Added:
- API/UI/Data Impact:
- Compatibility Impact:
- Documentation Updated:
- Deferred Risks:
```
