# Security Foundation — Buildline Implementation Control

**Buildline version:** 2.0  
**Canonical reference:** `.qli/security/specs/security-foundation-reference.md`  
**Layer:** QLi Foundations / implementation control  
**Scope:** Generic and project-agnostic. Project-specific applicability is decided by `.qli/project/foundation-applicability.yml` through `.qli/binding/` rules.

## 1. Purpose

Controls baseline application security so safe defaults exist before public routes, users, files, integrations, or sensitive data expand the attack surface.

This file is not a replacement for the full foundation reference. It is the operational control used by AI coding agents and human reviewers to determine what must exist upfront, what may be deferred, and what evidence proves completion.

## 2. What This Foundation Controls

- surface inventory
- session/cookie posture
- CSRF
- XSS/output encoding
- input validation
- file upload/download controls
- secret handling
- dependency risk
- safe errors
- security exceptions

## 3. Minimum Upfront Spine

The following items are required early when this foundation is marked `required`, `spine_required`, or `minimum_required` in `.qli/project/foundation-applicability.yml`:

- security posture is initialized from operating profile
- public/authenticated/admin/API surfaces are inventoried
- secrets/config handling is declared
- input validation and output encoding rules are selected
- CSRF/session/cookie posture is set when web auth exists
- safe error behavior is defined
- dependency hygiene command or process exists
- security exception register exists

If a spine item does not apply, the reason must be recorded in `.qli/project/foundation-applicability.yml` or `.qli/project/deferral-register.md`. Silent omission is not allowed.

## 4. Optional / Advanced Capabilities

The following capabilities are valid but should activate only when the project profile, target level, or slice scope requires them:

- formal STRIDE threat model
- SAST/DAST automation
- WAF/CDN rules
- advanced rate limiting
- mTLS/service identity
- penetration-test package

Optional does not mean unimportant. It means the capability is not automatically required for every product at every stage.

## 5. Deferral Rules

- Security baseline may not be deferred for public/authenticated software.
- Threat modeling depth may scale by risk and target level.
- Security exceptions must expire or have review triggers.

Every deferral must include reason, risk, activation trigger, review point, and owner/responsible role in `.qli/project/deferral-register.md`.

## 6. Implementation Evidence

A completed slice that touches this foundation should produce evidence such as:

- security posture update
- surface inventory update
- secrets inventory update
- validation/error examples
- dependency check result
- security test matrix update

Evidence belongs in the implementation report and, when durable, in `.qli/project/evidence-log.md` or the relevant inventory/status file.

## 7. Tests and Human Smoke Checks

Minimum validation expectations:

- CSRF on state-changing web forms where applicable
- safe error response
- secret not committed/logged
- upload path blocked or controlled
- dependency command recorded

The selected test tier must be proportional to the change. Full regression is required only when the gate triggers it; targeted tests and smoke checks are required for the changed slice.

## 8. Common AI-Agent Failure Modes

Reject or correct implementation reports showing these patterns:

- security treated as later hardening
- dev/debug routes public
- raw user input rendered
- secrets in docs/code
- uploads accepted without policy

## 9. Definition of Done

- The implemented slice has an explicit security posture, controlled public surface, safe input/output/error/secret handling, and tracked exceptions.

The foundation is not "done" because its document exists. It is done only when the applicable product code, inventories, tests, smoke paths, status files, and evidence prove that the foundation has become part of the product.
