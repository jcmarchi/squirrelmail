# Access Control Mapping — [Project Name]

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `/docs/access-control-mapping.md`  
**Purpose:** Map the Universal Access Control Foundation to this specific repository, stack, product model, and implementation maturity.

---

## 1. Project Access-Control Profile

| Field | Value |
|---|---|
| Product | [Project Name] |
| Stack | [PHP/MySQL, Laravel, Django, Node, React API, .NET, etc.] |
| Rendering/API model | [Server-rendered / SPA / MPA / API-first / Hybrid] |
| Current access-control maturity | [0-5] |
| Target access-control maturity | [0-5] |
| Product type | [SaaS / single-tenant / internal / public hybrid / API-driven / marketplace / other] |
| Tenancy model | [none / tenant / organization / workspace / project / hybrid] |
| Authentication source | [local auth / OAuth / SSO / external IdP / not yet implemented] |
| Authorization implementation path | [middleware / policy classes / service / framework gates / custom] |
| Audit implementation path | [table/log/event bus/none yet] |

---

## 2. Maturity Decision

| Level | Included now? | Notes |
|---|---|---|
| 0 Public route classification | [yes/no] | |
| 1 Authenticated-only | [yes/no] | |
| 2 Basic RBAC | [yes/no] | |
| 3 Scoped RBAC | [yes/no] | |
| 4 Policy-aware authorization | [yes/no] | |
| 5 Enterprise governance | [yes/no] | |

Deferred capabilities and rationale:

| Capability | Deferred until | Reason | Risk |
|---|---|---|---|
| Custom roles | [phase] | | |
| Field-level access | [phase] | | |
| Impersonation | [phase] | | |
| Partner/reseller console | [phase] | | |

---

## 3. Product Surfaces

| Surface | Route/API prefix | Target actors | Access classification | Notes |
|---|---|---|---|---|
| Public | `/` | Anonymous | Public | |
| App Workspace | `/app` | Users | Authenticated/Permissioned | |
| Tenant Admin | `/admin` | Tenant owners/admins | Permissioned/Privileged | |
| Platform Admin | `/platform` | Platform roles | Privileged | |
| Developer/API Console | `/developer` | Integrators | Permissioned | |
| Audit/Compliance | `/audit` | Auditors | Privileged | |
| Dev Tools | `/dev` | Developers | Dev Only | Disabled in production |

---

## 4. Scope Model

| Scope | Parent scope | Used now? | Description | Containment rule |
|---|---|---|---|---|
| platform | none | [yes/no] | Entire installation/platform | root |
| organization | platform | [yes/no] | Parent customer/reseller/org | organization belongs to platform |
| tenant | organization/platform | [yes/no] | Customer/account/site | tenant belongs to org/platform |
| workspace | tenant | [yes/no] | Workspace/business unit | workspace belongs to tenant |
| project | workspace/tenant | [yes/no] | Project/case/publication/etc. | project belongs to workspace/tenant |
| resource | project/tenant | [yes/no] | Object/record | resource belongs to project/tenant |
| field | resource | [yes/no] | Sensitive field | field belongs to resource |
| self | actor | [yes/no] | Own profile/resources | actor owns it |
| global | none | [yes/no] | Single-tenant/global scope | document carefully |

---

## 5. Actor Types

| Actor type | Exists? | Authentication | Notes |
|---|---|---|---|
| Human user | [yes/no] | | |
| Platform admin | [yes/no] | | |
| Tenant user | [yes/no] | | |
| Guest/external collaborator | [yes/no] | | |
| API client/service account | [yes/no] | | |
| Integration/webhook | [yes/no] | | |
| Scheduled job/system process | [yes/no] | | |
| Impersonated support session | [yes/no] | | |

---

## 6. Role Map

| Role key | Role category | Scope | Assignable by | System role? | Description |
|---|---|---|---|---|---|
| platform_owner | Platform Owner | platform | existing platform owner | yes | |
| platform_admin | Platform Administrator | platform | platform_owner | yes | |
| tenant_owner | Tenant Owner | tenant | platform_admin / ownership workflow | yes | |
| tenant_admin | Tenant Administrator | tenant | tenant_owner | yes | |
| manager | Manager / Supervisor | workspace/project | tenant_admin | no | |
| user | Standard User | tenant/project/self | tenant_admin | no | |
| viewer | Viewer | tenant/project/resource | tenant_admin | no | |
| api_client | API Client / Service Account | explicit service scope | integrator/admin | no | |

---

## 7. Permission Inventory Summary

Maintain detailed permissions in `/docs/access-control-permission-inventory.md`.

| Permission key | Resource | Action | Scope types | Risk | System only? | Description |
|---|---|---|---|---|---|---|
| users.read | users | read | tenant, project | medium | no | |
| users.create | users | create | tenant | high | no | |
| roles.assign | roles | assign | tenant, platform | critical | yes/no | |
| audit_logs.read | audit_logs | read | tenant, platform | high | yes/no | |

---

## 8. Capability Map

| Capability | Surface/route | Required permission | Scope | Entitlement/module | Status |
|---|---|---|---|---|---|
| users.manage | `/admin/users` | users.read | tenant | core.identity | active |
| users.invite | action:invite-user | users.create | tenant | core.identity | active |
| audit.view | `/audit` | audit_logs.read | tenant/platform | compliance | planned |

---

## 9. Route / Endpoint Classification

Maintain full details in `/docs/access-control-route-inventory.md`.

| Route / endpoint | Classification | Required permission | Scope resolver | Audit? | Notes |
|---|---|---|---|---|---|
| `GET /` | Public | none | none | no | |
| `GET /app` | Authenticated | none | actor | no | |
| `GET /admin/users` | Permissioned | users.read | tenant | no | |
| `POST /admin/users` | Privileged | users.create | tenant | yes | |
| `POST /admin/roles/assign` | Privileged | roles.assign | tenant/platform | yes | |
| `GET /dev/routes` | Dev Only | dev.routes.read | environment | no | Disabled in production |

---

## 10. Enforcement Adapter

| Enforcement point | Project implementation | Status |
|---|---|---|
| Authentication guard | [file/class/middleware] | [missing/partial/ready] |
| Authorization service | [file/class/service] | [missing/partial/ready] |
| Policy registry | [file/class/config] | [missing/partial/ready] |
| Scope resolver | [file/class/service] | [missing/partial/ready] |
| Capability registry | [file/config/table] | [missing/partial/ready] |
| Route guard/middleware | [file/class] | [missing/partial/ready] |
| API guard | [file/class] | [missing/partial/ready] |
| Query guard | [repository/ORM/scope] | [missing/partial/ready] |
| Audit logger | [file/class/table] | [missing/partial/ready] |

---

## 11. Audit Events

| Event | Required? | Implemented? | Notes |
|---|---|---|---|
| login success/failure | yes | [yes/no] | |
| role assignment/revocation | yes | [yes/no] | |
| permission change | yes | [yes/no] | |
| impersonation start/end | if supported | [yes/no] | |
| data export | if supported | [yes/no] | |
| destructive delete/archive | yes | [yes/no] | |
| billing change | if supported | [yes/no] | |
| integration/API token change | if supported | [yes/no] | |
| failed privileged authorization | yes | [yes/no] | |

---

## 12. Known Risks / Deferred Work

| Risk | Severity | Area | Mitigation | Owner |
|---|---|---|---|---|
| [Example: legacy is_admin checks remain] | high | admin routes | migrate in slice 2 | |

---

## 13. Reviewer Notes

- No new route should be merged without classification.
- No new protected operation should be merged without backend authorization.
- No new privileged operation should be merged without audit logging.
- No access-control refactor should be merged without negative tests.
