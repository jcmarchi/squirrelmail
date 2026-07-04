# Domain Event Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/domain-event-inventory.md`

| Event Key | Module | Event Name | Version | Meaning | Triggering Use Case | Payload Contract | Contains Sensitive Data | Consumers | AsyncAPI / API Contract | Idempotency Key | Tests | Status |
|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `project.created.v1` | Projects | ProjectCreated | v1 | A project was created | CreateProject | TBD | no | notifications, projections | TBD | project_id + version | planned | planned |

## Rules

- Name domain events in past tense.
- Version event payloads.
- Do not leak sensitive fields.
- Consumers must be idempotent.
- Events that cross process boundaries must align with AsyncAPI/API foundation rules.
