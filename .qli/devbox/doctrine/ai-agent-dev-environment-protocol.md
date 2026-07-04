# AI Agent Development Environment Protocol

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Purpose

This protocol governs how an AI coding agent should modify a project to support DEVBOX or local runtime environments.

## Required reading before changes

The AI coding agent must read:

```text
/docs/devenv/README.md
/docs/devenv/directives/AGENT_DIRECTIVE.md
project README.md
project SETUP.md, if present
project AGENTS.md, if present
project CLAUDE.md, if present
existing compose files
existing Dockerfiles
existing scripts
```

## Required behavior

The agent must:

1. Identify the existing runtime architecture.
2. Preserve product architecture.
3. Avoid introducing new frameworks unless explicitly approved.
4. Prefer compose overrides or small runtime wrappers over application rewrites.
5. Use assigned DEVBOX ports.
6. Keep internal services private.
7. Validate configuration before starting services.
8. Run smoke tests.
9. Report results in a structured handoff.

## Forbidden behavior

The agent must not:

- overwrite root README.md without approval;
- overwrite AGENTS.md or CLAUDE.md without approval;
- commit `.env` files or credentials;
- expose database/cache/object-storage ports publicly;
- invent arbitrary host ports;
- use default public ports for project services;
- change product architecture merely to satisfy a dev runtime;
- delete volumes or data unless explicitly instructed.

## Handoff report

Every runtime adoption task must end with:

```text
Files changed:
Commands run:
Containers started:
Ports bound:
Public URL:
Health checks:
Known issues:
Git status:
Recommended next step:
REF: <PROMPT_ID>
```
