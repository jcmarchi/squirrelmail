# Security Secrets Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Do not put actual secret values in this file.** Record only secret type, purpose, storage mechanism, owner, rotation path, and exposure risk.

| Secret / Credential | Purpose | Environment | Storage Location | Rotation Path | Owner | Risk | Notes |
|---|---|---|---|---|---|---|---|
| App secret key | session/signing | all | env/config outside webroot | regenerate + invalidate sessions | `[owner]` | critical | |
| Database password | database access | staging/prod | env/host secret | rotate DB user password | `[owner]` | critical | |
| API token secret | external API | prod | env/secret store | provider rotation | `[owner]` | high | |
| Webhook signing secret | webhook verification | prod | env/secret store | provider rotation | `[owner]` | high | |

## Rules

- Never commit secrets.
- Never log secrets.
- Never return secrets to clients after creation except one-time display when required.
- Hash API tokens when feasible.
- Separate development, staging, and production secrets.
- Document rotation and revocation for every production secret.
