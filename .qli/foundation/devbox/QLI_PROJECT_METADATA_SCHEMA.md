# QLi Project Metadata Schema

## Purpose

This document defines the mandatory `.qli/project/` metadata schema for every DevBox-managed project. It specifies the required files, their purpose, required fields or sections, forbidden contents, Git safety, and whether they may contain live environment values.

Template files for each schema entry are provided in `products/_shared/templates/qli-project/` and must be used when initializing `.qli/project/` during onboarding Step 6.

---

## Hard rules for `.qli/project/`

The following content is **never permitted** in any file under `.qli/project/`:

- Passwords, credentials, API keys, tokens, auth hashes
- WireGuard client configuration or private key material
- Private IP addresses (private RFC1918 address ranges, VPN tunnel addresses)
- Live production hostnames or domain values (unless the project is private/internal and the operator explicitly approves — see routes.md exception)
- Private operator usernames or personal identifiers
- Certificate private keys or TLS secrets
- Any value that, if leaked, would compromise the live server or an operational account

`.qli/project/` is allowed to store:

- Project identity (slug, name, type, repo URL)
- Assigned DevBox port block identifier and local port numbers
- Route intent using placeholders
- Override strategy and mechanism description
- Smoke-check results (pass/fail/notes — not credentials)
- Non-secret operational notes and deviation records

If a value is sensitive or environment-specific, store a placeholder and reference the operator-owned runtime location (e.g. `~/.qli/secrets/` or a vault) instead.

---

## Required files

### `.qli/project/manifest.yml`

**Purpose:** Machine-readable identity and onboarding state record for the project. The single authoritative source of what project this is, how it was onboarded, and what DevBox version manages it.

**Git-safe:** Yes. No secrets. Commit to project version control.

**May contain live values:** Project identity fields are allowed (slug, name, repo URL, local path). Port block ID is allowed. Live hostnames must use placeholders unless the operator explicitly approves for a private/internal project.

**Required fields:**

```yaml
qli_schema_version: "1"
# Schema version for this manifest. Increment when the schema changes.

project_slug: ""
# Short identifier, lowercase, hyphens only. Used in route generation and registry.
# Example: my-app

project_name: ""
# Human-readable project name.

project_type: ""
# One of: web-app, api-service, tool, library, monorepo, other

repo_url: ""
# Full HTTPS or SSH URL of the project repository.
# Example: https://github.com/example-org/example-project

local_project_path: ""
# Absolute path to the project directory on the DevBox server.
# Example: /srv/projects/my-app

devbox_managed: true
# Must be true for any project with .qli/project/ metadata.

devbox_foundation_version: ""
# Version string or commit SHA of the DevBox Foundation material installed under
# .qli/foundation/devbox/ at time of onboarding.

onboarding_status: ""
# One of: pending, in-progress, complete, deferred, failed

assigned_port_block_id: ""
# Opaque identifier for the DevBox port block assigned to this project.
# Example: block-007
# Do NOT record actual port numbers here; those go in port-block.env.

primary_runtime: ""
# Primary application runtime descriptor.
# Example: docker-compose, docker-standalone, node, python

database_runtime: ""
# Database runtime, or "none" if no database.
# Example: postgres-16, mysql-8, sqlite, none

route_mode: ""
# One of: public, private, internal, none

source_code_change_policy: ""
# One of: non-invasive-only, approved-changes-documented
# Use non-invasive-only unless source changes were required and approved.

last_onboarding_review: ""
# ISO 8601 date of the most recent onboarding review.
# Example: 2026-05-24
```

**Forbidden:** passwords, tokens, port numbers, hostnames, credentials, private IPs, or any value that should live in `port-block.env` or a secrets store.

---

### `.qli/project/port-block.env`

**Purpose:** Records the DevBox-assigned port numbers for this project. Used by override files (`docker-compose.override.yml`, `.env`) to apply DevBox port assignments to the runtime.

**Git-safe:** Yes, with caution. Port numbers assigned by DevBox are not secrets. However, review before committing if the project repository is public-facing. For private project repositories, committing is standard practice.

**May contain live values:** Yes — assigned local DevBox port numbers are allowed. These are non-secret and local-only.

**Required fields:**

```dotenv
# QLi DevBox port block assignment for <PROJECT_SLUG>
# Schema version: 1
# Port block ID: <PORT_BLOCK_ID>
# Assigned: <DATE>
#
# All ports are DevBox-assigned and local-only (127.0.0.1 bindings).
# Do NOT use project-native default ports here. Use DevBox-assigned values only.
# Leave unused port lines blank (comment only). Do not remove them.

QLI_PROJECT_SLUG=
# The project slug. Must match manifest.yml:project_slug.

QLI_PORT_BLOCK_ID=
# The assigned port block identifier. Must match manifest.yml:assigned_port_block_id.

QLI_APP_PORT=
# Host-side port for the primary application container.
# Bind target: 127.0.0.1:${QLI_APP_PORT}

QLI_API_PORT=
# Host-side port for the API service container, if separate from the app.
# Leave blank if not applicable.
# QLI_API_PORT=

QLI_DB_PORT=
# Host-side port for the database container.
# WARNING: Database ports must bind to 127.0.0.1 only. Never 0.0.0.0.
# Leave blank if no database port is exposed to the host.
# QLI_DB_PORT=

QLI_AUX_PORT_1=
# Auxiliary port 1. Used for additional services in the port block.
# Leave blank if not applicable.
# QLI_AUX_PORT_1=

QLI_AUX_PORT_2=
# Auxiliary port 2. Used for additional services in the port block.
# Leave blank if not applicable.
# QLI_AUX_PORT_2=

QLI_BIND_HOST=127.0.0.1
# Host binding address. Must remain 127.0.0.1 unless the DevBox operator
# explicitly approves and documents an alternative in this file.
```

**Forbidden:** passwords, API keys, tokens, credentials, private IPs (other than `127.0.0.1`), live hostnames, or any non-port operational data.

**Note on unused ports:** Unused port lines must remain in the file as commented-out placeholders. Do not remove them. This preserves the port block record and prevents accidental re-allocation.

---

### `.qli/project/runtime-overrides.md`

**Purpose:** Documents the override strategy applied to adapt the project's native runtime to the DevBox environment. This is the human-readable record of what was changed, why, and how.

**Git-safe:** Yes. No secrets permitted.

**May contain live values:** No. Use placeholders for hostnames. Port numbers from the port block are allowed.

**Required sections:**

```
## Native project defaults discovered

List the project's native default ports, hostnames, bind addresses, and other
runtime values found in README.md, docker-compose.yml, .env.example, etc.
Do not include secrets.

## DevBox assigned overrides

List the DevBox-assigned values that replace the native defaults.
Reference port-block.env for port numbers.

## Override mechanism used

State which mechanism was used:
- .env file with DevBox-assigned values
- docker-compose.override.yml
- Runtime flags
- Source code changes (last resort only — must reference justification below)

## Files created or modified

List each file created or modified as part of the override process.

## Source-code changes required

yes / no

## Justification (if source changes were required)

If source-code changes were required, explain why non-invasive override options
were insufficient, what operator approval was obtained, and what was changed.
Leave blank if no source-code changes were made.
```

**Forbidden:** passwords, tokens, API keys, credentials, private IPs, live production hostnames.

---

### `.qli/project/routes.md`

**Purpose:** Documents the intended route configuration for this project within Caddy and the DevBox registry. This is the operational record of how the project is exposed (or not exposed) externally.

**Git-safe:** Yes. Use placeholders for domain values unless the operator explicitly approves recording live route names (private/internal projects only).

**May contain live values:** Route names may use `<PROJECT_SLUG>.<DOMAIN>` placeholders. For private/internal projects, the operator may explicitly approve recording the live route hostname if the project repository is access-controlled.

**Required sections:**

```
## Route intent

Describe what routes this project needs and why.
Example: primary app route at <PROJECT_SLUG>.<DOMAIN>, API route at api.<PROJECT_SLUG>.<DOMAIN>

## Caddy registration status

one of: not-registered / registered / deferred

## Access mode

one of: public / private / internal / none

## Upstream target

The Caddy upstream target for this project.
Format: http://127.0.0.1:<APP_PORT>
Use the port number from port-block.env (QLI_APP_PORT).

## API routing model

Describe how API routes are handled:
- proxied from the main app domain
- separate subdomain
- separate upstream target
- none

## Public exposure notes

Any notes about what is and is not publicly exposed.
Example: /admin paths are blocked. /api/internal paths require client auth.

## Caddy validation status

Status from the most recent `caddy validate` run.
one of: not-run / passed / failed / not-applicable
Record date of last run if applicable.
```

**Forbidden:** passwords, tokens, TLS private keys, credentials, private IPs (other than upstream 127.0.0.1 targets).

---

### `.qli/project/onboarding-report.md`

**Purpose:** The authoritative record of what was done, by whom, and in what state the onboarding completed. Created or updated at the end of an onboarding cycle. Immutable once the onboarding reaches `complete` status; append a new dated section for re-onboarding events.

**Git-safe:** Yes. No secrets permitted.

**May contain live values:** Dates, commit SHAs, onboarding status, deviation notes. No hostnames, no credentials, no private IPs.

**Required sections:**

```
## Onboarding record

### Onboarding date
ISO 8601 date and time when onboarding was completed or last updated.

### Operator
Role or handle of the human operator responsible for this onboarding.
Do not use personal email addresses or full names unless required.
Example: DevBox Operator / jdoe-ops

### Repo branch / commit
Branch and commit SHA of the managed project at time of onboarding.
Example: main / abc1234

### DevBox Foundation source commit
Commit SHA of the DevBox Foundation material installed under .qli/foundation/devbox/.
Example: a9a1aae

### Steps completed
List each step from PROJECT_ONBOARDING_DOCTRINE.md as completed, skipped, or deferred.
Note any deviations.

### Deviations
Describe any steps performed out of order, skipped, or modified.
If none, state: none.

### Blockers
List any blockers encountered and how they were resolved.
If none, state: none.

### Final status
one of: complete / in-progress / failed / deferred
Include a one-line summary of outcome.
```

**Forbidden:** passwords, tokens, credentials, private IPs, TLS secrets, WireGuard configs.

---

### `.qli/project/smoke-checks.md`

**Purpose:** Records the results of smoke checks performed after onboarding to confirm the project is running correctly in the DevBox environment.

**Git-safe:** Yes. Record pass/fail/notes — not credentials or session tokens.

**May contain live values:** Pass/fail results, HTTP status codes, container names, timestamps. No credentials, no private IPs, no TLS secrets.

**Required sections:**

```
## Smoke check record

### Date
ISO 8601 date and time of smoke checks.

### Container status
List each container and its status at time of check.
Example:
  my-app-web:  running
  my-app-db:   running

### Health endpoints
List each health or readiness endpoint checked and its result.
Example:
  GET http://127.0.0.1:<APP_PORT>/health  → 200 OK

### UI routes
List each UI route checked via Caddy and its result.
Example:
  https://<PROJECT_SLUG>.<DOMAIN>/  → 200 OK (via Caddy)

### API routes
List each API route checked and its result.
Example:
  https://<PROJECT_SLUG>.<DOMAIN>/api/health  → 200 OK

### Database visibility
Confirm database is accessible within Docker network and not exposed publicly.
Example:
  postgres: accessible via Docker network devbox-net
  Host port exposure: none (no host port binding for DB)

### Port exposure check
Confirm that only expected ports are bound on the host.
Example:
  127.0.0.1:<APP_PORT>  → open (expected)
  0.0.0.0:*  → none (expected: no wildcard bindings)

### Caddy validation
Record result of `caddy validate` at time of smoke check.
one of: passed / failed / not-run
Record date of last run.

### Final smoke result
one of: passed / partial / failed
Include a one-line summary.
```

**Forbidden:** passwords, tokens, credentials, auth session values, private IPs (other than `127.0.0.1` upstream references), TLS private keys.

---

## Template location

Starter templates for all required files are provided at:

```
products/_shared/templates/qli-project/
```

All templates use placeholders. Replace placeholders with actual values during onboarding. Do not leave placeholder text in completed metadata files.

---

## Summary table

| File | Git-safe | Live values allowed | Purpose |
|---|---|---|---|
| `manifest.yml` | Yes | Identity fields, port block ID | Project identity and onboarding state |
| `port-block.env` | Yes (private repos) | Assigned port numbers only | DevBox port assignments |
| `runtime-overrides.md` | Yes | Port numbers from port block | Override strategy record |
| `routes.md` | Yes | Placeholder hostnames (live with operator approval) | Route intent and Caddy registration |
| `onboarding-report.md` | Yes | Dates, SHAs, status | Onboarding completion record |
| `smoke-checks.md` | Yes | Pass/fail, status codes | Post-onboarding validation record |
