# Domain Test Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/domain-test-matrix.md`

| Feature / Use Case | Unit Test | Integration Test | API Contract Test | UI Smoke Test | ACL Negative Test | Data/Migration Test | Event Test | Edge Cases Covered | Status |
|---|---|---|---|---|---|---|---|---|---|
| CreateProject | planned | planned | planned | planned | planned | planned | planned | duplicate name, forbidden actor | planned |

## Required Test Categories

- Use case success path.
- Validation failure.
- Authorization denial where applicable.
- Missing resource.
- Invalid lifecycle state or transition.
- Conflict/concurrency case where applicable.
- Event emitted or not emitted as expected.
- Data persistence and migration behavior.
- API contract behavior when exposed.
- UI smoke path when user-facing.

## Rules

- Domain changes should ship with tests in the same implementation pass.
- Refactors should protect existing behavior before extraction when feasible.
- Negative tests matter more than happy-path-only demonstrations.
