# Data Lifecycle Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Location:** `.qli/data-lifecycle-matrix.md`  
**Purpose:** Define lifecycle, retention, deletion, redaction, archival, and sovereignty behavior for project data.

| Entity/Dataset | Lifecycle States | Retention | Delete Behavior | Redaction/Anonymization | Archive Strategy | Audit Required | Residency | Notes |
|---|---|---|---|---|---|---|---|---|
| [entity] | draft/active/archive | [period] | [soft/hard/none] | [policy] | [strategy] | yes/no | [region] | |

## Deletion Decision Terms

| Term | Meaning |
|---|---|
| Hard delete | Physical removal. Allowed only when safe and documented. |
| Soft delete | Hidden from normal use but recoverable. |
| Archive | Retained in inactive state. |
| Redact | Remove or mask sensitive fields. |
| Anonymize | Irreversibly remove identifying data. |
| Immutable | Never update/delete original record; append correction/reversal. |
