# Runtime Review Checklist

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/runtime-review-checklist.md`

Use this checklist before accepting runtime or operations work.

## Architecture

- [ ] Runtime mode is identified: request, API, CLI, job, schedule, event, webhook, worker, batch, or maintenance.
- [ ] Business logic remains in Core/use cases.
- [ ] Runtime code is adapter/orchestration code, not domain logic.
- [ ] Technology choices match the project's runtime profile.
- [ ] Shared-hosting/open-source/self-hosted/scalable constraints are respected.

## Safety

- [ ] Timeout policy exists.
- [ ] Retry policy exists where applicable.
- [ ] Non-retryable failures are handled safely.
- [ ] Dead-letter/manual-review behavior exists where needed.
- [ ] Idempotency/deduplication is defined for retries, webhooks, events, imports, exports, and external side effects.
- [ ] Lock/concurrency policy exists where duplicate execution is unsafe.

## State and Observability

- [ ] Runtime state is recorded where work is asynchronous or long-running.
- [ ] Progress/status is exposed to UI/API where needed.
- [ ] Logs include request/job/trace/correlation IDs.
- [ ] Privileged runtime actions are audited.
- [ ] Sensitive data is not logged or stored in unsafe runtime locations.

## Documentation

- [ ] Runtime adapter updated.
- [ ] Job inventory updated.
- [ ] Schedule inventory updated.
- [ ] Event consumer inventory updated.
- [ ] Cache/session inventory updated.
- [ ] Failure policy matrix updated.
- [ ] Test matrix updated.

## Tests

- [ ] Success path tested.
- [ ] Failure path tested.
- [ ] Retry/idempotency tested where applicable.
- [ ] Overlap/lock behavior tested where applicable.
- [ ] Cache/session scope tested where applicable.
- [ ] Outbox/inbox behavior tested where applicable.
