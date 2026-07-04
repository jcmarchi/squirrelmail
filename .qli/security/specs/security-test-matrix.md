# Security Test Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


| Area | Required Test | Current Status | Test Location | Notes |
|---|---|---|---|---|
| Auth/session | login/logout/session invalidation | planned | `[path]` | |
| CSRF | state-changing browser requests reject missing/invalid token | planned | `[path]` | |
| Authorization | protected route allow/deny cases | planned | `[path]` | coordinate with ACL |
| Tenant isolation | cross-tenant read/write denied | if applicable | `[path]` | critical when multi-tenant |
| Input validation | invalid payload rejected at boundary | planned | `[path]` | coordinate with API/DATA |
| Output safety | dangerous content escaped/rendered safely | planned | `[path]` | UI/security |
| File upload | invalid type/size/path rejected | if applicable | `[path]` | |
| File download/export | unauthorized access denied | if applicable | `[path]` | |
| API tokens | scope/expiry/revocation enforced | if applicable | `[path]` | |
| Webhooks | invalid signature/replay rejected | if applicable | `[path]` | |
| Dev/debug | unavailable in production mode | planned | `[path]` | delivery/security |
| Secrets/logging | no secret or sensitive payload leakage | planned | `[path]` | observability/security |
| Dependency | audit/check completed where tooling exists | planned | `[path]` | |
