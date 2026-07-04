# Development Environment Foundation

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Purpose

This foundation defines how a software project should support repeatable development runtimes without contaminating product architecture with environment-specific assumptions.

It exists because modern AI-assisted development often requires:

- a stable runtime that an AI coding agent can modify and test;
- persistent development data;
- browser-accessible demonstrations;
- non-conflicting ports across many projects;
- repeatable local onboarding;
- clear separation between product code and runtime infrastructure;
- safe handoff between human project assistant and AI coding agent.

## Core doctrine

Git remains the source-code truth.

The development runtime is a testable execution surface, not the source of truth for product history.

DEVBOX may be the canonical active development runtime, but it must not become the only way the project can run.

Local runtime support remains useful for onboarding, fallback, and portability validation.

Production remains a separate deployment discipline.

## Runtime layers

A project may have three distinct runtime layers:

```text
Local runtime       Workstation-based development and onboarding
DEVBOX runtime      Centralized development and demonstration estate
Production runtime  Real deployment environment
```

These layers may share Docker images, scripts, and environment variables, but they should not be confused.

## Inviolable rules

Application code must remain portable.

Runtime-specific files belong in runtime-specific locations.

Secrets must remain outside version control.

Host ports must be explicit and configurable.

Only approved public services may bind to host interfaces.

Databases, caches, queues, object stores, and internal admin tools must not be exposed publicly by default.

Health checks are required.

Smoke-test commands are required.

AI agents must report exact files changed, commands run, tests executed, and failures encountered.

## Recommended project outputs

After adoption, a project should have, as applicable:

```text
docs/devbox-deployment.md
docs/local-dev-deployment.md
compose.yaml
infra/docker/devbox/
infra/docker/local/
scripts/devbox-start.sh
scripts/devbox-stop.sh
scripts/devbox-smoke.sh
scripts/local-start.sh
scripts/local-stop.sh
scripts/local-smoke.sh
```

The project may use a smaller subset when its runtime is simple.
