# Development Environment Foundation

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


This folder contains the project’s development-environment foundation.

It governs how a project should be adapted for repeatable development runtimes without forcing product code to become environment-specific. It covers two complementary runtime models:

1. **DEVBOX runtime** — a centralized Docker/Compose runtime hosted on a persistent server or VM, intended for solo AI-era development, stable demonstrations, persistent dev data, and remote access.
2. **Local runtime** — a workstation-local runtime for onboarding, fallback development, and portability validation across Windows, Linux, and macOS.

This foundation is intentionally stored under:

```text
/docs/devenv/
```

It is documentation, doctrine, templates, prompts, and case-study guidance. It is not an active runtime directory.

## Boundary rule

Files under `/docs/devenv/` are not meant to be executed directly unless a human explicitly says so. AI coding agents must treat this folder as reference material and adapt the appropriate templates into active project locations.

Active runtime files belong in project operational locations such as:

```text
compose.yaml
infra/docker/devbox/
infra/docker/local/
scripts/devbox-start.sh
scripts/devbox-stop.sh
scripts/devbox-smoke.sh
scripts/local-start.sh
scripts/local-stop.sh
scripts/local-smoke.sh
docs/devbox-deployment.md
docs/local-dev-deployment.md
```

## Collision rule

This package must not overwrite project-root files such as:

```text
README.md
SETUP.md
AGENTS.md
CLAUDE.md
compose.yaml
Dockerfile
```

unless explicitly instructed by the project owner.

## Placeholder convention

All examples use placeholders. Replace them during adoption:

```text
<PROJECT_DOMAIN>
<SLUG>
<DOMAIN>
<SUBDOMAIN>
<DEVBOX_IP>
<PUBLIC_IP>
<PORT_BLOCK>
<APP_PORT>
<API_PORT>
<UI_PORT>
<DB_PORT_HOST>
<FALLBACK_URL>
<USER>
<SSH_PUBLIC_PORT>
```

No real project name, company name, domain, private IP, public IP, or personal account should be committed into reusable foundation files.

## Recommended adoption sequence

1. Read `/docs/devenv/directives/AGENT_DIRECTIVE.md`.
2. Read the project’s root `README.md`, `SETUP.md`, `AGENTS.md`, and existing infrastructure files.
3. Select a runtime model: DEVBOX, local, or both.
4. Create project-specific deployment profiles.
5. Adapt templates into active project locations.
6. Validate compose configuration before starting containers.
7. Run health checks.
8. Document the final runtime in `docs/devbox-deployment.md` and/or `docs/local-dev-deployment.md`.

## Buildline Implementation Control

This foundation is governed operationally by `.qli/devbox/devbox-implementation-control.md`.

Use the full reference for doctrine and vocabulary. Use the implementation-control file for the project-agnostic minimum spine, optional capability rules, deferral rules, evidence expectations, test/smoke expectations, common AI-agent failure modes, and definition of done.

Project-specific applicability is not decided inside this reference file. It is decided through `.qli/binding/` and recorded in `.qli/project/foundation-applicability.yml`.
