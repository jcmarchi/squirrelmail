# Observability Audit Event Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Audit events are accountability records, not ordinary logs. They must be append-only from the application perspective.

| Audit Event | Trigger | Actor Context | Effective Actor | Scope/Tenant | Resource | Decision | Required Fields | Retention | Viewer/Report | Tests | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|
| audit.user.login_succeeded | Successful login | user_id | n/a | tenant if applicable | session/user | allowed | timestamp, actor_id, request_id | [policy] | [surface] | [test] | planned |
| audit.role.assigned | Role assignment | actor_id | effective_actor_id if impersonating | scope_id | role_assignment | allowed | actor, target, role, scope, request_id | [policy] | [surface] | [test] | planned |
