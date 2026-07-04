# QLi Project-Local Foundation Schema

## Purpose

This document defines the mandatory `.qli/foundation/devbox/` structure that must be present in every DevBox-managed project repository. It specifies what files are required, what each file's purpose is, and what the directory is and is not.

Starter templates for `README.md` and `MANIFEST.md` are provided in `products/_shared/templates/qli-foundation-devbox/`.

---

## What `.qli/foundation/devbox/` is

`.qli/foundation/devbox/` is:

- the project-local DevBox foundation snapshot, copied from `/srv/dev/foundation/devbox/current/` at onboarding time;
- a reference copy that travels with the project in version control, making DevBox operational doctrine available to any contributor or AI Coding Agent without requiring server access;
- a snapshot of the DevBox Foundation as it existed at the time of onboarding — it records which version of the foundation the project was onboarded against;
- safe to commit to private managed-project repositories;
- DevBox-owned infrastructure material, not the project's own product content.

`.qli/foundation/devbox/` is **not**:

- application product documentation;
- a secrets directory;
- a place for project-specific runtime values, environment values, or port assignments (those belong in `.qli/project/`);
- a replacement for the project's own `AGENTS.md`, `README.md`, `SETUP.md`, architecture decisions, API contracts, data models, or product roadmap;
- a generated artifact or Docker runtime state location;
- a Caddy configuration directory.

---

## Required structure

Every DevBox-managed project must contain the following structure under `.qli/foundation/devbox/`:

```
.qli/foundation/devbox/
  README.md
  MANIFEST.md
  QLI_FOUNDATION_NAMESPACE_POLICY.md
  DEVENV_FOUNDATION_POLICY.md
  PORT_BLOCK_POLICY.md
  PROJECT_ONBOARDING_DOCTRINE.md
  QLI_PROJECT_METADATA_SCHEMA.md
  templates/
    qli-project/
      manifest.yml.example
      port-block.env.example
      runtime-overrides.md.example
      routes.md.example
      onboarding-report.md.example
      smoke-checks.md.example
```

---

## File-by-file purpose

### `README.md`

Explains what `.qli/foundation/devbox/` is, what it governs, what it does not govern, and where project-specific metadata and secrets must not live. This is the entry-point document for any contributor or AI agent who encounters this directory for the first time.

Use the template at `products/_shared/templates/qli-foundation-devbox/README.md.example`.

### `MANIFEST.md`

Machine-readable and human-readable record of where this foundation snapshot came from. Records the source repository, branch, commit, server path, installation date, installer role, and foundation schema version. This is the audit trail that connects the project-local snapshot to the QLI-DevBox repository state it was sourced from.

Use the template at `products/_shared/templates/qli-foundation-devbox/MANIFEST.md.example`.

Required fields (see schema below).

### `QLI_FOUNDATION_NAMESPACE_POLICY.md`

Copied from `products/_shared/QLI_FOUNDATION_NAMESPACE_POLICY.md`. Defines the `.qli/` reserved namespace, the canonical server-side foundation library path, and the project-local location rules.

### `DEVENV_FOUNDATION_POLICY.md`

Copied from `products/_shared/DEVENV_FOUNDATION_POLICY.md`. Defines what DevBox Foundation governs and does not govern, the installation model, and the non-invasive onboarding principle.

### `PORT_BLOCK_POLICY.md`

Copied from `products/_shared/PORT_BLOCK_POLICY.md`. Defines mandatory port block policy, host binding rules, database exposure rules, and the Caddy ingress rule.

### `PROJECT_ONBOARDING_DOCTRINE.md`

Copied from `products/_shared/PROJECT_ONBOARDING_DOCTRINE.md`. Defines the standard 15-step onboarding sequence.

### `QLI_PROJECT_METADATA_SCHEMA.md`

Copied from `products/_shared/QLI_PROJECT_METADATA_SCHEMA.md`. Defines the required files under `.qli/project/`, their schemas, forbidden contents, and template locations.

### `templates/qli-project/`

Copied from `products/_shared/templates/qli-project/`. Contains the six starter templates for `.qli/project/` file initialization. See `QLI_PROJECT_METADATA_SCHEMA.md` for usage instructions.

---

## `MANIFEST.md` required fields

The `MANIFEST.md` file inside `.qli/foundation/devbox/` must include the following fields:

| Field | Purpose |
|---|---|
| `installed_from_repository` | Full URL of the QLI-DevBox repository this snapshot was sourced from. |
| `installed_from_branch` | Branch in the QLI-DevBox repository at time of installation. |
| `installed_from_commit` | Commit SHA in the QLI-DevBox repository at time of installation. |
| `installed_from_server_path` | Absolute path on the live DevBox server that was copied (`/srv/dev/foundation/devbox/current/`). |
| `installed_at` | ISO 8601 date and time of installation. |
| `installed_by_role` | Role of the operator who performed the installation (e.g., `DevBox Operator`). No personal usernames or identifiers. |
| `foundation_schema_version` | Schema version identifier from the source foundation material. |
| `included_files` | List of files and directories included in this snapshot. |
| `notes` | Optional notes about deviations, partial installs, or known differences from canonical. |

---

## Hard rules for `.qli/foundation/devbox/`

The following content is **never permitted** in any file under `.qli/foundation/devbox/`:

- Passwords, credentials, API keys, tokens, or auth hashes
- WireGuard client configuration or private key material
- Private operator usernames or personal identifiers
- Live production hostnames or domain values
- Private IP addresses (private RFC1918 address ranges or VPN/tunnel addresses)
- Project-specific environment values or runtime configuration
- Generated Caddy configuration fragments
- Docker runtime state or container metadata
- Certificate private keys or TLS secrets
- Any value that, if leaked, would compromise the live server or an operational account

`.qli/foundation/devbox/` is allowed to contain:

- sanitized doctrine files copied from `products/_shared/`
- schema files
- starter templates using `<PLACEHOLDER>` values
- `MANIFEST.md` with installation metadata (non-secret source commit references, dates, roles)
- `README.md` explaining the directory

---

## Relationship between locations

| Location | Role |
|---|---|
| `/srv/dev/foundation/devbox/current/` | Canonical live server library. Maintained by the DevBox operator. Updated when the DevBox platform version advances. Source of truth for all project-local snapshots. |
| `.qli/foundation/devbox/` | Project-local copied snapshot. Sourced from `/srv/dev/foundation/devbox/current/` at onboarding time. Travels with the project in version control. Read by contributors and AI agents without needing server access. |
| `.qli/project/` | Project-specific onboarding metadata and runtime configuration records. Contains the items that are unique to this project: port block assignment, override strategy, route intent, onboarding report, smoke-check results. Defined by `QLI_PROJECT_METADATA_SCHEMA.md`. |

These three locations are distinct. Material must not be mixed between them. Project-specific values go in `.qli/project/`, never in `.qli/foundation/devbox/`.

---

## Update policy

When `/srv/dev/foundation/devbox/current/` is updated on the live server (e.g., after a new QLI-DevBox release cycle), managed projects should receive an updated `.qli/foundation/devbox/` snapshot through a deliberate update step. Updates are not automatic. The updated `MANIFEST.md` must record the new source commit and installation date.

Updates to `.qli/foundation/devbox/` do not require repeating the full onboarding sequence. They are a documentation refresh, not a re-onboarding event.
