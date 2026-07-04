# Project Onboarding Doctrine

## Purpose

This document defines the standard sequence for onboarding an external project into a DevBox-managed server. The sequence is mandatory. Steps must not be skipped or reordered without explicit operator approval and documented justification.

---

## Prerequisite: Foundation must be in place

Before any project is onboarded into DevBox, the following must be true:

1. The DevBox Foundation library exists at `/srv/dev/foundation/` on the live server.
2. The onboarding doctrine (this document and its policy dependencies) is current.
3. The DevBox port allocation registry has capacity for a new port block assignment.

**No external managed project may be started in DevBox until this doctrine and the matching live-server foundation location are in place.**

This is not a preference. Starting a project in DevBox without established foundation material creates undocumented runtime state that is difficult to reconcile later.

---

## Standard onboarding sequence

### Step 1 — Inspect project repository and native documentation

Read the project's own `AGENTS.md`, `README.md`, `SETUP.md`, architecture documents, and Compose files. Understand what the project is, how it runs, and what its native port defaults and dependencies are.

Do not assume anything about the project's runtime before reading its documentation.

### Step 2 — Identify runtime stack and configurable ports

Identify:

- which services the project runs
- which ports each service uses by default
- which ports are configurable via environment variable or Compose override
- which databases or external services are dependencies
- whether any existing Compose configuration requires changes to work in a DevBox environment

### Step 3 — Assign DevBox project identity

Assign:

- a project slug
- a project ID
- the project folder path under the DevBox project root
- the target public hostname pattern for project routes

Record these in the DevBox project registry and in `.qli/project/` metadata.

### Step 4 — Assign DevBox port block

Consult the DevBox port allocation registry. Assign a port block that does not conflict with any existing managed project. Record the assignment in:

- DevBox server-side registry
- `.qli/project/portblock.env` or equivalent metadata file

Do not use project-native default ports inside DevBox unless they have been confirmed as available and non-conflicting after inspection of the full port allocation registry.

### Step 5 — Install `.qli/foundation/devbox/`

Copy the current DevBox Foundation material from `/srv/dev/foundation/devbox/current/` into the project repository under `.qli/foundation/devbox/`. The required directory structure and per-file purpose are defined in `products/_shared/QLI_PROJECT_LOCAL_FOUNDATION_SCHEMA.md`. Starter templates for `README.md` and `MANIFEST.md` are in `products/_shared/templates/qli-foundation-devbox/`.

After copying, write `MANIFEST.md` inside `.qli/foundation/devbox/` using the template. Record the source repository, branch, commit, server path (`/srv/dev/foundation/devbox/current/`), installation date, installer role, and foundation schema version. Commit all files to the project repository.

AI Coding Agents working on this project in any future session must read `.qli/foundation/devbox/` before performing any DevBox-related work.

### Step 6 — Create `.qli/project/` metadata

Create the project-local metadata under `.qli/project/` using the required files defined in `products/_shared/QLI_PROJECT_METADATA_SCHEMA.md`. Starter templates are in `products/_shared/templates/qli-project/`.

Required files:

- `manifest.yml` — project identity and onboarding state
- `port-block.env` — DevBox-assigned port numbers
- `runtime-overrides.md` — override strategy record (complete after Step 7)
- `routes.md` — route intent (complete after Step 9)
- `onboarding-report.md` — onboarding completion record (complete after Step 14)
- `smoke-checks.md` — post-onboarding validation record (complete after Step 13)

All files must follow the schema. No secrets, credentials, private IPs, or live production hostnames in these files unless the operator explicitly approves for a private/internal project.

### Step 7 — Generate environment and Compose overrides

Create or update the override files that apply the DevBox port block assignments to the project's runtime. Prefer:

- `.env` files with DevBox-assigned values
- `docker-compose.override.yml` with port, hostname, and network overrides

Do not modify the project's core `docker-compose.yml` or source configuration files at this stage.

### Step 8 — Start the project

Start the project using the standard DevBox project start sequence with the overrides applied. Verify that containers start successfully and bind to the correct ports.

### Step 9 — Register routes through the DevBox registry

Create the project registry entry in the DevBox server-side registry. Assign the primary hostname, certificate mode, access mode, and API route configuration.

### Step 10 — Regenerate routes

Run the DevBox route generation script to produce Caddy route fragments from the updated registry state.

### Step 11 — Validate Caddy

Run Caddy configuration validation before reload:

```
sudo -n /usr/bin/caddy validate --config /etc/caddy/Caddyfile
```

Do not reload Caddy if validation fails.

### Step 12 — Reload Caddy

Reload Caddy after successful validation:

```
sudo -n /usr/bin/systemctl reload caddy
```

### Step 13 — Run smoke checks

Verify that:

- the project route is reachable at the expected hostname
- the application responds correctly
- no unexpected ports are publicly exposed
- administrative tools remain protected

### Step 14 — Document onboarding report

Record an onboarding report in `.qli/project/` that includes:

- steps taken
- override mechanism used
- port assignments
- route configuration
- smoke check results
- any deviations from the standard sequence and their justification

### Step 15 — Source code changes (last resort only)

If and only if steps 7 through 13 reveal that the project cannot be onboarded without source code changes:

1. Document why non-invasive override options are insufficient.
2. Obtain explicit operator approval.
3. Make the minimum necessary source changes.
4. Record the changes and their justification in `.qli/project/` metadata.
5. Repeat the relevant steps from step 8 onward.

Source code changes to the project for DevBox onboarding purposes are the last resort, not the default approach.

---

## AI Coding Agent conduct during onboarding

AI Coding Agents performing onboarding work must:

- Read the project's own documentation before reading DevBox Foundation material.
- Read `.qli/foundation/devbox/` before performing any DevBox-specific operations.
- Use DevBox-assigned port values, never project-native defaults, for runtime configuration.
- Not attempt to start the project in DevBox before Steps 3 through 6 are complete.
- Not modify project source code for onboarding without documented operator approval.
- Report every deviation from the standard sequence in the onboarding report.

---

## Live server alignment

When this doctrine changes in a way that requires corresponding changes on the live DevBox server, those changes must be tracked in `products/server-builder/DEVBOX_SERVER_ALIGNMENT.md` before the PR is merged.

The human operator is responsible for applying server-side changes. The PR that introduces doctrine changes must not be merged if it requires live server changes that have not been reviewed and acknowledged.

---

## Active productized execution path

The sequence defined in this document has a corresponding operator runbook and preflight guardrail script that are the current productized execution paths:

- **`products/server-builder/MANAGED_PROJECT_ONBOARDING_RUNBOOK.md`** — Phase-by-phase operator runbook. Specifies who performs each action (control-repo work, live-server operator work, external-project repository work, AI Coding Agent work, human approval gates). Use this runbook as the active execution reference.

- **`scripts/devbox-managed-project-onboarding.sh`** — Preflight and phase-checklist guardrail script. Run this script before starting each phase to verify prerequisites and safety constraints. This version is read-only — it does not modify files, clone repositories, start containers, or make any changes to the live server.

The script must pass Phase 0 preflight before any live-server or external-project work begins.
