# Data Entity Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Location:** `.qli/data-entity-inventory.md`  
**Purpose:** Track canonical entities, truth status, schema contracts, storage decisions, lifecycle rules, and implementation status.

| Entity | Module | Truth Category | Scope | ID Strategy | Access Pattern | Consistency | Lifecycle | Sensitivity | Storage Adapter | Contract | Status | Notes |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| [entity] | [module] | Record of Truth | [tenant/project/etc.] | UUIDv7/ULID | read-heavy/write-heavy/etc. | strong/eventual/etc. | active/archive/etc. | internal/confidential/etc. | [adapter] | [schema path] | planned | |

## Entity Detail Template

```text
Entity Name:
Business Purpose:
Module / Owner:
Truth Category:
Scope / Tenancy:
Primary Identifier:
External Identifier Exposure:
Access Pattern:
Read/Write Ratio:
Write Contention:
Consistency Requirement:
Failure Mode:
Lifecycle / Retention:
Sensitivity / Classification:
Residency Requirement:
Audit Requirement:
Deletion Behavior:
Schema Contract:
Physical Adapter:
Indexes / Query Shapes:
Events Produced:
Events Consumed:
API Contracts:
Migration Notes:
Tests Required:
```
