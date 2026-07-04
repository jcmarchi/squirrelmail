# Access Control Review Checklist

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `/docs/access-control-review-checklist.md`  
**Purpose:** Human and AI review checklist before accepting access-control implementation.

## Architecture

- [ ] Access-control reference exists at `/docs/access-control-reference.md`.
- [ ] Project mapping exists at `/docs/access-control-mapping.md`.
- [ ] Maturity level is documented.
- [ ] Authorization is centralized.
- [ ] Missing permission denies by default.
- [ ] Roles are administration concepts; permissions are enforcement concepts.
- [ ] Scopes are used where scope exists.

## Enforcement

- [ ] Protected routes are classified.
- [ ] Protected API endpoints enforce server-side authorization.
- [ ] Service-layer checks exist for sensitive operations.
- [ ] Repository/query guards enforce tenant/scope boundaries.
- [ ] File downloads, exports, imports, background jobs, and webhooks are governed.
- [ ] UI gating is not the only enforcement layer.

## Security Boundaries

- [ ] Cross-tenant/cross-scope access is denied by tests.
- [ ] Client-supplied IDs are not trusted for containment.
- [ ] Platform roles cannot be assigned by tenant admins.
- [ ] Custom roles cannot include forbidden/system-only permissions.
- [ ] Service accounts and API clients have explicit scopes.
- [ ] Public/anonymous access is explicit and documented.

## Privileged Operations

- [ ] Role assignment/revocation is audited.
- [ ] Permission changes are audited.
- [ ] Impersonation is audited and visibly indicated if supported.
- [ ] Billing/security/export/destructive actions are audited.
- [ ] Dev-only routes are disabled in production.
- [ ] Step-up/MFA is considered for critical operations.

## UI and Capabilities

- [ ] Menus/routes/actions are capability-driven where applicable.
- [ ] UI reflects permission and entitlement states.
- [ ] Locked/disabled features do not leak sensitive details.
- [ ] Unauthorized users do not see irrelevant administrative surfaces unless intentionally shown as locked.

## Testing

- [ ] Positive tests exist for allowed cases.
- [ ] Negative tests exist for denied cases.
- [ ] Cross-scope tests exist.
- [ ] Privileged denial tests exist.
- [ ] Route classification is tested or reviewed.
- [ ] Documentation matches implementation.
