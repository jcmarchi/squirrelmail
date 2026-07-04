# API Foundation — Buildline Implementation Control

**Buildline version:** 2.0  
**Canonical reference:** `.qli/api/specs/api-foundation-reference.md`  
**Layer:** QLi Foundations / implementation control  
**Scope:** Generic and project-agnostic. Project-specific applicability is decided by `.qli/project/foundation-applicability.yml` through `.qli/binding/` rules.

## 1. Purpose

Controls HTTP/API/interface contracts so product behavior is testable, consistent, and ready for internal or external consumers from the start.

This file is not a replacement for the full foundation reference. It is the operational control used by AI coding agents and human reviewers to determine what must exist upfront, what may be deferred, and what evidence proves completion.

## 2. What This Foundation Controls

- health endpoint
- versioning pattern
- request validation
- response envelope
- error envelope
- pagination/filter conventions
- auth boundary
- contract inventory
- endpoint inventory

## 3. Minimum Upfront Spine

The following items are required early when this foundation is marked `required`, `spine_required`, or `minimum_required` in `.qli/project/foundation-applicability.yml`:

- health/status endpoint exists or is explicitly not applicable
- API route/version convention is documented
- success/error response pattern is defined
- validation failure shape is defined
- auth/ACL boundary is declared for protected routes
- at least one real vertical endpoint exists when API is applicable
- endpoint inventory is updated

If a spine item does not apply, the reason must be recorded in `.qli/project/foundation-applicability.yml` or `.qli/project/deferral-register.md`. Silent omission is not allowed.

## 4. Optional / Advanced Capabilities

The following capabilities are valid but should activate only when the project profile, target level, or slice scope requires them:

- full OpenAPI publication
- webhooks
- AsyncAPI/event contracts
- rate limit headers
- SDK/client generation
- public developer portal

Optional does not mean unimportant. It means the capability is not automatically required for every product at every stage.

## 5. Deferral Rules

- Public API docs may be deferred until there are external consumers.
- Webhooks/events may be deferred until integration use cases exist.
- Contract discipline may not be deferred for endpoints used by UI or integrations.

Every deferral must include reason, risk, activation trigger, review point, and owner/responsible role in `.qli/project/deferral-register.md`.

## 6. Implementation Evidence

A completed slice that touches this foundation should produce evidence such as:

- endpoint inventory
- request/response examples
- validation/error examples
- contract or adapter update
- API tests and smoke command

Evidence belongs in the implementation report and, when durable, in `.qli/project/evidence-log.md` or the relevant inventory/status file.

## 7. Tests and Human Smoke Checks

Minimum validation expectations:

- endpoint returns stable shape
- invalid input returns controlled error
- unauthorized/forbidden paths behave correctly
- UI consumes same contract where applicable

The selected test tier must be proportional to the change. Full regression is required only when the gate triggers it; targeted tests and smoke checks are required for the changed slice.

## 8. Common AI-Agent Failure Modes

Reject or correct implementation reports showing these patterns:

- controller returns ad hoc shapes
- API bypasses ACL
- UI uses private data path while API contract claims coverage
- errors leak internals

## 9. Definition of Done

- The applicable API surface is contract-consistent, validated, protected, tested, and usable by the current UI/integration slice.

The foundation is not "done" because its document exists. It is done only when the applicable product code, inventories, tests, smoke paths, status files, and evidence prove that the foundation has become part of the product.
