# Runtime Cache / Session / Temporary Data Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/runtime-cache-session-inventory.md`

| Key / Store | Type | Scope | Source of Truth? | TTL / Retention | Invalidation | Sensitive Data? | Tenant/User Scoped? | Owner | Status |
|---|---|---|---:|---|---|---:|---:|---|---|
| example.user_capabilities:{tenant}:{user} | cache | tenant+user | no | 5m | role/permission change | no | yes | acl | planned |
| example.session | session | user | no | project policy | logout/expiry | yes | yes | identity | planned |

## Rules

- Cache and sessions are not records of truth.
- Scoped data must use scoped keys.
- Sensitive temporary files and generated exports require expiration and access control.
