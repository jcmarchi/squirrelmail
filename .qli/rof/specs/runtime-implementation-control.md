# Runtime Operations Foundation — Buildline Implementation Control

**Buildline version:** 2.0  
**Canonical reference:** `.qli/rof/specs/runtime-foundation-reference.md`  
**Layer:** QLi Foundations / implementation control  
**Scope:** Generic and project-agnostic. Project-specific applicability is decided by `.qli/project/foundation-applicability.yml` through `.qli/binding/` rules.

## 1. Purpose

Controls application behavior after code starts: requests, sessions, cache, jobs, queues, schedules, locks, retries, failure policy, and operational lifecycle.

This file is not a replacement for the full foundation reference. It is the operational control used by AI coding agents and human reviewers to determine what must exist upfront, what may be deferred, and what evidence proves completion.

## 2. What This Foundation Controls

- runtime mode
- process inventory
- request lifecycle
- sessions/cache
- jobs/queues
- schedules
- locks/idempotency
- failure policy
- worker startup/shutdown

## 3. Minimum Upfront Spine

The following items are required early when this foundation is marked `required`, `spine_required`, or `minimum_required` in `.qli/project/foundation-applicability.yml`:

- runtime model is declared: request-only, request+jobs, event-driven, scheduled, or hybrid
- session/cache choice is declared when used
- failure policy exists for current slice
- idempotency/retry expectations are declared for side effects
- any worker/scheduler is inventoried before implementation
- runtime startup command is known

If a spine item does not apply, the reason must be recorded in `.qli/project/foundation-applicability.yml` or `.qli/project/deferral-register.md`. Silent omission is not allowed.

## 4. Optional / Advanced Capabilities

The following capabilities are valid but should activate only when the project profile, target level, or slice scope requires them:

- queue dashboard
- dead-letter handling
- distributed locks
- job progress UI
- event consumer registry
- advanced retry/backoff policies

Optional does not mean unimportant. It means the capability is not automatically required for every product at every stage.

## 5. Deferral Rules

- Queues/schedulers may be deferred until async or recurring work exists.
- Failure policy may not be deferred for side-effecting actions.
- Runtime assumptions may not be hidden in deployment scripts only.

Every deferral must include reason, risk, activation trigger, review point, and owner/responsible role in `.qli/project/deferral-register.md`.

## 6. Implementation Evidence

A completed slice that touches this foundation should produce evidence such as:

- runtime adapter update
- job/schedule/cache/session inventory update
- failure policy entry
- tests/smoke checks for side effects or job execution

Evidence belongs in the implementation report and, when durable, in `.qli/project/evidence-log.md` or the relevant inventory/status file.

## 7. Tests and Human Smoke Checks

Minimum validation expectations:

- request path works
- side effect is not duplicated unexpectedly
- job/schedule command documented when applicable
- failure path is controlled

The selected test tier must be proportional to the change. Full regression is required only when the gate triggers it; targeted tests and smoke checks are required for the changed slice.

## 8. Common AI-Agent Failure Modes

Reject or correct implementation reports showing these patterns:

- cron/queue added without inventory
- business logic hidden in scripts
- no retry/idempotency decision
- runtime dependency undocumented

## 9. Definition of Done

- Runtime behavior for the slice is declared, operationally startable, failure-aware, and aligned with delivery/observability/testing.

The foundation is not "done" because its document exists. It is done only when the applicable product code, inventories, tests, smoke paths, status files, and evidence prove that the foundation has become part of the product.
