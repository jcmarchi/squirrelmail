# Access Control Route and Endpoint Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `/docs/access-control-route-inventory.md`  
**Purpose:** Classify routes, endpoints, commands, jobs, downloads, exports, and dev tools for access-control review.

| Route / command / endpoint | Method | Classification | Required permission | Scope | Scope resolver | Audit? | Implemented? | Tested? | Notes |
|---|---|---|---|---|---|---|---|---|---|
| `/` | GET | Public | none | none | none | no | no | no | |
| `/login` | GET/POST | Public | none | none | none | yes for failures | no | no | |
| `/app` | GET | Authenticated | none | actor | actor context | no | no | no | |
| `/admin/users` | GET | Permissioned | users.read | tenant | tenant from route/session | no | no | no | |
| `/admin/users` | POST | Privileged | users.create | tenant | tenant from route/session | yes | no | no | |
| `/admin/roles/assign` | POST | Privileged | roles.assign | tenant/platform | target user containment | yes | no | no | |
| `/api/tokens` | POST | Privileged | api_tokens.create | tenant/integration | tenant + integration | yes | no | no | |
| `/exports/*` | GET/POST | Privileged | resource.export | tenant/project | resource containment | yes | no | no | |
| `/dev/routes` | GET | Dev Only | dev.routes.read | environment | app env | no | no | no | disabled in production |

## Classification Rules

- Public: intentionally unauthenticated.
- Authenticated: login/session/token required, no special permission.
- Permissioned: specific permission and scope required.
- Privileged: high-risk permission; audit and possibly MFA/step-up required.
- Internal: internal jobs/services only, not publicly routable.
- Dev Only: disabled in production.

Routes without classification fail review.
