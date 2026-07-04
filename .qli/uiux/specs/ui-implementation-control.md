# UI/UX Foundation — Buildline Implementation Control

**Buildline version:** 2.0  
**Canonical reference:** `.qli/uiux/specs/ui-foundation-reference.md`  
**Layer:** QLi Foundations / implementation control  
**Scope:** Generic and project-agnostic. Project-specific applicability is decided by `.qli/project/foundation-applicability.yml` through `.qli/binding/` rules.

## 1. Purpose

Controls the visible, reviewable product surface so UI is built as a reusable, testable application foundation from the beginning, not added after backend work.

This file is not a replacement for the full foundation reference. It is the operational control used by AI coding agents and human reviewers to determine what must exist upfront, what may be deferred, and what evidence proves completion.

## 2. What This Foundation Controls

- UI shell and navigation
- design tokens and reusable primitives
- component inventory
- demo/reference route
- accessibility baseline
- state handling
- responsive behavior
- human smoke testing

## 3. Minimum Upfront Spine

The following items are required early when this foundation is marked `required`, `spine_required`, or `minimum_required` in `.qli/project/foundation-applicability.yml`:

- application shell exists or is intentionally not applicable
- navigation model and primary layout are defined
- design tokens or styling conventions are selected
- demo/reference route or equivalent exists
- placeholder policy is documented
- empty/loading/error/success states are represented
- stable test selectors or review anchors exist
- human smoke path can be followed without reading code

If a spine item does not apply, the reason must be recorded in `.qli/project/foundation-applicability.yml` or `.qli/project/deferral-register.md`. Silent omission is not allowed.

## 4. Optional / Advanced Capabilities

The following capabilities are valid but should activate only when the project profile, target level, or slice scope requires them:

- full component gallery
- theme switcher
- RTL/i18n readiness beyond baseline
- visual regression automation
- advanced responsive variants
- complex drag/drop or real-time UI behaviors

Optional does not mean unimportant. It means the capability is not automatically required for every product at every stage.

## 5. Deferral Rules

- A component may be deferred only if no current slice uses it.
- A UI state may not be deferred if the user can encounter that state in the implemented slice.
- Visual polish may be staged; reviewability, accessibility, and state integrity may not.

Every deferral must include reason, risk, activation trigger, review point, and owner/responsible role in `.qli/project/deferral-register.md`.

## 6. Implementation Evidence

A completed slice that touches this foundation should produce evidence such as:

- screens/routes changed
- components reused/extended/created
- demo/reference page updated
- accessibility and keyboard checks
- human smoke path with expected result
- screenshots optional but useful for review packages

Evidence belongs in the implementation report and, when durable, in `.qli/project/evidence-log.md` or the relevant inventory/status file.

## 7. Tests and Human Smoke Checks

Minimum validation expectations:

- layout renders
- navigation works
- forms validate
- errors display safely
- keyboard path works for core actions
- responsive minimum checked
- placeholders are labeled as placeholders

The selected test tier must be proportional to the change. Full regression is required only when the gate triggers it; targeted tests and smoke checks are required for the changed slice.

## 8. Common AI-Agent Failure Modes

Reject or correct implementation reports showing these patterns:

- one-off CSS/components
- hidden backend-only completion
- untestable UI state
- missing empty/error/loading states
- demo page not updated after component changes

## 9. Definition of Done

- The applicable product surface is visible, reusable, inspectable, smoke-testable, and documented enough for a human review session.

The foundation is not "done" because its document exists. It is done only when the applicable product code, inventories, tests, smoke paths, status files, and evidence prove that the foundation has become part of the product.
