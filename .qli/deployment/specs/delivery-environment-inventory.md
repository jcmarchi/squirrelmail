# Delivery Environment Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/delivery-environment-inventory.md`

| Environment | URL / Host | Purpose | Data Source | Secrets Source | Debug Enabled? | Dev Routes? | Smoke Test | Owner | Notes |
|---|---|---|---|---|---|---|---|---|---|
| Local | localhost | Developer work | local/demo | local .env | yes | yes | [command/path] | dev | |
| CI/Test | n/a | Automated tests | test fixtures | CI secrets | no | no | [command] | CI | |
| Demo | [url] | Human architect/stakeholder review | demo seed | env/config | no | limited | [path] | [owner] | |
| Staging | [url] | Production-like validation | staging | managed/env | no | no | [path] | [owner] | |
| Production | [url] | Real users/data | production | protected | no | no | [path] | [owner] | |
