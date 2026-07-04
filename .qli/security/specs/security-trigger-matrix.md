# Security Trigger Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Purpose:** Give AI Coding Agents a simple feature-to-control decision chain. When a feature appears here, the listed controls must be implemented, verified, or explicitly deferred.

| Feature / Surface Trigger | Required Security Controls | Required Tests / Checks | Inventory Updates |
|---|---|---|---|
| User login / sessions | Secure cookies, session rotation, logout invalidation, CSRF for browser writes, brute-force limits where practical | login/logout/session/CSRF tests | posture, control inventory, surface inventory |
| Password reset / email auth | Expiring tokens, single-use tokens, no account enumeration, safe email content | token expiry/reuse/enumeration tests | surface inventory, control inventory |
| Admin panel | Route classification, ACL enforcement, privileged audit events, CSRF, safe errors | admin access allowed/denied tests | surface inventory, control inventory |
| Multi-tenancy | Tenant-aware queries, tenant-aware files/cache/logs, scope containment, cross-tenant negative tests | tenant isolation tests | posture, data-protection matrix, control inventory |
| Public file upload | MIME validation, extension allowlist, size limits, storage isolation, randomized names, download authorization, malware scan hook if available | upload rejection/authorization tests | surface inventory, data-protection matrix |
| File download/export | Authorization on download, temporary URLs where applicable, export audit event, sensitive field redaction | unauthorized download/export tests | surface inventory, audit/log inventory |
| API tokens | Hashed tokens, scopes, expiry, revocation, last-used tracking, audit events | token scope/revocation tests | secrets inventory, control inventory |
| Public API | Schema validation, auth policy, rate limiting where available, CORS policy, error envelope | contract/auth/rate tests | surface inventory, API docs |
| Webhook receiver | Signature verification, replay protection, timestamp tolerance, idempotency, secret rotation path | invalid signature/replay/idempotency tests | secrets inventory, surface inventory |
| Billing/payments | Signature validation, idempotency, audit events, least-privilege secrets, safe error handling | payment event tests | secrets inventory, data-protection matrix |
| Public signup | Abuse limits, email verification, tenant provisioning checks, bot/spam controls where practical | signup abuse/verification tests | posture, surface inventory |
| Impersonation/support access | Original actor tracking, visual warning, time limit, audit trail, blocked high-risk actions | impersonation/audit tests | control inventory, surface inventory |
| Dev/debug surface | Environment gating, auth if exposed, no secrets/production data, no destructive actions | production blocking tests | surface inventory |
| Secrets/config change | No source control, no logs, rotation path, environment-specific loading | secret leak scan/smoke checks | secrets inventory |
| Dependency/package change | License/security review, vulnerability check where tooling exists, update log | dependency audit/smoke checks | dependency risk log |
