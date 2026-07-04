# Data Storage Decision Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Location:** `.qli/data-storage-decision-matrix.md`  
**Purpose:** Record why each entity or dataset uses a particular physical storage adapter.

| Entity/Dataset | Business Criticality | Access Pattern | Consistency | Failure Mode | Lifecycle | Recommended Adapter | Rejected Alternatives | Reason | Status |
|---|---|---|---|---|---|---|---|---|---|
| [name] | [criticality] | [pattern] | [model] | [failure mode] | [lifecycle] | [adapter] | [alternatives] | [reason] | proposed |

## Decision Scoring Template

Score each from 1 low to 5 high.

| Dimension | Score | Notes |
|---|---:|---|
| Transaction integrity required |  |  |
| Query complexity |  |  |
| Write volume |  |  |
| Read volume |  |  |
| Search need |  |  |
| Event/replay need |  |  |
| Analytics need |  |  |
| Schema volatility |  |  |
| Tenancy/siloing sensitivity |  |  |
| Retention/audit burden |  |  |

## Required Decision Output

```text
Decision:
Primary Adapter:
Secondary Adapter / Projection:
Reason:
Rejected Alternatives:
Schema Contract:
Migration Impact:
Test Requirements:
```
