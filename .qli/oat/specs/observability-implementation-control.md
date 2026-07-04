# Observability / Audit / Telemetry Foundation — Buildline Implementation Control

**Buildline version:** 2.0  
**Canonical reference:** `.qli/oat/specs/observability-foundation-reference.md`  
**Layer:** QLi Foundations / implementation control  
**Scope:** Generic and project-agnostic. Project-specific applicability is decided by `.qli/project/foundation-applicability.yml` through `.qli/binding/` rules.

## 1. Purpose

Controls what the application records about behavior, failures, security-sensitive actions, and operational health without leaking sensitive information.

This file is not a replacement for the full foundation reference. It is the operational control used by AI coding agents and human reviewers to determine what must exist upfront, what may be deferred, and what evidence proves completion.

## 2. What This Foundation Controls

- structured logs
- audit events
- metrics
- traces/correlation
- health checks
- error events
- privacy-safe telemetry
- support diagnostics

## 3. Minimum Upfront Spine

The following items are required early when this foundation is marked `required`, `spine_required`, or `minimum_required` in `.qli/project/foundation-applicability.yml`:

- logging/error policy exists
- health check exists where deployable runtime exists
- audit-event classification exists for sensitive/admin/security actions
- request/correlation identifier strategy is declared when applicable
- privacy safety rule prevents sensitive logging
- minimum operational visibility exists for smoke/demo environments

If a spine item does not apply, the reason must be recorded in `.qli/project/foundation-applicability.yml` or `.qli/project/deferral-register.md`. Silent omission is not allowed.

## 4. Optional / Advanced Capabilities

The following capabilities are valid but should activate only when the project profile, target level, or slice scope requires them:

- distributed tracing
- metrics dashboard
- alert runbooks
- support diagnostic UI
- business analytics feed
- central log aggregation

Optional does not mean unimportant. It means the capability is not automatically required for every product at every stage.

## 5. Deferral Rules

- Distributed tracing may be deferred for single-process deployments.
- Audit events may not be deferred for security/business-sensitive admin actions.
- Privacy-safe logging may not be deferred.

Every deferral must include reason, risk, activation trigger, review point, and owner/responsible role in `.qli/project/deferral-register.md`.

## 6. Implementation Evidence

A completed slice that touches this foundation should produce evidence such as:

- log/audit/metric inventory update
- health endpoint/result
- error handling evidence
- privacy-safety matrix update
- smoke check showing observable failure/success signal

Evidence belongs in the implementation report and, when durable, in `.qli/project/evidence-log.md` or the relevant inventory/status file.

## 7. Tests and Human Smoke Checks

Minimum validation expectations:

- health route returns expected status
- errors logged safely
- admin/security action emits audit event where applicable
- sensitive values are not logged

The selected test tier must be proportional to the change. Full regression is required only when the gate triggers it; targeted tests and smoke checks are required for the changed slice.

## 8. Common AI-Agent Failure Modes

Reject or correct implementation reports showing these patterns:

- logs contain secrets/PII
- audit confused with debug logs
- no way to diagnose demo failure
- observability added as product logic

## 9. Definition of Done

- The slice emits the minimum safe signals needed to operate, audit, debug, and review it without leaking protected data.

The foundation is not "done" because its document exists. It is done only when the applicable product code, inventories, tests, smoke paths, status files, and evidence prove that the foundation has become part of the product.
