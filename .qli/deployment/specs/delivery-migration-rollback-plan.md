# Delivery Migration and Rollback Plan

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/delivery-migration-rollback-plan.md`

## Migration Policy

| Rule | Policy |
|---|---|
| Backward-compatible migrations | Preferred whenever possible |
| Destructive migrations | Require explicit approval, backup, and rollback/forward-fix plan |
| Backfills | Should be separate from schema migrations when risk is meaningful |
| Old-record readability | Must be tested after migration |
| Rollback | Must be documented as reversible, forward-fix, restore-only, or manual |

## Migration Inventory

| Migration | Purpose | Reversible? | Data Risk | Backup Required? | Test Coverage | Rollback / Forward Fix | Notes |
|---|---|---|---|---|---|---|---|
| [migration] | [purpose] | yes/no/forward-only | low/med/high | yes/no | [tests] | [plan] | |

## Release Migration Checklist

- [ ] Backup completed if required.
- [ ] Migration tested locally.
- [ ] Migration tested in staging/demo if available.
- [ ] Old data remains readable.
- [ ] Application code is compatible before and after migration.
- [ ] Rollback or forward-fix path documented.
- [ ] Smoke tests defined.
