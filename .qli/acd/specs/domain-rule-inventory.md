# Domain Rule Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/domain-rule-inventory.md`

| Rule Key | Module | Rule Name | Description | Enforced In | Related Use Cases | Related Data | Related ACL | Tests | Status |
|---|---|---|---|---|---|---|---|---|---|
| `project.name.unique_per_tenant` | Projects | Project name uniqueness | Project names must be unique within tenant scope | CreateProject / RenameProject | projects.create, projects.rename | project | tenant scope | planned | planned |

## Rules

- Record meaningful business rules here, especially rules that affect money, compliance, workflow, tenant boundaries, publication, approvals, or safety.
- Do not hide business rules only in comments, migrations, templates, controllers, or helper functions.
