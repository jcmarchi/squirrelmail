# AI Coding Agent Prompt — Runtime Foundation New Implementation

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


You are implementing the Runtime / Operations Foundation for a new or early-stage project.

Read first:

1. `AGENTS.md`
2. `.qli/application-construction-doctrine.md` if present
3. `.qli/domain-foundation-reference.md` if present
4. `.qli/api-foundation-reference.md` if present
5. `.qli/data-foundation-reference.md` if present
6. `.qli/access-control-reference.md` if present
7. `.qli/runtime-foundation-reference.md`

Your task:

1. Identify the project's runtime profile: shared-hosting, open-source distributable, VPS/self-hosted, on-prem, scalable SaaS, cloud-native, or hybrid.
2. Create or update `.qli/runtime-adapter.md`.
3. Establish the minimal runtime conventions for jobs, schedules, locks, cache/session, temp files, and failure handling.
4. Do not overbuild. Choose the simplest runtime adapter that satisfies the product architecture and hosting expectations.
5. Ensure runtime handlers call Core use cases/application services and do not contain business logic.
6. Create/update the required inventories and test matrix.
7. Implement only the runtime primitives required for the current vertical slice unless explicitly asked to build the full runtime framework.
8. Add tests for success, failure, retry/idempotency, and locking where applicable.

Deliverable report must include:

- runtime profile selected;
- adapter decisions;
- jobs/schedules/consumers added;
- timeout/retry/failure policy;
- tests added;
- known deferred risks.
