# Domain Workflow Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/domain-workflow-inventory.md`

| Workflow Key | Module | Resource / Aggregate | States | Allowed Transitions | Forbidden / Guarded Transitions | Required Permissions | Side Effects | Events | Tests | Status |
|---|---|---|---|---|---|---|---|---|---|---|
| `content.publication` | Content | ContentItem | Draft, Submitted, Approved, Published, Archived | Draft→Submitted, Submitted→Approved, Approved→Published | Published→Draft guarded | content.publish | update projection, notify | ContentPublished | planned | planned |

## Rules

- Do not rely only on database enums or UI dropdowns for lifecycle rules.
- Define transition guards and side effects.
- Include negative tests for invalid transitions.
