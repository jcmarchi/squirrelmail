# Data Schema Evolution Log

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Location:** `.qli/data-schema-evolution-log.md`  
**Purpose:** Track schema changes, compatibility, migration plans, and contract versions.

| Date | Entity/Schema | Change | Compatibility | Migration Required | Contract Version | Tests | Notes |
|---|---|---|---|---|---|---|---|
| YYYY-MM-DD | [entity] | [change] | additive/breaking | yes/no | v1 -> v2 | [tests] | |

## Change Template

```text
Change:
Reason:
Affected entities:
Affected APIs/events/imports/exports:
Backward compatibility:
Read path transition:
Write path transition:
Dual-write needed:
Backfill needed:
Rollback plan:
Data validation plan:
Contract version impact:
Tests:
Approval / ADR:
```
