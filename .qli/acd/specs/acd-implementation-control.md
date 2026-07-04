# Application Construction Doctrine — Buildline Implementation Control

**Buildline version:** 2.0  
**Canonical reference:** `.qli/acd/specs/application-construction-doctrine.md`  
**Layer:** QLi Foundations / implementation control  
**Scope:** Generic and project-agnostic. Project-specific applicability is decided by `.qli/project/foundation-applicability.yml` through `.qli/binding/` rules.

## 1. Purpose

Controls how the product moves from idea to architecture to code so AI-assisted work produces coherent applications instead of disconnected implementation fragments.

This file is not a replacement for the full foundation reference. It is the operational control used by AI coding agents and human reviewers to determine what must exist upfront, what may be deferred, and what evidence proves completion.

## 2. What This Foundation Controls

- product-to-architecture sequence
- vertical-slice definition
- Foundation Spine enforcement
- new-project startup discipline
- existing-project adoption discipline
- layer ownership boundaries
- AI-agent work reporting

## 3. Minimum Upfront Spine

The following items are required early when this foundation is marked `required`, `spine_required`, or `minimum_required` in `.qli/project/foundation-applicability.yml`:

- project manifest and operating profile exist
- foundation target and applicability matrix exist
- initial feature map and slice candidates are named
- core/data/api/ui/acl/security/testing applicability is decided
- first reviewable slice is selected
- roadmap/development notes can receive implementation evidence

If a spine item does not apply, the reason must be recorded in `.qli/project/foundation-applicability.yml` or `.qli/project/deferral-register.md`. Silent omission is not allowed.

## 4. Optional / Advanced Capabilities

The following capabilities are valid but should activate only when the project profile, target level, or slice scope requires them:

- domain-event inventory for event-rich systems
- formal module inventory for large systems
- complex workflow map for multi-actor products
- advanced domain service decomposition

Optional does not mean unimportant. It means the capability is not automatically required for every product at every stage.

## 5. Deferral Rules

- A domain artifact may be deferred only when the project does not yet contain that behavior, actor, workflow, or lifecycle rule.
- A backend-only slice cannot be accepted as complete when UI/API/human review surfaces are applicable.

Every deferral must include reason, risk, activation trigger, review point, and owner/responsible role in `.qli/project/deferral-register.md`.

## 6. Implementation Evidence

A completed slice that touches this foundation should produce evidence such as:

- selected vertical slice and affected foundations
- files/code paths proving layer separation
- updated roadmap/development annotations
- foundation status update
- evidence report showing product behavior and review path

Evidence belongs in the implementation report and, when durable, in `.qli/project/evidence-log.md` or the relevant inventory/status file.

## 7. Tests and Human Smoke Checks

Minimum validation expectations:

- slice reaches applicable Core + Data + API + UI + Test layers
- human-visible review path exists when UI is applicable
- new technical debt is either resolved or registered

The selected test tier must be proportional to the change. Full regression is required only when the gate triggers it; targeted tests and smoke checks are required for the changed slice.

## 8. Common AI-Agent Failure Modes

Reject or correct implementation reports showing these patterns:

- agent starts coding without profile/applicability
- agent implements backend scaffolding and calls the product done
- agent creates broad architecture with no real slice
- agent refactors existing behavior without snapshot/evidence

## 9. Definition of Done

- The project has a current profile, applicability matrix, selected target level, first/active slice, and evidence-driven completion standard.

The foundation is not "done" because its document exists. It is done only when the applicable product code, inventories, tests, smoke paths, status files, and evidence prove that the foundation has become part of the product.
