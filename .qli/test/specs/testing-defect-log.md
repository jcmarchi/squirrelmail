# Testing Defect Log — [Project Name]

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Purpose:** Track quality defects found during architecture review, automated tests, smoke tests, manual QA, and AI-agent implementation passes.

| Defect ID | Date | Area | Severity | Description | Reproduction | Expected | Actual | Owner | Status | Regression Added |
|---|---|---|---|---|---|---|---|---|---|---|
| DEF-001 | | | low/medium/high/critical | | | | | | open/fixed/deferred/wontfix | yes/no/n/a |

## Severity Guidance

- `critical`: data loss, security breach, cross-tenant exposure, production outage, destructive failure.
- `high`: broken critical path, serious integrity issue, major usability block.
- `medium`: important but bounded defect.
- `low`: minor defect or cosmetic issue with low risk.
