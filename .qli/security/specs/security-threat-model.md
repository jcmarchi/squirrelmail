# Security Threat Model

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Assets

| Asset | Sensitivity | Owner | Notes |
|---|---|---|---|
| `[asset]` | `[public/confidential/PII/financial/secret/regulated]` | `[owner]` | |

## Actors

| Actor | Trust Level | Access Method | Notes |
|---|---|---|---|
| Anonymous visitor | untrusted | public web | |
| Authenticated user | partially trusted | session/API | |
| Administrator | privileged | admin UI | |
| API client | machine principal | token/OAuth | |
| Support/operator | privileged/delegated | admin/support tools | |

## Trust Boundaries

| Boundary | Entry Points | Required Controls |
|---|---|---|
| Browser to server | forms/API | CSRF, validation, auth, secure cookies |
| Public API | REST/webhooks | schema validation, auth, rate limits, safe errors |
| Tenant boundary | tenant records/files/cache/logs | tenant-aware authorization and queries |
| Storage boundary | files/database/cache | path safety, permissions, retention, backups |
| External service boundary | webhooks/integrations | signatures, secrets, idempotency |

## Threats and Mitigations

| Threat | Surface | Impact | Mitigation | Status |
|---|---|---|---|---|
| Cross-tenant access | queries/files/cache | critical | tenant containment tests | planned |
| XSS | rendered UI | high | output escaping, CSP where practical | planned |
| CSRF | forms/admin | high | CSRF tokens, SameSite cookies | planned |
| Secret leakage | logs/errors/repo | critical | secrets inventory, safe logging | planned |
| Unsafe upload | upload/download | high | validation, isolation, auth | not applicable |
