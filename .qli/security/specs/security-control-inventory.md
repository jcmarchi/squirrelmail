# Security Control Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


| Control | Status | Applies? | Trigger / Reason | Location | Tests | Notes |
|---|---|---:|---|---|---|---|
| Input validation | planned | yes | baseline | `[path]` | `[tests]` | |
| Output escaping | planned | yes | baseline | `[path]` | `[tests]` | |
| Secure sessions/cookies | planned | if login | login/session | `[path]` | `[tests]` | |
| CSRF protection | planned | if browser writes | login/forms/admin | `[path]` | `[tests]` | |
| Server-side authorization | planned | if protected routes | ACL | `[path]` | `[tests]` | |
| Tenant isolation | not applicable | TBD | tenancy | `[path]` | `[tests]` | |
| File upload hardening | not applicable | TBD | uploads | `[path]` | `[tests]` | |
| API token hashing/scoping | not applicable | TBD | API tokens | `[path]` | `[tests]` | |
| Webhook signature verification | not applicable | TBD | webhooks | `[path]` | `[tests]` | |
| Privacy-safe logging | planned | yes | observability | `[path]` | `[tests]` | |
| Dev/debug blocking | planned | yes | delivery/security | `[path]` | `[tests]` | |
| Dependency review | planned | yes | packages | `[path]` | `[tests]` | |

Status values: `implemented`, `partial`, `planned`, `deferred`, `not applicable`, `deprecated`.
