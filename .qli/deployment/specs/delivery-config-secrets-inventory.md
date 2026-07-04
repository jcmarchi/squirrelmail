# Delivery Configuration and Secrets Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/delivery-config-secrets-inventory.md`

## Configuration Values

| Key | Purpose | Required? | Default | Environments | Safe to Commit? | Notes |
|---|---|---|---|---|---|---|
| APP_ENV | Runtime environment | yes | local | all | yes in example only | |
| APP_URL | Base URL | yes | http://localhost | all | yes in example only | |

## Secrets

| Secret Key | Purpose | Required? | Source | Rotation | Logged? | Notes |
|---|---|---|---|---|---|---|
| DB_PASSWORD | Database access | prod yes | env/secret store | [policy] | never | |
| APP_KEY | Encryption/signing | yes | generated secret | [policy] | never | |

## Rules

- Real secrets must never be committed.
- `.env.example` must contain placeholders only.
- Missing required secrets must fail safely.
- Secrets must never be printed in logs, errors, debug screens, or telemetry.
