# Security Exception Register

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Purpose:** Record accepted temporary security risks. This file prevents hidden deferrals.

| Exception | Control Deferred | Reason | Risk | Compensating Control | Owner | Target Resolution | Status |
|---|---|---|---|---|---|---|---|
| `[exception]` | `[control]` | `[reason]` | `[low/medium/high/critical]` | `[control]` | `[owner]` | `[date/version]` | `[open/closed]` |

## Rules

- Critical exceptions require explicit human approval.
- Exceptions must have an owner and target resolution.
- Do not use exceptions to bypass foundational controls permanently.
- Review open exceptions before public release, customer demo, production deployment, or security-sensitive feature launch.
