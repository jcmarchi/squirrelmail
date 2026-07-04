# AI Coding Agent Prompt — API Foundation Existing Project Review and Refactoring

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Use this prompt when the repository already has endpoints, controllers, handlers, services, events, jobs, webhooks, queues, integrations, or API consumers.

---

You are reviewing and refactoring the existing API surface into the Universal Composable API Foundation without breaking working behavior unnecessarily.

Before coding:

1. Read `AGENTS.md`.
2. Read `.qli/api-foundation-reference.md`.
3. Read `.qli/api-adapter.md` if present.
4. Read `.qli/api-contract-inventory.md`, `.qli/api-endpoint-inventory.md`, `.qli/api-event-inventory.md`, and `.qli/api-test-matrix.md` if present.
5. Read `.qli/access-control-reference.md` if authorization, users, roles, tenants, API tokens, service accounts, admin routes, files, exports, or privileged actions are involved.
6. Inspect existing routes, controllers, handlers, middleware, request validation, response shapes, schemas, events, jobs, queues, webhooks, contracts, tests, and consumers.
7. Do not introduce Node.js or Laravel as the core backend stack unless there is explicit project approval. Existing use must be documented before any migration recommendation.

Review first. Do not rewrite first.

Deliver a short review before implementation:

- Current API patterns found.
- Existing contracts found or missing.
- Endpoint inventory gaps.
- Event/queue/webhook inventory gaps.
- Business logic trapped in controllers/handlers/consumers.
- Validation gaps.
- Authorization/scope gaps.
- Error-shape inconsistency.
- Compatibility risks.
- Recommended first vertical refactor slice.

Then implement only the approved or clearly scoped slice:

1. Preserve current behavior unless the change fixes a documented security defect or the task explicitly authorizes migration.
2. Add contract coverage for existing behavior before changing behavior where practical.
3. Create compatibility aliases/adapters if consumers depend on old behavior.
4. Move business logic toward use cases and ports without mixing unrelated refactors.
5. Add or update endpoint/event inventories.
6. Add tests for old behavior, new behavior, validation failures, auth failures, and compatibility.
7. Document any intentional breaking change.

End your response with:

```text
Summary:
- [What changed]

API Foundation:
- Maturity Level Before: [0-5]
- Maturity Level After: [0-5]
- Existing Behavior Preserved: [yes/no/details]
- Contracts Updated: [yes/no]
- Endpoints Classified: [yes/no]
- Events Classified: [yes/no/n/a]
- Ports/Adapters Added: [yes/no]
- Security Issues Fixed: [list]
- Tests Added: [list]
- Inventories Updated: [yes/no]
- Deferred Risks: [known gaps]

Next Step:
- [Single concrete next action]
```
