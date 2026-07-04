# QLi DevBox Foundation — Buildline Implementation Control

**Buildline version:** 2.0  
**Canonical reference:** `.qli/devbox/README.md`  
**Layer:** QLi Foundations / implementation control  
**Scope:** Generic and project-agnostic. Project-specific applicability is decided by `.qli/project/foundation-applicability.yml` through `.qli/binding/` rules.

## 1. Purpose

Controls how projects are registered, routed, ported, started, audited, and demoed on the QLi DevBox without making product code environment-specific.

This file is not a replacement for the full foundation reference. It is the operational control used by AI coding agents and human reviewers to determine what must exist upfront, what may be deferred, and what evidence proves completion.

## 2. What This Foundation Controls

- project registry
- port block assignment
- Caddy/reverse-proxy route
- health/smoke endpoint
- start/stop scripts
- local vs DevBox runtime boundary
- route/access audit

## 3. Minimum Upfront Spine

The following items are required early when this foundation is marked `required`, `spine_required`, or `minimum_required` in `.qli/project/foundation-applicability.yml`:

- project slug/domain/route strategy declared
- port block assigned or intentionally not applicable
- DevBox runtime path declared
- health/smoke URL declared
- start/stop/status commands planned or implemented
- reverse-proxy exposure decision documented
- local fallback runtime documented where applicable

If a spine item does not apply, the reason must be recorded in `.qli/project/foundation-applicability.yml` or `.qli/project/deferral-register.md`. Silent omission is not allowed.

## 4. Optional / Advanced Capabilities

The following capabilities are valid but should activate only when the project profile, target level, or slice scope requires them:

- automatic registry generation
- multi-service project templates
- TLS/internal route automation
- full port conflict audit
- DevBox deployment report
- WireGuard-only access model

Optional does not mean unimportant. It means the capability is not automatically required for every product at every stage.

## 5. Deferral Rules

- DevBox adoption may be deferred only when the project will not be run or demoed on the DevBox.
- Port assignment may not be deferred once a service is exposed.
- Route/access audit may not be skipped for externally reachable demos.

Every deferral must include reason, risk, activation trigger, review point, and owner/responsible role in `.qli/project/deferral-register.md`.

## 6. Implementation Evidence

A completed slice that touches this foundation should produce evidence such as:

- registry entry or declared non-applicability
- port block and service mapping
- route/health/smoke check results
- start/status command output
- access policy note

Evidence belongs in the implementation report and, when durable, in `.qli/project/evidence-log.md` or the relevant inventory/status file.

## 7. Tests and Human Smoke Checks

Minimum validation expectations:

- assigned ports are not conflicting
- HTTP/HTTPS route resolves where applicable
- health endpoint returns expected status
- private/admin routes match access policy

The selected test tier must be proportional to the change. Full regression is required only when the gate triggers it; targeted tests and smoke checks are required for the changed slice.

## 8. Common AI-Agent Failure Modes

Reject or correct implementation reports showing these patterns:

- random ports
- Caddy route not registered
- DevBox-specific assumptions in application code
- public exposure without access review

## 9. Definition of Done

- The project can be reliably started, routed, audited, and demoed on DevBox when DevBox is part of the operating profile.

The foundation is not "done" because its document exists. It is done only when the applicable product code, inventories, tests, smoke paths, status files, and evidence prove that the foundation has become part of the product.
