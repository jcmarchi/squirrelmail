# Testing Adapter — [Project Name]

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Purpose:** Map the universal Testing / Quality Foundation to this repository's actual stack, tooling, commands, fixtures, and review workflow.

## 1. Project Testing Profile

| Field | Decision |
|---|---|
| Primary language/runtime | |
| Application type | shared hosting / open source / self-hosted / SaaS / internal / hybrid |
| Core/domain test tool | |
| Data test tool | |
| API/contract test tool | |
| UI/browser test tool | |
| ACL/security test tool | |
| Runtime/job test tool | |
| Static analysis/linting | |
| Local test command | |
| Full test command | |
| Smoke test command | |
| CI command | |

## 2. Test Locations

| Test type | Path | Notes |
|---|---|---|
| Unit/domain | | |
| Data/migration | | |
| API/contract | | |
| UI/browser | | |
| ACL/security | | |
| Runtime/jobs | | |
| Fixtures | | |
| Smoke scripts | | |

## 3. Fixture Policy

- [ ] Tests use deterministic fixtures.
- [ ] No production data is committed.
- [ ] Sensitive data is synthetic or redacted.
- [ ] Multi-tenant fixtures include at least two tenants/scopes when relevant.
- [ ] External services are faked, mocked, sandboxed, or explicitly documented.

## 4. Quality Gate Policy

| Gate | Required for this project? | Command/check |
|---|---:|---|
| Unit/domain tests | yes/no | |
| API contract tests | yes/no | |
| Data migration tests | yes/no | |
| UI smoke/browser tests | yes/no | |
| ACL negative tests | yes/no | |
| Runtime retry/idempotency tests | yes/no | |
| Accessibility checks | yes/no | |
| Security checks | yes/no | |
| Performance checks | yes/no | |

## 5. AI Agent Notes

Document any project-specific constraints that AI Coding Agents must respect before adding, changing, or refactoring tests.
