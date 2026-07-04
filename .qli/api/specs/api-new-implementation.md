# AI Coding Agent Prompt — API Foundation New Implementation

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Use this prompt when the repository is new or has only basic structure and no mature API foundation.

---

You are implementing the Universal Composable API Foundation for this repository.

Before coding:

1. Read `AGENTS.md`.
2. Read `.qli/api-foundation-reference.md`.
3. Read `.qli/access-control-reference.md` if authentication, authorization, users, tenants, API tokens, service accounts, files, exports, admin routes, or privileged operations are involved.
4. Inspect the current repository stack, routing, service organization, tests, and docs.
5. Do not introduce Node.js or Laravel as the core backend stack unless the project owner explicitly approves an exception. Node-based tooling and standalone packages are allowed only when documented and not used as the backend application core.

Implement the foundation as a minimal but durable vertical slice:

1. Create or update `.qli/api-adapter.md`.
2. Create or update `.qli/api-contract-inventory.md`.
3. Create or update `.qli/api-endpoint-inventory.md`.
4. Create or update `.qli/api-event-inventory.md` if events/queues/webhooks exist or are planned.
5. Create or update `.qli/api-test-matrix.md`.
6. Create initial OpenAPI contract for the current API surface.
7. Create initial AsyncAPI contract only if the current scope includes events, queues, messages, webhooks, or brokered workflows.
8. Define canonical response/error shape, request ID/correlation ID, and validation convention.
9. Establish the route/handler -> use case -> port -> adapter pattern.
10. Implement validation before core logic.
11. Add authorization hook points even if the initial permissions are simple.
12. Add tests for success, validation failure, authorization failure where relevant, and contract conformance.

Do not build an overengineered broker layer if the current product does not need it yet. It is acceptable to start with in-process events or a database-backed queue as long as the port makes future broker replacement possible.

End your response with:

```text
Summary:
- [What changed]

API Foundation:
- Maturity Level: [0-5]
- Contracts: [created/updated]
- Endpoints: [added/changed]
- Events: [added/changed/n/a]
- Ports/Adapters: [added/reused]
- Security: [validation/auth/authz/rate limits]
- Tests: [what ran]
- Inventories Updated: [yes/no]
- Deferred Risks: [known gaps]

Next Step:
- [Single concrete next action]
```
