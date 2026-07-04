# QLi Foundation Namespace Policy

## Purpose

This policy defines the canonical server-side and project-local namespace for DevBox-managed foundation material. It ensures that every DevBox-managed project has a predictable, non-invasive home for DevBox operational doctrine without polluting the project's own documentation or source structure.

---

## Server-side canonical foundation library

The canonical server-side installed foundation library lives at:

```
/srv/dev/foundation/
```

This path is the authoritative source of DevBox foundation modules installed on a live DevBox server. It is not a project folder. It contains versioned, server-managed foundation material that can be referenced or copied into managed projects.

---

## The `.qli/` reserved namespace

`.qli/` is the reserved QLi project namespace inside any DevBox-managed project repository.

This namespace:

- is not part of the project's product, application, or API.
- is DevBox and QLi tooling infrastructure.
- should be excluded from application builds and deployment artifacts.
- should be tracked in version control for the managed project so that DevBox doctrine travels with the project.

---

## Mandatory project-local locations

Every DevBox-managed project must contain these two paths:

### `.qli/foundation/devbox/`

The project-local copy of DevBox foundation material.

- Sourced from `/srv/dev/foundation/` on the server.
- Contains DevBox onboarding doctrine, port block assignment, route generation context, and operational rules applicable to this project.
- Must be present before DevBox onboarding work begins.
- Must be read by any AI Coding Agent operating inside a managed project.

The required directory structure, per-file purpose, allowed and forbidden contents, `MANIFEST.md` required fields, and update policy are defined in `products/_shared/QLI_PROJECT_LOCAL_FOUNDATION_SCHEMA.md`. Starter templates for `README.md` and `MANIFEST.md` are in `products/_shared/templates/qli-foundation-devbox/`. These templates must be used when initializing `.qli/foundation/devbox/` during onboarding Step 5.

### `.qli/project/`

Project-local runtime and onboarding metadata managed by DevBox.

- Contains port block assignment records, route registration state, onboarding reports, and any project-specific overrides required for DevBox operation.
- Does not contain application-level configuration or product documentation.
- Is DevBox-owned metadata, not project-owned product data.

The required files and their schema are defined in `products/_shared/QLI_PROJECT_METADATA_SCHEMA.md`. Starter templates are in `products/_shared/templates/qli-project/`. These files must be used when initializing `.qli/project/` during onboarding.

---

## Foundation namespace expansion paths

The `.qli/foundation/` namespace is designed for future expansion. Reserved paths include:

| Path | Intended purpose |
|---|---|
| `.qli/foundation/devbox/` | DevBox environment and runtime doctrine (active) |
| `.qli/foundation/ui/` | UI framework and design system foundation |
| `.qli/foundation/api/` | API contract and interface foundation |
| `.qli/foundation/data/` | Data schema and migration foundation |
| `.qli/foundation/security/` | Security policy and secret management foundation |
| `.qli/foundation/testing/` | Test harness and smoke-check foundation |
| `.qli/foundation/observability/` | Logging, metrics, and tracing foundation |
| `.qli/foundation/runtime/` | Generic runtime and container configuration foundation |

Only `.qli/foundation/devbox/` is active in the current doctrine cycle. Other paths are reserved and must not be populated without a corresponding policy document.

---

## Rule: `/docs/` is not the default foundation location

`/docs/` in a project repository belongs to the project's own product and technical documentation.

DevBox operational doctrine must not be placed under `/docs/devenv/`, `/docs/devbox/`, or any other subdirectory of `/docs/` by default.

The only exception is when the project owner explicitly approves placing DevBox operational material under `/docs/` and that decision is documented in `.qli/project/` metadata.

This separation prevents DevBox infrastructure from polluting the project's product documentation, makes DevBox material predictably discoverable, and respects the project's documentation ownership.
