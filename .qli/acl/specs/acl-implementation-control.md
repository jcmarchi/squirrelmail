# Access Control Foundation — Buildline Implementation Control

**Buildline version:** 2.0  
**Canonical reference:** `.qli/acl/specs/access-control-reference.md`  
**Layer:** QLi Foundations / implementation control  
**Scope:** Generic and project-agnostic. Project-specific applicability is decided by `.qli/project/foundation-applicability.yml` through `.qli/binding/` rules.

## 1. Purpose

Controls who may perform actions or see data so authorization is centralized, testable, and present before protected features accumulate debt.

This file is not a replacement for the full foundation reference. It is the operational control used by AI coding agents and human reviewers to determine what must exist upfront, what may be deferred, and what evidence proves completion.

## 2. What This Foundation Controls

- actor model
- role/capability registry
- route/action classification
- policy interface
- tenant/ownership checks
- positive/negative tests
- admin impersonation boundaries when applicable

## 3. Minimum Upfront Spine

The following items are required early when this foundation is marked `required`, `spine_required`, or `minimum_required` in `.qli/project/foundation-applicability.yml`:

- actor types are named
- protected routes/actions are classified
- minimum roles/capabilities are seeded or declared
- policy/check mechanism exists
- deny-by-default rule is documented
- positive and negative tests exist for the first protected slice
- UI hides/disables affordances without replacing server-side checks

If a spine item does not apply, the reason must be recorded in `.qli/project/foundation-applicability.yml` or `.qli/project/deferral-register.md`. Silent omission is not allowed.

## 4. Optional / Advanced Capabilities

The following capabilities are valid but should activate only when the project profile, target level, or slice scope requires them:

- custom role builder
- field-level permissions
- delegated administration
- approval workflows
- impersonation/session shadowing
- policy simulation UI

Optional does not mean unimportant. It means the capability is not automatically required for every product at every stage.

## 5. Deferral Rules

- ACL may be marked not applicable only for applications with no users, protected data, admin surfaces, tenant boundaries, billing, files, integrations, or public exposure.
- Field-level ACL may be deferred until field variance exists.
- Server-side authorization may not be deferred for protected actions.

Every deferral must include reason, risk, activation trigger, review point, and owner/responsible role in `.qli/project/deferral-register.md`.

## 6. Implementation Evidence

A completed slice that touches this foundation should produce evidence such as:

- permission inventory
- route/action classification
- policy file/check location
- seed role/capability data
- positive and negative test results
- UI/route smoke path showing access denied where expected

Evidence belongs in the implementation report and, when durable, in `.qli/project/evidence-log.md` or the relevant inventory/status file.

## 7. Tests and Human Smoke Checks

Minimum validation expectations:

- unauthenticated path
- unauthorized path
- authorized path
- cross-tenant/ownership denial where applicable
- direct API access denial

The selected test tier must be proportional to the change. Full regression is required only when the gate triggers it; targeted tests and smoke checks are required for the changed slice.

## 8. Common AI-Agent Failure Modes

Reject or correct implementation reports showing these patterns:

- frontend-only authorization
- role strings scattered in controllers/templates
- super-admin assumptions in product code
- no negative tests
- tenant leakage

## 9. Definition of Done

- Protected behavior has a documented actor/capability model, centralized enforcement, deny paths, tests, and UI/API evidence.

The foundation is not "done" because its document exists. It is done only when the applicable product code, inventories, tests, smoke paths, status files, and evidence prove that the foundation has become part of the product.
