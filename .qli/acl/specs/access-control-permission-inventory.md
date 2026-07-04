# Access Control Permission Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `/docs/access-control-permission-inventory.md`  
**Purpose:** Track every permission key, scope, risk level, assignment status, and implementation coverage.

| Permission key | Resource | Action | Scope types | Risk | System only? | Assignable? | Implemented? | Tested? | Notes |
|---|---|---|---|---|---|---|---|---|---|
| users.read | users | read | tenant, project, self | medium | no | yes | no | no | |
| users.create | users | create | tenant | high | no | yes | no | no | |
| users.update | users | update | tenant, self | high | no | yes | no | no | |
| users.delete | users | delete | tenant | critical | no | restricted | no | no | |
| roles.read | roles | read | tenant, platform | medium | no | yes | no | no | |
| roles.assign | roles | assign | tenant, platform | critical | yes/no | restricted | no | no | |
| roles.revoke | roles | revoke | tenant, platform | critical | yes/no | restricted | no | no | |
| permissions.read | permissions | read | tenant, platform | medium | no | yes | no | no | |
| permissions.manage | permissions | manage | platform | critical | yes | no | no | no | |
| audit_logs.read | audit_logs | read | tenant, platform | high | yes/no | restricted | no | no | |
| api_tokens.create | api_tokens | create | tenant, integration | high | no | restricted | no | no | |
| api_tokens.revoke | api_tokens | revoke | tenant, integration | high | no | restricted | no | no | |

## Permission Lifecycle Rules

- Do not rename permission keys casually.
- Deprecate and map forward when replacing permissions.
- Mark high-risk and critical permissions before implementation.
- Tenant-created custom roles must not include system-only permissions.
- Any permission with destructive, billing, security, export, impersonation, integration, or role-assignment impact requires tests and audit review.
