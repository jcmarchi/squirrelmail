# API Foundation Review Checklist

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/api-review-checklist.md`  
**Purpose:** Acceptance checklist for API, event, integration, and refactoring work.

## Contract

- [ ] OpenAPI contract updated for HTTP API changes.
- [ ] AsyncAPI contract updated for event/message changes where applicable.
- [ ] Schemas are versioned and reusable.
- [ ] Examples exist for success and failure cases.
- [ ] Compatibility risk is classified.
- [ ] Deprecated behavior is documented.

## Architecture

- [ ] Business logic is not trapped inside controllers, handlers, or consumers.
- [ ] Use cases/application services orchestrate work.
- [ ] Ports isolate the core from infrastructure.
- [ ] Adapters contain technology-specific code.
- [ ] Node.js and Laravel are not introduced as core backend technologies unless explicitly approved.

## HTTP API

- [ ] Endpoint names and methods are stable and predictable.
- [ ] Status codes follow project convention.
- [ ] Error shape is canonical.
- [ ] Pagination/filtering/sorting are bounded and documented.
- [ ] Idempotency is implemented where needed.
- [ ] Rate limits are applied where needed.

## Events

- [ ] Events/commands have stable names and versions.
- [ ] Message envelope includes required metadata.
- [ ] Consumers are idempotent.
- [ ] Retry and dead-letter behavior is defined.
- [ ] Outbox/inbox pattern is used where consistency requires it.
- [ ] Sensitive data is not leaked through events.

## Security

- [ ] External inputs are validated before core logic.
- [ ] Protected operations authenticate and authorize server-side.
- [ ] Tenant/scope containment is enforced where relevant.
- [ ] Webhooks are signed/verified where possible.
- [ ] Secrets and tokens are not logged.
- [ ] Gateway/policy rules do not replace service-side checks.

## Observability

- [ ] request_id or correlation_id exists.
- [ ] API and event failures are logged safely.
- [ ] Metrics cover latency, status, errors, queue depth, and dead letters where applicable.
- [ ] Audit events exist for privileged/destructive/security-sensitive operations.

## Documentation and Inventory

- [ ] `api-adapter.md` is current.
- [ ] `api-contract-inventory.md` is current.
- [ ] `api-endpoint-inventory.md` is current.
- [ ] `api-event-inventory.md` is current if events exist.
- [ ] `api-test-matrix.md` is current.

## Tests

- [ ] Positive tests added.
- [ ] Negative tests added.
- [ ] Contract/schema tests added.
- [ ] Authorization tests added where applicable.
- [ ] Idempotency/retry/dead-letter tests added where applicable.
- [ ] Refactor compatibility tests added where applicable.
