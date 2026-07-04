# Testing / Quality Foundation — Buildline Implementation Control

**Buildline version:** 2.0  
**Canonical reference:** `.qli/test/specs/testing-foundation-reference.md`  
**Layer:** QLi Foundations / implementation control  
**Scope:** Generic and project-agnostic. Project-specific applicability is decided by `.qli/project/foundation-applicability.yml` through `.qli/binding/` rules.

## 1. Purpose

Controls verification quality across automated tests, focused checks, human smoke tests, regression scope, and implementation evidence.

This file is not a replacement for the full foundation reference. It is the operational control used by AI coding agents and human reviewers to determine what must exist upfront, what may be deferred, and what evidence proves completion.

## 2. What This Foundation Controls

- test inventory
- test tier selection
- unit/integration/API/UI checks
- human smoke checklist
- regression matrix
- defect log
- coverage-by-risk
- evidence reporting

## 3. Minimum Upfront Spine

The following items are required early when this foundation is marked `required`, `spine_required`, or `minimum_required` in `.qli/project/foundation-applicability.yml`:

- test command(s) are documented
- minimum test harness exists or non-applicability is justified
- human smoke-test path exists
- changed-scope test tier is selected per slice
- defect log exists
- API/UI/ACL/Data tests are added when those surfaces are touched
- full regression triggers are defined

If a spine item does not apply, the reason must be recorded in `.qli/project/foundation-applicability.yml` or `.qli/project/deferral-register.md`. Silent omission is not allowed.

## 4. Optional / Advanced Capabilities

The following capabilities are valid but should activate only when the project profile, target level, or slice scope requires them:

- coverage thresholds
- visual regression
- E2E suite
- mutation testing
- load/performance tests
- accessibility automation

Optional does not mean unimportant. It means the capability is not automatically required for every product at every stage.

## 5. Deferral Rules

- Automation may be staged for low-risk placeholders, but human smoke paths may not be omitted for reviewable UI.
- Full regression is not mandatory after every trivial edit; it is mandatory when triggers are met.

Every deferral must include reason, risk, activation trigger, review point, and owner/responsible role in `.qli/project/deferral-register.md`.

## 6. Implementation Evidence

A completed slice that touches this foundation should produce evidence such as:

- commands run
- test results
- human smoke path/result
- known defects
- unrun tests with reason
- regression-scope decision

Evidence belongs in the implementation report and, when durable, in `.qli/project/evidence-log.md` or the relevant inventory/status file.

## 7. Tests and Human Smoke Checks

Minimum validation expectations:

- static/read-only checks where appropriate
- targeted tests for changed behavior
- smoke tests for user-visible path
- full regression only on defined triggers

The selected test tier must be proportional to the change. Full regression is required only when the gate triggers it; targeted tests and smoke checks are required for the changed slice.

## 8. Common AI-Agent Failure Modes

Reject or correct implementation reports showing these patterns:

- absurdly broad tests by default
- no human smoke review
- tests only prove technical compilation
- agent claims unrun tests passed
- defects not tracked

## 9. Definition of Done

- The slice has risk-proportional automated checks, a human-verifiable smoke path, and an honest evidence report.

The foundation is not "done" because its document exists. It is done only when the applicable product code, inventories, tests, smoke paths, status files, and evidence prove that the foundation has become part of the product.
