# Security Surface Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


| Surface | Route / Entry Point | Exposure | Auth Required | Permission / Policy | Data Sensitivity | Controls | Tests |
|---|---|---|---:|---|---|---|---|
| Public homepage | `/` | public web | no | public | public | safe rendering | smoke |
| Login | `/login` | public web | no | auth flow | identity | CSRF, rate/abuse where practical | login tests |
| Admin dashboard | `/admin` | authenticated | yes | admin capability | confidential | ACL, audit, CSRF | admin allow/deny |
| API endpoint | `/api/...` | public/private API | yes/no | API policy | varies | schema validation, auth | contract tests |
| Webhook | `/webhooks/...` | public receiver | no/sessionless | signature policy | confidential | signatures, replay, idempotency | webhook tests |
| Dev tool | `/dev/...` | dev only | yes | dev-only | may expose internals | disabled in production | production-block test |
