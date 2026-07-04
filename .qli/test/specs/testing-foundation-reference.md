# Testing / Quality Foundation Reference

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Version:** 1.0-Universal  
**Intended location:** `.qli/testing-foundation-reference.md`  
**Audience:** AI Coding Companions, human architects, reviewers, QA owners, technical leads  
**Purpose:** Define a reusable, stack-agnostic testing and quality standard for new and existing applications so AI-assisted development remains verifiable, regression-safe, and reviewable across Core, Data, API, UI, ACL, Runtime, and future architectural layers.

---

## 0. Mandatory Instruction to AI Coding Agents

Before creating, modifying, or refactoring any meaningful application behavior, read this file and treat it as the quality source of truth for the repository.

Testing is not a final cleanup step. It is part of implementation. A feature is not complete until the relevant tests, smoke checks, review notes, and quality documentation are updated.

AI Coding Agents must not claim completion based only on code changes. They must report what was validated, what was not validated, what remains risky, and what manual smoke test the human architect should run.

---

## 1. What This Foundation Is

The Testing / Quality Foundation defines how work becomes trustworthy. It does not prescribe a specific testing framework, CI provider, browser automation tool, language, or hosting model. It defines the quality contract that each project adapter must implement using the tools available in that repository.

This foundation is intentionally application-agnostic. It applies to shared-hosting PHP applications, open-source packages, internal tools, desktop-like web apps, API services, SaaS platforms, self-hosted systems, event-driven systems, and scalable cloud deployments.

The foundation exists because AI Coding Agents tend to produce plausible code faster than they produce reliable systems. The quality layer forces verification of behavior, regression safety, edge cases, data integrity, authorization, runtime behavior, UI usability, and contract compatibility.

---

## 2. Relationship to Other Foundations

Testing / Quality is a cross-cutting enforcement layer.

| Foundation | Testing / Quality responsibility |
|---|---|
| Application Construction Doctrine | Verify that features are delivered as reviewable vertical slices. |
| Domain/Core | Unit-test business rules, use cases, workflows, invariants, domain events, and error paths. |
| Data | Test schema validation, migrations, old-record readability, tenancy/scope, lifecycle, imports, exports, and dataset integrity. |
| API | Test OpenAPI/AsyncAPI contracts, request validation, response envelopes, idempotency, errors, versioning, webhooks, and event compatibility. |
| UI | Test critical user flows, accessibility, responsive behavior, component states, empty/loading/error states, and visual regressions where practical. |
| ACL | Test allowed and denied cases, privilege escalation prevention, route classification, audit logging, and frontend-hidden/server-denied parity. |
| Runtime | Test jobs, schedules, queues, retries, locks, idempotency, cache/session behavior, and failure recovery. |
| Observability | Verify that logs, traces, metrics, request IDs, and diagnostic events exist where required. |
| Security | Verify secure defaults, input boundaries, file safety, secret handling, CSRF/CORS/session controls, and abuse protections. |

---

## 3. Core Quality Philosophy

1. Test behavior, not implementation trivia.
2. Use risk-based coverage. Critical paths need stronger proof than low-risk presentation details.
3. Every change should include the smallest sufficient validation set.
4. Negative tests are mandatory for permissions, validation, data boundaries, and dangerous operations.
5. Refactoring must preserve behavior unless a documented migration intentionally changes it.
6. Contract compatibility matters. API, event, data, import/export, and UI interaction changes must not silently break consumers.
7. Test data must be deterministic, documented, isolated, and safe.
8. Manual smoke tests are still required for important UI/product flows, especially when automated browser coverage is absent.
9. Coverage percentage is a signal, not a proof of quality.
10. AI agents must report untested risk honestly.

---

## 4. Quality Maturity Levels

Use this scale to evaluate a repository or feature area.

| Level | Name | Description |
|---|---|---|
| 0 | Unverified | Code exists but no reliable tests, smoke instructions, or review checklist. |
| 1 | Smoke-Tested | Basic manual or CLI smoke checks exist; no systematic regression protection. |
| 2 | Unit-Tested | Core logic and simple services have tests; integration and UI gaps remain. |
| 3 | Integrated | Data, API, ACL, runtime, and major UI flows have meaningful positive and negative tests. |
| 4 | Regression-Safe | Stable test matrix, fixtures, smoke scripts, contract tests, migration tests, and CI-ready checks exist. |
| 5 | Release-Ready | Automated gates, manual QA checklist, risk register, observability checks, performance/security/a11y coverage, and release sign-off exist. |

A new project may start at Level 1 or 2, but each foundation slice should move the relevant area toward Level 3 or higher. A feature exposed to users or the public should not remain at Level 0.

---

## 5. Project Adapter Contract

Every repository should define `.qli/testing-adapter.md` with the project-specific testing implementation.

| Field | Required decision |
|---|---|
| Primary language/runtime | PHP, Python, Go, Java, C#, Ruby, etc. |
| Core/domain test tool | Example: PHPUnit, pytest, Go test, JUnit, xUnit, etc. |
| API test tool | Example: contract test runner, HTTP smoke tests, OpenAPI validator, custom scripts. |
| UI/browser test tool | Example: Playwright, Cypress, Selenium, framework-specific tools, or manual smoke page. |
| Data test strategy | Migration tests, seed validation, repository tests, import/export fixtures. |
| ACL/security test strategy | Positive/negative permission tests, route classification tests, audit tests. |
| Runtime test strategy | Job/queue/scheduler tests, retry/idempotency tests, fake broker, in-memory queue, cron simulation. |
| CI/local execution | Commands for local test, focused test, full test, smoke test, lint/static analysis. |
| Fixture policy | Where fixtures live, how they are reset, privacy/sensitivity rules. |
| Coverage policy | Minimum expectations by risk, not only by percentage. |
| Manual QA policy | Required human smoke paths and review notes. |

If no adapter exists and testing work is requested, create it before broad test implementation.

---

## 6. Required Test Categories

The exact tool may vary, but each serious project should account for these categories.

| Category | Purpose | Typical examples |
|---|---|---|
| Unit tests | Verify isolated behavior. | Value objects, validators, calculators, pure services, policy functions. |
| Domain/use-case tests | Verify business behavior. | Create project, approve invoice, publish content, calculate bid, assign task. |
| Data tests | Verify persistence and schema behavior. | Migration, repository, old-record readability, lifecycle, imports/exports. |
| API contract tests | Verify interface compatibility. | OpenAPI response schema, request validation, error envelope, pagination. |
| Event contract tests | Verify AsyncAPI/event messages. | Event payload schema, consumer compatibility, idempotency keys. |
| Integration tests | Verify multiple layers together. | Use case + repository + policy + event emission. |
| UI/component tests | Verify reusable UI behavior. | Buttons, tables, forms, modals, empty/loading/error states. |
| Browser/end-to-end tests | Verify user-visible flows. | Login, create record, edit workflow, admin permission denial. |
| ACL tests | Verify authorization. | Allowed/denied cases, scope containment, privilege escalation prevention. |
| Runtime tests | Verify operational execution. | Queue retries, locks, schedules, dead-letter, webhook idempotency. |
| Migration/backfill tests | Verify schema/data evolution. | Apply migration, rollback/forward plan, transform old records. |
| Accessibility tests | Verify usability standards. | Keyboard navigation, focus order, labels, contrast, screen-reader structure. |
| Performance tests | Verify risk-specific capacity. | Hot endpoint latency, query count, job throughput, large import. |
| Security tests | Verify critical boundaries. | Input validation, file upload, CSRF, CORS, session, secrets, rate limits. |
| Smoke tests | Verify the build is usable. | Boot app, run migrations, open dashboard, call health/API endpoint. |
| Regression tests | Preserve fixed behavior. | Reproduce a bug before fixing, then keep the test. |

Do not implement all categories blindly for every micro-change. Select the relevant set based on risk, surface, and foundation impact.

---

## 7. Vertical Slice Quality Rule

When a feature changes Core + Data + API + UI, the quality work must also cut vertically.

A meaningful feature should usually include:

1. Domain/use-case test for business behavior.
2. Data test for persistence, schema, migration, or lifecycle impact.
3. API contract/integration test if the feature is exposed through an API or event.
4. UI smoke or browser test if the feature is user-facing.
5. ACL positive and negative tests if users, roles, scopes, admin surfaces, exports, files, or privileged actions are involved.
6. Runtime tests if jobs, queues, schedules, webhooks, imports, exports, cache, locks, or retries are involved.
7. Manual smoke instructions for the human architect.

---

## 8. New Project Procedure

For a new project, AI Coding Agents must establish a lightweight but real quality foundation early.

Minimum new-project quality setup:

1. Create `.qli/testing-foundation-reference.md`.
2. Create `.qli/testing-adapter.md`.
3. Create `.qli/testing-test-inventory.md`.
4. Create `.qli/testing-coverage-matrix.md`.
5. Create `.qli/testing-smoke-checklist.md`.
6. Define local test commands in `README.md`, `SETUP.md`, or project scripts.
7. Add at least one executable smoke test or documented smoke path.
8. Add the first unit/domain test for the first meaningful use case.
9. Add API, data, UI, ACL, and runtime tests as those layers become active.

New projects do not need enterprise CI/CD on day one, but they must not begin with an untestable architecture.

---

## 9. Existing / Refactoring Project Procedure

For existing projects, the first step is not rewriting tests. The first step is mapping current behavior.

Before refactoring, AI Coding Agents must:

1. Inspect existing test tools, scripts, CI files, fixtures, smoke paths, and manual QA notes.
2. Identify business-critical flows that currently have no regression protection.
3. Create or update `.qli/testing-adapter.md`.
4. Create or update the test inventory and coverage matrix.
5. Add characterization tests before changing fragile or poorly understood behavior.
6. Preserve valid behavior unless an intentional migration is documented.
7. Convert repeated manual checks into automated smoke tests where practical.
8. Record known gaps instead of pretending untested work is complete.

Characterization tests are especially important when business logic is currently scattered across controllers, templates, models, jobs, scripts, or UI handlers.

---

## 10. Test Data and Fixture Rules

Test data must be controlled. Poor fixtures create false confidence.

Rules:

1. Fixtures must be deterministic.
2. Tests must not depend on production data.
3. Sensitive data must not be copied into fixtures.
4. Multi-tenant/scope fixtures must include at least two tenants/scopes when testing isolation.
5. Fixtures should represent realistic edge cases, not only happy paths.
6. Generated IDs, dates, clocks, random values, and external responses must be controlled or mockable.
7. Imports, exports, and dataset tests must include malformed and boundary cases.
8. Tests must clean up after themselves or run in isolated databases/storage roots.

---

## 11. Regression Policy

Every meaningful bug fix should add a regression test when technically feasible.

If an automated regression test is not feasible, the agent must add a manual regression entry to `.qli/testing-regression-matrix.md` or the project equivalent.

Regression entries should include:

- bug or issue identifier;
- affected feature;
- reproduction steps;
- expected behavior;
- automated test reference or manual check;
- risk if not retested.

---

## 12. Quality Gates

Use these gates before accepting a change.

| Gate | Requirement |
|---|---|
| Build gate | Project installs/builds/runs with documented commands. |
| Unit gate | Changed core/domain logic has relevant unit/use-case tests. |
| Data gate | Schema, migration, import/export, lifecycle, and tenancy changes are tested. |
| API gate | Contract changes are documented and validated. |
| UI gate | User-facing changes are smoke-tested through the interface. |
| ACL gate | Permissions, scope, route classification, and negative cases are tested. |
| Runtime gate | Jobs, retries, locks, schedules, and idempotency are tested where affected. |
| Regression gate | Known bug or fragile behavior has regression coverage. |
| Documentation gate | Inventories, matrices, ADRs, setup instructions, and smoke checklists are updated. |
| Human-review gate | Manual smoke path is provided for product/architect review. |

---

## 13. AI Coding Agent Completion Rules

AI Coding Agents must end implementation work with a validation report.

Required report fields:

```text
Testing / Quality:
- Maturity Level: [0-5 or n/a]
- Tests Added: [unit/domain/data/API/UI/ACL/runtime/etc.]
- Tests Updated: [list]
- Tests Run: [commands and results]
- Manual Smoke Path: [steps]
- Coverage / Risk Notes: [summary]
- Deferred Quality Risks: [known risks]
```

The agent must not say “all good” if tests were not run. It must say what was not run and why.

---

## 14. Anti-Patterns

Avoid these patterns:

- Adding code without any validation path.
- Testing only the happy path.
- Treating hidden UI buttons as authorization tests.
- Mocking the system so heavily that the test no longer proves behavior.
- Using production data in tests.
- Writing brittle tests coupled to incidental markup or private implementation details.
- Ignoring migration/backward-compatibility tests for live data.
- Skipping negative tests for permissions, validation, imports, uploads, and destructive actions.
- Using coverage percentage to hide missing critical-path tests.
- Leaving manual smoke instructions undocumented.
- Refactoring existing code without characterization tests.
- Claiming a feature is complete when only backend code exists and no UI/API/data path was verified.

---

## 15. Minimum Acceptable MVP

The minimum testing/quality implementation for a serious application must include:

1. A documented testing adapter.
2. A test inventory.
3. A smoke checklist.
4. A test matrix for the first vertical slice.
5. At least one automated test for core/domain behavior.
6. Validation for API/data/UI behavior when those layers exist.
7. ACL negative tests when access control exists.
8. Runtime tests when jobs/queues/schedules/webhooks exist.
9. Manual smoke steps for the human architect.
10. A delivery report that clearly identifies untested risk.

---

## 16. Required Supporting Files

Recommended files under `.qli/`:

```text
testing-foundation-reference.md
testing-adapter.md
testing-test-inventory.md
testing-coverage-matrix.md
testing-smoke-checklist.md
testing-regression-matrix.md
testing-defect-log.md
testing-review-checklist.md
```

Prompt files may also be included:

```text
testing-new-implementation.md
testing-refactoring.md
```

---

## QLi v2 Addendum — Validation Tiers and Human Smoke Tests

Validation is not only technical. QLi projects must be testable by automated checks and human review as soon as product behavior exists.

### Validation Tiers

| Tier | Name | Use |
|---|---|---|
| 1 | Static/read-only | Inventory, lint, route listing, schema inspection, configuration checks. |
| 2 | Focused automated | Tests for changed files, contracts, policies, migrations, components, or use cases. |
| 3 | Human smoke | Screen/API/CLI walkthrough that proves product-visible behavior. |
| 4 | Full regression | Required when shared architecture, data contracts, ACL/security, deployment, or broad runtime behavior changes. |

The agent must justify the selected tier. Full regression is not the default for every small change, and no validation is not acceptable for meaningful behavior changes.

## Buildline Implementation Control

This foundation is governed operationally by `.qli/test/specs/testing-implementation-control.md`.

Use the full reference for doctrine and vocabulary. Use the implementation-control file for the project-agnostic minimum spine, optional capability rules, deferral rules, evidence expectations, test/smoke expectations, common AI-agent failure modes, and definition of done.

Project-specific applicability is not decided inside this reference file. It is decided through `.qli/binding/` and recorded in `.qli/project/foundation-applicability.yml`.
