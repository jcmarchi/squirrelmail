# AI Coding Agent Directive — Development Environment Foundation

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Read this file before making DEVBOX or local runtime changes.

## Authority

This directive governs development-environment implementation only. It does not override product architecture specifications, security specifications, UI/API/data foundations, or product roadmap documents.

## Primary mandate

Implement repeatable development runtimes while preserving application architecture.

## Never do these without explicit approval

- Overwrite root `README.md`.
- Overwrite root `SETUP.md`.
- Overwrite root `AGENTS.md`.
- Overwrite root `CLAUDE.md`.
- Replace an existing compose file if a compose override or minimal patch is sufficient.
- Commit `.env`, credentials, tokens, database dumps, or local secrets.
- Expose databases, caches, queues, object stores, or admin consoles publicly.
- Delete Docker volumes or project data.
- Introduce Laravel, Node.js, React, Vue, Vite, Kubernetes, or other major stack pieces unless the project already uses them or approval is explicit.
- Change application code merely to satisfy the dev environment.

## Standard implementation flow

1. Read `/docs/devenv/README.md`.
2. Read this directive.
3. Inspect the project’s current runtime docs and files.
4. Identify runtime type.
5. Create a project-specific profile.
6. Adapt templates into active project locations.
7. Validate compose config.
8. Start stack.
9. Run dependency/bootstrap commands.
10. Run smoke tests.
11. Report exact results.

## DEVBOX active locations

Use these locations when implementation is approved:

```text
docs/devbox-deployment.md
compose.yaml or compose.devbox.yaml
infra/docker/devbox/
scripts/devbox-start.sh
scripts/devbox-stop.sh
scripts/devbox-smoke.sh
```

## Local active locations

Use these locations when local runtime implementation is approved:

```text
docs/local-dev-deployment.md
compose.local.yaml or compose.override.yaml
infra/docker/local/
scripts/local-start.sh
scripts/local-stop.sh
scripts/local-smoke.sh
```

## Required final response format

```text
Files changed:
Commands run:
Validation:
Smoke tests:
Public/local URLs:
Security notes:
Git status:
Known issues:
Next recommended action:
REF: <PROMPT_ID>
```
