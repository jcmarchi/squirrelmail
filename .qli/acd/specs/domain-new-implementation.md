# AI Coding Agent Prompt — Application Core / Domain Foundation for a New Project

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


You are implementing the Application Core / Domain Foundation for a new project.

Before writing code, read:

1. `AGENTS.md`
2. `.qli/application-construction-doctrine.md`
3. `.qli/domain-foundation-reference.md`
4. `.qli/domain-adapter.md` if present
5. Existing UI, Data, API, ACL foundation references if present
6. `ROADMAP.md` and recent ADRs if present

## Objective

Create the project’s Application Core structure so product features can be delivered as vertical slices across Core + Data + API + Test + UI, with ACL/Security where applicable.

## Required Actions

1. Identify initial domain modules from the product feature map.
2. Create or update `.qli/domain-adapter.md`.
3. Create or update inventories:
   - `.qli/domain-module-inventory.md`
   - `.qli/domain-usecase-inventory.md`
   - `.qli/domain-workflow-inventory.md`
   - `.qli/domain-event-inventory.md`
   - `.qli/domain-rule-inventory.md`
   - `.qli/domain-test-matrix.md`
4. Establish folder conventions for domain modules, use cases, commands, queries, ports, adapters, events, and tests.
5. Implement only the minimal core scaffolding required for the first reviewable vertical slice.
6. Do not build invisible backend-only architecture without a UI/API/test path when the feature is user-facing.
7. Preserve technology agnosticism: the core must not depend directly on HTTP, UI, database, queue broker, cloud SDK, or vendor-specific APIs.

## Output Required

End with:

```text
Application Core / Domain Foundation:
- Modules Added:
- Use Cases Added:
- Workflows Added:
- Events Added:
- Ports/Adapters Added:
- Vertical Slice Readiness:
- Tests Added:
- Documentation Updated:
- Deferred Risks:
```
