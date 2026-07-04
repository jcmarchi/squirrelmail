# Domain Use Case Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/domain-usecase-inventory.md`

| Use Case Key | Module | Use Case | Type | Purpose | Input | Output | Preconditions | Postconditions | Events Emitted | ACL Needed | UI Surface | API/CLI/Event Trigger | Tests | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `projects.create` | Projects | CreateProject | command | Create a new project/work unit | CreateProjectCommand | CreateProjectResult | actor allowed | project exists | ProjectCreated | yes | Project form | POST /projects | planned | planned |

## Type Values

`command`, `query`, `workflow`, `system`, `scheduled`, `event-handler`.

## Rules

- Every use case must map to business intent.
- Use cases that mutate state must define postconditions and emitted events where applicable.
- User-facing use cases should have a UI review surface.
- Existing use cases discovered during refactoring should be recorded before extraction.
