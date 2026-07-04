# Domain Module Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/domain-module-inventory.md`

| Module Key | Module Name | Purpose | Business Owner | Status | Core Path | Data Entities | API Contracts | UI Surfaces | ACL/Security Notes | Tests | Notes |
|---|---|---|---|---|---|---|---|---|---|---|
| `core.identity` | Identity | Users, profiles, invitations, account lifecycle | TBD | planned | TBD | users | TBD | TBD | Requires ACL | TBD | |

## Status Values

`planned`, `active`, `partial`, `deprecated`, `replaced`, `blocked`.

## Rules

- Add every meaningful business/domain module here.
- Do not create a module only because a folder exists.
- Map each module to product value and feature ownership.
- Keep module boundaries stable unless an ADR approves a material split/merge.
