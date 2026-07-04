# Universal Access Control Foundation Reference

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Version:** 1.0-Universal  
**Intended location:** `/docs/access-control-reference.md`  
**Audience:** AI Coding Companions, architects, implementation reviewers, security reviewers  
**Purpose:** Define a reusable, technology-agnostic access-control foundation that can be applied to new and existing applications without forcing every product into the same SaaS complexity level.

---

## 0. Mandatory Instruction to the AI Coding Companion

Before creating, modifying, or refactoring authentication-adjacent, authorization-related, administration, user-management, route, API, menu, navigation, tenancy, role, permission, policy, service-account, export, file-access, billing, audit, impersonation, or destructive-operation code, read this file and treat it as the access-control source of truth for the repository.

Do not add ad hoc `is_admin`, `is_owner`, `role == "admin"`, hidden-button-only checks, route-only checks, controller-only checks, or frontend-only permission logic when a centralized access-control model can be used or extended.

Correct execution sequence:

1. Inspect the repository stack, routing model, authentication model, data ownership model, user model, existing roles, permission checks, middleware, policies, services, tests, seed data, admin screens, API endpoints, and audit logging.
2. Identify whether the project is single-tenant, multi-tenant, modular, public/anonymous, internal-only, API-driven, SaaS, marketplace, reseller/partner-driven, or hybrid.
3. Read `/docs/access-control-mapping.md` if present. If absent and access-control work is significant, create it before broad implementation.
4. Reuse or extend the existing authorization service, policy registry, route guards, capability registry, permission inventory, audit logger, and test patterns before creating new structures.
5. If the application already has access-control code, analyze and preserve valid behavior while migrating toward this standard. Do not blindly replace working security behavior without a migration plan.
6. Deny by default. Missing policy, missing scope, missing route classification, or missing permission metadata must be treated as an implementation gap.
7. UI gating is never sufficient. Every protected server-side operation must enforce authorization independently of the UI.
8. Update mapping, permission inventory, route inventory, test matrix, and review checklist whenever the access-control model changes.
9. Report what was inspected, reused, extended, added, migrated, tested, deferred, and any unresolved risk.

---

## 1. What This Foundation Is

The Universal Access Control Foundation is not only a SaaS RBAC model. It is a security architecture contract for deciding who may do what, where, under which conditions, and with what audit trail.

It applies to:

- brand-new applications with no access-control model yet;
- existing applications with scattered role checks;
- SaaS and multi-tenant applications;
- single-tenant business systems;
- modular applications with optional feature sets;
- internal tools;
- public/private hybrid systems;
- API-first platforms;
- partner/reseller environments;
- products with human users, service accounts, integrations, and scheduled jobs.

Not every application needs every feature immediately. A simple single-tenant product may not need tenant isolation, custom roles, reseller consoles, or field-level security on day one. The architecture must still be able to grow into those needs without requiring a full rewrite.

---

## 2. Foundation Doctrine

Access control must be centralized, scoped, policy-aware, auditable, testable, and reflected in the UI.

Mandatory principles:

1. **Deny by default.** Anything not explicitly allowed is denied.
2. **Authenticate first, authorize every protected request.** Authentication identifies the actor; authorization decides whether the actor may act.
3. **No frontend-only authorization.** Hidden or disabled UI controls improve experience but do not enforce security.
4. **Least privilege.** Users, administrators, service accounts, integrations, and support sessions receive only the permissions required.
5. **Scope must be explicit when scope exists.** A permission without a scope is incomplete in SaaS, multi-tenant, multi-organization, project-based, or ownership-based systems.
6. **Data boundaries are enforced by policy and query design.** Tenant, organization, workspace, project, resource, and self boundaries must not rely on client-supplied IDs.
7. **Privileged actions are auditable.** Role changes, permission changes, impersonation, exports, billing, integration changes, destructive actions, and security changes must be logged.
8. **The UI reflects capabilities.** Navigation, menus, buttons, pages, and workflow actions should be generated from capability metadata, not hardcoded role names.
9. **Access control is tested with positive and negative cases.** Allowed cases prove usability; denied cases prove security.
10. **Implementation is technology-adaptable.** The same model can be mapped to PHP, Laravel, Symfony, Django, Rails, Node, React, Vue, Angular, Svelte, Go, Java, .NET, server-rendered apps, SPAs, MPAs, APIs, or hybrid systems.

---

## 3. Access-Control Maturity Levels

Use maturity levels to avoid overbuilding small products while preserving a clean growth path.

| Level | Name | Appropriate for | Required capabilities |
|---|---|---|---|
| 0 | Public / No protected state | Static sites, public content, unauthenticated tools | Explicit public route classification; no accidental private data exposure. |
| 1 | Authenticated-only | Simple logged-in apps | Authentication, route guards, current-user checks, logout/session handling. |
| 2 | Basic RBAC | Internal tools, early products | Roles, permission groups, centralized authorization checks, admin-only routes. |
| 3 | Scoped RBAC | Multi-team, project, organization, or tenant products | Role assignments with scope, scope containment, route/API policy checks, audit events. |
| 4 | Policy-aware authorization | Serious SaaS, regulated systems, operational platforms | RBAC + scope + ABAC-style conditions, capability registry, service accounts, impersonation controls, tests. |
| 5 | Enterprise governance | Enterprise SaaS, compliance-heavy, partner/reseller platforms | Custom roles, field-level access, separation of duties, step-up auth, approval workflows, audit review tooling. |

The AI Coding Companion must select the minimum viable level for the current project, then implement in a way that does not block later maturity.

---

## 4. Core Concepts

### 4.1 Actor

An actor is the authenticated entity making a request. It may be a human user, service account, API client, integration, scheduled job, webhook processor, CLI tool, delegated support session, or system process.

Every actor should have a stable identifier, authentication state, audit identity, status, and optional attributes such as tenant memberships, MFA state, account type, team, department, or risk indicators.

### 4.2 Subject

The subject is the security principal evaluated by policy. Usually the subject is the actor. In impersonation, delegated administration, and service execution, the subject may include both original actor and effective actor.

### 4.3 Resource

A resource is any protected object, record, operation, screen, API endpoint, file, setting, tenant, workspace, project, module, report, export, integration, or field.

Generic resource examples:

```text
tenant
organization
workspace
project
user
role
permission
resource
file
content
billing_account
integration
api_token
audit_log
system_setting
workflow
report
field
```

### 4.4 Action

An action is the operation attempted against a resource. Use predictable verbs.

Recommended action vocabulary:

```text
create, read, update, delete, list, search, export, import,
publish, unpublish, approve, reject, assign, revoke, execute,
configure, impersonate, archive, restore, transfer, manage
```

### 4.5 Permission

A permission is a stable authorization grant for an action against a resource type.

Naming format:

```text
resource.action
module.resource.action
system.resource.action
```

Examples:

```text
users.read
users.create
users.update
users.delete
roles.assign
roles.revoke
permissions.manage
tenants.configure
audit_logs.read
api_tokens.create
api_tokens.revoke
content.publish
billing.read
billing.manage
integrations.configure
```

Avoid vague permission names such as `admin`, `full_access`, `can_edit`, `manager`, or `owner`. Those may be role names or labels, but not enforceable permissions.

### 4.6 Scope

A scope defines where a permission applies.

Recommended scope levels:

| Scope | Meaning |
|---|---|
| `platform` | Entire platform or installation. |
| `organization` | Owning organization, account group, reseller group, or parent customer. |
| `tenant` | Tenant, customer account, site, practice, client account, or business instance. |
| `workspace` | Workspace, business unit, department, project group, or site group. |
| `project` | Project, publication, case, property, app, campaign, repository, or work unit. |
| `module` | Enabled product module or domain area. |
| `resource` | Specific object or record. |
| `field` | Sensitive field or data element. |
| `self` | Actor's own profile or owned resources. |
| `global` | Single-installation scope for non-SaaS products; use carefully. |

A scoped role assignment must identify actor, role, scope type, and scope ID.

```text
actor_id: 1001
role: tenant_admin
scope_type: tenant
scope_id: tenant_abc
```

### 4.7 Role

A role is a named collection of permissions assigned to an actor within a scope. Roles are for human administration and comprehension. Permissions are for enforcement.

Roles should be stable and limited. Do not create a new role for every customer edge case. Use scopes, policy conditions, custom role configuration, and feature entitlements for precision.

### 4.8 Policy

A policy evaluates subject, permission, resource, action, scope, ownership, request context, environment, subscription, and workflow state.

Example:

```text
Allow users.update when:
- actor has users.update within tenant scope;
- target user belongs to the same tenant;
- target user is not a platform owner;
- actor is not modifying their own security-critical role assignment;
- actor session is active and not elevated-risk.
```

### 4.9 Capability

A capability is a UI and workflow declaration connected to permissions. Capabilities drive menus, routes, buttons, and actions without hardcoding role names into the UI.

```yaml
capability: users.manage
label: Manage Users
route: /admin/users
required_permission: users.read
required_actions:
  create: users.create
  update: users.update
  delete: users.delete
scope_type: tenant
module: core.identity
status: active
```

Capabilities affect visibility and enabled state. They do not replace backend enforcement.

### 4.10 Entitlement

An entitlement defines whether a tenant/account/customer is eligible to use a feature because of plan, subscription, module enablement, license, contract, or environment.

Authorization asks: **Is this actor allowed?**  
Entitlement asks: **Is this account eligible?**  
A feature may require both.

---

## 5. Standard Role Categories

Each project may rename user-facing roles, but internal role categories should map to this vocabulary.

| Category | Typical scope | Description |
|---|---|---|
| Platform Owner | Platform | Highest-level owner/emergency governance; rare. |
| Platform Administrator | Platform/restricted platform | Platform operations, tenant provisioning, moderation, support, compliance. |
| Platform Support | Assigned tenants/orgs/support queues | Restricted customer support; not unrestricted data access. |
| Partner / Reseller | Organization/tenant group | Delegated management of assigned customers, licensing, provisioning. |
| Tenant Owner | Tenant | Business owner of one tenant/account. |
| Tenant Administrator | Tenant | Manages users, settings, workflows, resources within one tenant. |
| Manager / Supervisor | Workspace/project/team/module | Operational supervision, approvals, assignment, reporting. |
| Standard User | Self/project/workspace/tenant | Ordinary product work. |
| Agent / Operator | Queue/workflow/project/team | Specialized operational role. |
| Contributor / Editor | Project/content/workflow/module | Creates or edits resources; may not publish/delete/configure. |
| Viewer / Read-Only | Project/workspace/tenant/resource | Read-only access; may still need field redaction. |
| Auditor / Compliance Reviewer | Platform/tenant/workspace | Reads logs and evidence without operational mutation rights. |
| Integrator / Technical Operator | Integration/module/tenant | Configures APIs, webhooks, connectors, service accounts. |
| API Client / Service Account | Explicit service scope | Non-human principal with narrow machine permissions. |
| Guest / External Collaborator | Resource/project/invitation | Limited external access. |
| Public / Anonymous | Public scope | No authenticated identity; only explicitly public resources. |

No product is required to implement every category.

---

## 6. Baseline Roles

Recommended internal role keys for serious SaaS or modular business platforms:

```text
platform_owner
platform_admin
platform_support
partner_admin
tenant_owner
tenant_admin
manager
user
agent
viewer
auditor
integrator
api_client
guest
```

Rules:

1. `platform_owner` must be rare, strongly authenticated, audited, and not used for daily support.
2. `platform_admin` should be decomposed by permission groups; it should not automatically grant unrestricted tenant data access.
3. `platform_support` should be restricted, assignable by support scope, time-bound where practical, and audited.
4. `tenant_owner` cannot access other tenants, assign platform roles, or bypass platform policy.
5. `tenant_admin` cannot manage users above its own authority and may be restricted from billing/security/export.
6. `manager`, `agent`, and `user` roles must not inherit administrative powers merely because they operate workflows.
7. `viewer` is read-only but may still be restricted from sensitive fields.
8. `auditor` is read-only and cannot alter the records being audited.
9. `integrator` manages technical configuration but should not automatically access private content.
10. `api_client` must have explicit scopes, expiry/rotation/revocation, rate limits where applicable, and separate audit identity.

---

## 7. Permission Naming and Lifecycle

Permissions must be stable and migration-safe. Do not rename casually.

Recommended resource/action format:

```text
<resource>.<action>
<module>.<resource>.<action>
<system>.<resource>.<action>
```

Permission metadata should include:

| Field | Purpose |
|---|---|
| `key` | Stable machine key. |
| `resource` | Protected resource family. |
| `action` | Operation. |
| `description` | Human explanation. |
| `risk_level` | low, medium, high, critical. |
| `scope_types` | Allowed scopes. |
| `assignable` | Whether it may be assigned through UI/custom roles. |
| `system_only` | Whether tenant users may never assign it. |
| `deprecated_at` | Retirement marker. |
| `replacement_key` | Migration target if replaced. |

---

## 8. Scope Rules

### 8.1 Scope Evaluation

Authorization must evaluate permission and scope together. `users.update` at tenant A does not apply to tenant B.

### 8.2 Scope Inheritance

Inheritance must be explicit and documented.

Example hierarchy:

```text
platform > organization > tenant > workspace > project > resource > field
```

If inheritance is unsupported, require direct assignment at the requested scope.

### 8.3 Scope Containment

Never trust client-supplied IDs to prove containment. The backend must verify that resources belong to the asserted tenant/workspace/project.

### 8.4 Cross-Scope Access

Cross-tenant, cross-organization, or cross-project access requires explicit permission and audit. Accidental cross-scope access through guessed IDs, weak filters, shared URLs, or incomplete joins is a critical defect.

### 8.5 Single-Tenant / Non-SaaS Adjustment

A non-SaaS product may use `global`, `workspace`, `project`, `resource`, and `self` scopes without tenant constructs. Do not fake multi-tenancy if the product does not need it. Preserve the concept of scope so the model can evolve.

---

## 9. Policy Conditions

RBAC grants candidate permission. Policy conditions decide whether the permission is valid for the request.

Common attributes:

| Attribute type | Examples |
|---|---|
| Subject | user ID, role, tenant membership, MFA state, status, team, department. |
| Resource | owner, tenant, workspace, project, status, classification, sensitivity, lock state. |
| Action | read, update, export, publish, delete, assign, revoke, impersonate. |
| Environment | IP range, region, time, risk score, device trust, maintenance mode. |
| Entitlement | plan, module, license, feature flag, usage limit, billing status. |
| Workflow | approval status, lifecycle state, assignment, queue membership. |

Policy examples:

```text
Allow content.update if actor has content.update at project or tenant scope, resource belongs to that scope, content is not locked, and actor is assigned to the resource or has content.manage.
```

```text
Allow billing.manage if actor has billing.manage at tenant scope, tenant billing is not platform-managed, actor is not impersonating, and actor has passed MFA.
```

```text
Allow audit_logs.read if actor has audit_logs.read at platform or tenant scope, requested log scope is contained within actor scope, and sensitive fields are redacted unless actor has audit_logs.read_sensitive.
```

---

## 10. Application Surfaces

Applications may expose different surfaces as separate apps, route groups, modules, shells, or adaptive interfaces.

| Surface | Purpose |
|---|---|
| Public / Anonymous Surface | Public pages, forms, documentation, marketing, guest flows. |
| Authenticated Workspace | Ordinary user work. |
| Tenant / Account Administration | Users, settings, workflows, tenant resources. |
| Platform Administration | Platform operations, tenants, policies, support, compliance. |
| Partner / Reseller Console | Delegated customer/tenant/licensing management. |
| Developer / Integration Console | APIs, webhooks, connectors, service accounts. |
| Audit / Compliance Console | Logs, evidence, reports, immutable records. |
| Dev / Test Tools | Non-production diagnostics and previews. |

No single interface should expose irrelevant or unauthorized features to every user.

---

## 11. Capability-Driven UI

The UI must use capability metadata rather than hardcoded role checks.

Every protected UI item should declare:

```text
capability_key
label
route_or_action
required_permission
required_scope
feature_or_module_dependency
visibility_policy
enabled_policy
status: active | planned | disabled | hidden | dev_only
```

UI gating rules:

1. If the actor lacks permission, hide the item unless product design intentionally shows locked features.
2. If the tenant/account lacks entitlement, show disabled or hidden according to product policy.
3. Planned features may only appear as clearly marked roadmap placeholders.
4. `dev_only` capabilities must never render in production.
5. Disabled or hidden UI controls never replace backend authorization.

---

## 12. Backend Enforcement Standard

Every protected request must pass through centralized authorization.

Minimum enforcement points:

- route middleware or front-controller guard;
- controller/action policy check;
- service-layer policy check for sensitive operations;
- repository/query scope enforcement;
- API endpoint authorization;
- background job authorization context;
- file/object download authorization;
- import/export/report authorization;
- billing and integration authorization;
- field-level redaction where required.

A feature is not complete if authorization only exists in the UI.

---

## 13. Data Model Reference

The exact schema may vary, but these concepts should exist.

```text
actors / users
- id
- email / username
- display_name
- status
- auth_provider
- mfa_status
- created_at
- updated_at
```

```text
tenants / organizations / accounts (when applicable)
- id
- name
- status
- plan_id
- owner_actor_id
- created_at
- updated_at
```

```text
roles
- id
- key
- name
- description
- role_category
- is_system_role
- is_assignable
- created_at
- updated_at
```

```text
permissions
- id
- key
- resource
- action
- description
- risk_level
- scope_types
- system_only
- created_at
- updated_at
```

```text
role_permissions
- role_id
- permission_id
```

```text
role_assignments
- id
- actor_id
- role_id
- scope_type
- scope_id
- assigned_by
- starts_at
- expires_at
- created_at
- revoked_at
```

```text
policy_rules
- id
- key
- permission_key
- effect: allow | deny
- condition_expression
- priority
- enabled
```

```text
audit_events
- id
- actor_id
- effective_actor_id
- tenant_id / organization_id where applicable
- scope_type
- scope_id
- action
- resource_type
- resource_id
- decision: allow | deny
- reason
- ip_address
- user_agent
- request_id
- metadata_json
- created_at
```

---

## 14. Super Admin, Platform Owner, and Break-Glass Rules

Highest-level access is dangerous and must be constrained.

Rules:

1. Platform owner or super-admin roles must be rare.
2. Strong authentication is mandatory.
3. Every privileged action must be audited.
4. Platform roles must not be assignable by tenant administrators.
5. Platform permissions must not leak into tenant-created custom roles.
6. Super-admin access must not be used for routine support workflows.
7. Break-glass access must be time-bound, logged, reviewed, and clearly labeled.
8. Impersonation must never hide original actor identity.

---

## 15. Impersonation and Delegated Access

Impersonation is high-risk.

Rules:

- Requires explicit permission such as `users.impersonate`.
- Records both original actor and effective actor.
- Shows obvious UI banner/state while active.
- Is time-limited and revocable.
- Blocks billing changes, MFA changes, password changes, API token creation, role changes, destructive exports, and security-policy changes unless explicitly approved by policy.
- Is auditable by platform administrators and, where appropriate, tenant owners.

---

## 16. Separation of Duties

Some permission combinations should be blocked or reviewed.

| Combination | Risk |
|---|---|
| `billing.manage` + audit tampering permissions | Financial manipulation. |
| `roles.assign` + `permissions.manage` | Privilege escalation. |
| `users.impersonate` + `api_tokens.create` | Covert persistent access. |
| `content.approve` + `content.publish` | Workflow bypass when separation is required. |
| `security.configure` + audit mutation | Security evidence tampering. |

Enforce with role constraints, policy rules, approval workflows, or audit alerts.

---

## 17. Field-Level and Record-Level Access

Use field-level access for sensitive data:

- PII;
- financial data;
- health/regulatory data;
- credentials and secrets;
- security settings;
- billing identifiers;
- internal notes;
- private communications;
- audit-sensitive metadata.

Use record-level access when resources have ownership, assignment, tenant boundaries, lifecycle state, confidentiality, or project membership.

Backend must enforce redaction/masking. UI must reflect it safely.

---

## 18. API and Service Account Authorization

API clients and service accounts must use the same access-control model, with machine-specific controls.

Required:

- explicit permissions;
- explicit scopes;
- expiration or rotation policy;
- revocation mechanism;
- audit identity;
- last-used tracking;
- rate limits where applicable;
- secret storage rules;
- environment separation;
- no broad inheritance from human roles unless delegated explicitly.

---

## 19. Public, Guest, and Anonymous Access

Public access is an explicit access state, not the absence of security.

Public routes/resources should be marked:

```yaml
access: public
```

Rules:

1. Public access must be intentional and documented.
2. Guest access should be scoped to invitation, token, link, project, resource, or time window.
3. Public previews, file links, forms, exports, and share links must not expose private tenant data.
4. Rate limits and abuse controls should be considered for public/anonymous operations.

---

## 20. Tenant and Boundary Isolation

Multi-tenant systems must enforce boundary isolation at every layer.

Required checks:

- tenant/account context is part of authorization context;
- database queries filter by tenant/scope;
- resource IDs are verified against expected scope;
- background jobs carry tenant/scope context;
- cache keys include tenant/scope where tenant data is cached;
- file/object storage paths are tenant-aware;
- audit logs include tenant/scope;
- API tokens are tenant-scoped unless explicitly platform-scoped;
- cross-tenant support access is explicit and audited.

Single-tenant systems must still enforce ownership, project, resource, self, or module boundaries where they exist.

---

## 21. Route and Endpoint Classification

Every route, endpoint, command, job, and file/download entrypoint should be classified.

| Classification | Meaning |
|---|---|
| Public | No authentication required; intentionally public. |
| Authenticated | Login/session/token required; no special permission. |
| Permissioned | Specific permission and scope required. |
| Privileged | High-risk operation; audit and possibly step-up/MFA required. |
| Internal | Internal jobs/services only; never publicly routable. |
| Dev Only | Development/testing only; disabled in production. |

Routes without classification should fail review.

---

## 22. Dev-Only and Non-Production Surfaces

Rules:

- Dev-only routes are explicitly marked.
- Dev-only routes are disabled in production.
- Dev-only pages do not expose secrets, credentials, production data, or destructive actions.
- Dev-only menu items do not render in production.
- Availability is tested.
- Pages display a non-production warning.

Examples:

```text
/ui-demo
/status
/debug/routes
/debug/policies
/dev/capabilities
/dev/mail-preview
```

`/status` may be production-safe only if explicitly designed to expose minimal information.

---

## 23. Auditing Standard

Minimum audited events:

- login success/failure;
- logout;
- MFA change;
- password change;
- role assignment/revocation;
- permission change;
- tenant/account creation/update/archive;
- user creation/update/deactivation;
- impersonation start/end;
- billing changes;
- integration/API token creation/revocation;
- data export/import;
- destructive delete/archive/restore;
- security policy change;
- failed privileged authorization attempts.

Audit records must be append-only from the application perspective. Retention, redaction, and purge must use explicit compliance tooling.

---

## 24. Error Handling and Denial Behavior

Rules:

- Unauthenticated requests receive authentication challenge/redirect.
- Authenticated unauthorized requests receive forbidden response.
- Do not reveal resource existence if that leaks information.
- Denied API responses are structured and consistent.
- Denied UI actions explain insufficient permission without exposing sensitive policy details.
- Privileged denials are logged.

Example API response:

```json
{
  "error": "forbidden",
  "message": "You do not have permission to perform this action.",
  "required_permission": "users.update",
  "request_id": "..."
}
```

Omit `required_permission` in production if it would reveal sensitive policy information.

---

## 25. Administrative UI Requirements

Administration surfaces should distinguish:

- role definition;
- role assignment;
- permission grant;
- effective permission;
- scope;
- policy denial;
- entitlement denial;
- inherited permission;
- custom role;
- system role.

Required capabilities for mature products:

- view users and assignments;
- assign/revoke roles within allowed scope;
- view role and permission definitions;
- show effective permissions;
- prevent privilege escalation;
- prevent self-lockout for owner roles;
- audit all changes;
- show safe denial reasons.

---

## 26. Custom Roles

Custom roles may be allowed only within boundaries.

Rules:

1. Custom roles are scoped to tenant, organization, workspace, project, or another bounded scope.
2. Custom roles cannot include platform-only permissions.
3. The creator cannot grant permissions they do not possess.
4. System roles are not editable by tenant users.
5. Role deletion is blocked while active assignments exist unless safe reassignment is handled.
6. Creation, update, and deletion are audited.

---

## 27. Implementation Architecture

A clean implementation should include:

| Component | Responsibility |
|---|---|
| Authorization Service | Main `can(...)` or equivalent decision API. |
| Decision Object | `allowed`, `reason`, `matched_role`, `matched_permission`, `scope`, `policy`. |
| Policy Registry | Registers policy rules by permission/resource/action. |
| Capability Registry | Defines UI/navigation/workflow capabilities and required permissions. |
| Scope Resolver | Verifies containment, ownership, and inherited scope. |
| Entitlement Resolver | Evaluates plan/module/license/feature eligibility. |
| Audit Logger | Records security-relevant events. |
| Middleware / Guard | Enforces route/API access. |
| Query Guard | Enforces tenant/scope filters in data access. |
| Seeder / Migration Layer | Creates roles, permissions, and baseline assignments deterministically. |
| Test Matrix | Proves allowed and denied cases. |

Recommended authorization method shape:

```text
can(actor, permission, resource = null, scope = null, context = []): Decision
```

---

## 28. New Project Implementation Flow

1. Create `/docs/access-control-reference.md` from this file.
2. Create `/docs/access-control-mapping.md` for project-specific scope, roles, permissions, surfaces, route classification, and implementation adapter.
3. Choose maturity level and document deferred levels.
4. Define actors, scopes, resources, permissions, baseline roles, and capabilities.
5. Implement central authorization service and decision object.
6. Implement route/API guards.
7. Implement scope resolver and query/data guards.
8. Implement capability-driven UI gating.
9. Implement audit events for privileged operations.
10. Seed baseline roles/permissions.
11. Add tests for allowed and denied access.
12. Create route inventory and permission inventory.

---

## 29. Existing Project Refactoring Flow

1. Inventory current role checks, route guards, middleware, policies, admin screens, API endpoints, and direct data queries.
2. Classify existing routes and endpoints.
3. Map legacy roles to role categories.
4. Map legacy checks to permissions.
5. Identify tenant/ownership/project/resource boundaries.
6. Identify high-risk gaps: frontend-only authorization, guessed ID access, missing tenant filters, super-admin overuse, unaudited role changes, exposed dev routes.
7. Create compatibility shims when needed; do not break valid users abruptly.
8. Migrate feature by feature to central authorization.
9. Preserve behavior with tests before changing it.
10. Add negative tests for each migrated path.
11. Remove obsolete ad hoc checks only after central policy coverage exists.
12. Update documentation and inventories.

---

## 30. Testing Standard

Required test categories:

1. Permission grants work only within assigned scope.
2. Cross-tenant/cross-scope access is denied.
3. Guessed IDs outside scope are denied.
4. Frontend-hidden actions are denied server-side.
5. Role assignment cannot exceed actor authority.
6. Platform-only permissions cannot be assigned by tenant admins.
7. Impersonation preserves original actor in audit logs.
8. API tokens cannot exceed granted scopes.
9. Public routes are explicitly classified.
10. Dev-only routes are unavailable in production.
11. Field-level redaction works where required.
12. Denied privileged attempts are logged.
13. Platform-owner/super-admin actions are audited.
14. Custom roles cannot create privilege escalation.
15. Negative tests exist for high-risk permissions.
16. Background jobs carry proper scope.
17. File downloads and exports are authorized.
18. Capability UI state matches backend authorization.

A feature is not complete unless its authorization tests are included in the same implementation pass or the deferral is documented as a risk.

---

## 31. Review Checklist

Before accepting an access-control implementation:

- [ ] Protected routes/endpoints are classified.
- [ ] Protected APIs enforce server-side authorization.
- [ ] UI navigation/action visibility is capability-driven.
- [ ] Missing permission denies by default.
- [ ] Scope/tenant/resource isolation is enforced in query/data access.
- [ ] Role assignments include scope where applicable.
- [ ] Permissions use stable `resource.action` names.
- [ ] High-risk permissions are identified.
- [ ] Platform roles cannot be assigned by tenant admins.
- [ ] Service accounts/API clients have explicit scopes.
- [ ] Impersonation is audited and visibly indicated.
- [ ] Dev-only routes are disabled in production.
- [ ] Audit logging captures privileged changes.
- [ ] Tests include positive and negative cases.
- [ ] Documentation matches implementation.
- [ ] No frontend-only authorization exists.
- [ ] Existing behavior was preserved or intentionally migrated.

---

## 32. Minimum Acceptable MVP

For serious applications, the minimum access-control foundation includes:

1. authenticated actors;
2. roles;
3. permissions;
4. scoped role assignments where scope exists;
5. central authorization service;
6. route/API guards;
7. boundary isolation if multi-user, multi-project, or multi-tenant;
8. capability-driven menu/action visibility;
9. audit log for privileged actions;
10. positive and negative tests;
11. dev-only route blocking in production;
12. documented roles, permissions, scopes, and routes.

Without this, the application may have login, but it does not have a reliable access-control architecture.

---

## 33. Anti-Patterns

Reject these patterns:

- checking only `is_admin` everywhere;
- storing permissions only in frontend code;
- relying on hidden buttons as security;
- trusting tenant IDs or owner IDs from request input;
- giving support staff unrestricted tenant data access by default;
- allowing tenant admins to assign platform roles;
- mixing billing, security, support, and export powers into one broad role by default;
- adding routes before classifying access;
- creating one-off roles for every customer request;
- allowing API tokens to inherit unlimited human access;
- skipping audit logs for role/permission changes;
- exposing dev/debug pages in production;
- allowing impersonation without visibility and logs;
- merging feature work without authorization tests;
- placing authorization only in controllers while background jobs, exports, and files bypass policy;
- implementing custom roles before stable system permissions exist.

---

## 34. Required Repository Artifacts

Recommended documentation files:

```text
/docs/access-control-reference.md
/docs/access-control-mapping.md
/docs/access-control-permission-inventory.md
/docs/access-control-route-inventory.md
/docs/access-control-review-checklist.md
/docs/access-control-test-matrix.md
```

AI Coding Companions must update these artifacts when access-control implementation changes.

---

## 35. Standard Prompt Fragment

Use this fragment in implementation prompts when access control is involved:

```text
ACCESS CONTROL FOUNDATION REQUIREMENT:
Before implementing, read /docs/access-control-reference.md and /docs/access-control-mapping.md if present. Inspect existing authentication, authorization, roles, permissions, route guards, policies, capability metadata, audit logs, and tests. Reuse or extend existing access-control structures before creating new ones. Enforce backend authorization; UI gating is not sufficient. Preserve valid existing behavior, add positive and negative tests, update route/permission inventories, and report any deferred security risk.
```

---

## 36. Final Standard

An application is access-control compliant only when authorization is centralized, deny-by-default, scoped where scope exists, policy-aware where context matters, audited for privileged operations, reflected in the UI, enforced server-side on every protected operation, and proven by tests.

Roles are administrative conveniences. Permissions are enforceable grants. Scopes define where grants apply. Policies decide whether grants apply in context. Capabilities reflect decisions in the UI. The backend enforces decisions. The audit log records important events. Tests prove correctness.

---

## QLi v2 Addendum — Minimum ACL Spine

When ACL is triggered, implement a minimum authorization spine before privileged product behavior spreads through the codebase.

Minimum ACL spine evidence:

- Actor model: anonymous, authenticated user, admin/operator, service account, or other project-specific actors.
- Resource/action naming convention, preferably `resource.action`.
- Protected route/endpoint classification.
- Server-side policy/guard/scope interface.
- Deny-by-default behavior for protected operations.
- Seed role/permission model when roles are used.
- Positive and negative test pattern for protected actions.
- Permission-denied UI/API behavior.

Advanced role builders, field-level access, impersonation, and enterprise access review are profile-triggered capabilities, not mandatory for every project.

## Buildline Implementation Control

This foundation is governed operationally by `.qli/acl/specs/acl-implementation-control.md`.

Use the full reference for doctrine and vocabulary. Use the implementation-control file for the project-agnostic minimum spine, optional capability rules, deferral rules, evidence expectations, test/smoke expectations, common AI-agent failure modes, and definition of done.

Project-specific applicability is not decided inside this reference file. It is decided through `.qli/binding/` and recorded in `.qli/project/foundation-applicability.yml`.
