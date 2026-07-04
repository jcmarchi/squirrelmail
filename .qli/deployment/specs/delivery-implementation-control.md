# Delivery / DevOps / Deployment Foundation — Buildline Implementation Control

**Buildline version:** 2.0  
**Canonical reference:** `.qli/deployment/specs/delivery-foundation-reference.md`  
**Layer:** QLi Foundations / implementation control  
**Scope:** Generic and project-agnostic. Project-specific applicability is decided by `.qli/project/foundation-applicability.yml` through `.qli/binding/` rules.

## 1. Purpose

Controls how the application is configured, started, released, migrated, rolled back, backed up, and promoted across environments according to the operating profile.

This file is not a replacement for the full foundation reference. It is the operational control used by AI coding agents and human reviewers to determine what must exist upfront, what may be deferred, and what evidence proves completion.

## 2. What This Foundation Controls

- environment inventory
- config/secrets
- build/start commands
- deployment target matrix
- migration/rollback
- backup/restore
- release inventory
- smoke after deploy

## 3. Minimum Upfront Spine

The following items are required early when this foundation is marked `required`, `spine_required`, or `minimum_required` in `.qli/project/foundation-applicability.yml`:

- operating profile exists
- environment list exists
- setup/start command exists or is planned
- config/secrets inventory exists
- deployment target is declared
- migration/rollback expectation exists when database changes exist
- post-start smoke path is documented

If a spine item does not apply, the reason must be recorded in `.qli/project/foundation-applicability.yml` or `.qli/project/deferral-register.md`. Silent omission is not allowed.

## 4. Optional / Advanced Capabilities

The following capabilities are valid but should activate only when the project profile, target level, or slice scope requires them:

- CI/CD pipeline
- container registry
- blue/green deploy
- automated rollback
- backup automation
- multi-environment promotion workflow
- infrastructure-as-code

Optional does not mean unimportant. It means the capability is not automatically required for every product at every stage.

## 5. Deferral Rules

- CI/CD may be deferred for early local-only projects.
- Backup/restore cannot be deferred for production data.
- Migration rollback expectation cannot be deferred when schema changes are introduced.

Every deferral must include reason, risk, activation trigger, review point, and owner/responsible role in `.qli/project/deferral-register.md`.

## 6. Implementation Evidence

A completed slice that touches this foundation should produce evidence such as:

- environment inventory update
- config/secrets inventory update
- start/deploy/smoke command output
- migration/rollback note
- release inventory update

Evidence belongs in the implementation report and, when durable, in `.qli/project/evidence-log.md` or the relevant inventory/status file.

## 7. Tests and Human Smoke Checks

Minimum validation expectations:

- fresh setup/start works or blocker is documented
- required env variables are listed
- dev/prod unsafe defaults are blocked
- schema changes have migration strategy

The selected test tier must be proportional to the change. Full regression is required only when the gate triggers it; targeted tests and smoke checks are required for the changed slice.

## 8. Common AI-Agent Failure Modes

Reject or correct implementation reports showing these patterns:

- deployment model contradicts product profile
- secrets hardcoded
- manual steps undocumented
- database migration without rollback/backup thought

## 9. Definition of Done

- The slice can be configured, started, and reviewed in the intended environment without hidden deployment assumptions.

The foundation is not "done" because its document exists. It is done only when the applicable product code, inventories, tests, smoke paths, status files, and evidence prove that the foundation has become part of the product.
