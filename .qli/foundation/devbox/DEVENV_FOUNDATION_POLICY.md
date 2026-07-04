# DevBox Foundation Policy

## Purpose

DevBox Foundation is environment and runtime doctrine for DevBox-managed projects. It is not application doctrine, product architecture, or engineering standards for the project itself.

This distinction is important. DevBox Foundation governs how a project lives inside a DevBox server. It does not govern what the project builds, how it is architected, or what technology stack it uses.

---

## What DevBox Foundation governs

DevBox Foundation governs:

- project placement within the DevBox project root
- DevBox port block assignment and override strategy
- route registration and Caddy exposure model
- local runtime configuration overrides (environment, Compose, or runtime-level)
- smoke check sequences for DevBox onboarding validation
- AI-agent-safe onboarding procedures
- `.qli/` namespace management within the project

---

## What DevBox Foundation does not govern

DevBox Foundation does not override or replace:

- the project's own `AGENTS.md` or AI agent conduct rules
- the project's `README.md`, `SETUP.md`, or product documentation
- the project's architecture decisions and technology stack choices
- the project's API contracts, data models, or business logic
- the project's product roadmap or engineering priorities

If there is a conflict between DevBox Foundation doctrine and the project's own doctrine, the project's own doctrine takes precedence for product and engineering decisions. DevBox Foundation takes precedence only for DevBox-specific operational concerns (port assignment, route registration, runtime overrides).

---

## Installation model

DevBox Foundation material is installed in two places:

### 1. Server-side canonical library: `/srv/dev/foundation/`

The server maintains a versioned, authoritative copy of DevBox Foundation modules. This copy is maintained by the DevBox operator and updated when the DevBox platform version advances.

### 2. Project-local copy: `.qli/foundation/devbox/`

Each managed project receives a copy of the relevant DevBox Foundation material under `.qli/foundation/devbox/`. This copy travels with the project in version control, ensuring that any AI Coding Agent or human contributor working in the project repository has access to the correct DevBox operational doctrine without needing server access.

This copy must be installed from `/srv/dev/foundation/devbox/current/` on the live DevBox server during onboarding Step 5. After copying, a `MANIFEST.md` must be written inside `.qli/foundation/devbox/` to record the source repository, branch, commit, server path, installation date, installer role, and foundation schema version. See `products/_shared/QLI_PROJECT_LOCAL_FOUNDATION_SCHEMA.md` for the full required structure, per-file purpose, and `MANIFEST.md` required fields. Use the starter templates in `products/_shared/templates/qli-foundation-devbox/`.

When the server-side foundation library is updated, managed projects should receive the updated copy in `.qli/foundation/devbox/` through a deliberate update step, not automatically.

---

## Relationship to AI Coding Agents

AI Coding Agents operating inside a managed project must:

1. Read the project's own `AGENTS.md`, `README.md`, and relevant product documentation first.
2. Then read `.qli/foundation/devbox/` for DevBox-specific operational rules.
3. Not assume that DevBox Foundation doctrine overrides the project's product decisions.
4. Use DevBox port assignments, not project-native defaults, for all runtime configuration.
5. Report any conflict between project-native doctrine and DevBox Foundation doctrine to the human operator before proceeding.

---

## Non-invasive principle

DevBox onboarding must be non-invasive by default.

The preferred resolution order for onboarding a project into DevBox is:

1. Environment variable overrides (`.env`, `docker-compose.override.yml`)
2. Compose override files
3. Runtime configuration flags
4. Source code changes (last resort, with explicit operator approval)

Source code changes to the project are not permitted for DevBox onboarding purposes unless all non-invasive override options have been evaluated and documented as insufficient.
