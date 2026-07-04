# AI Coding Agent Prompt — Local Runtime Adoption

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


You are adding or improving workstation-local runtime support.

Read:

```text
docs/devenv/README.md
docs/devenv/directives/AGENT_DIRECTIVE.md
docs/devenv/doctrine/local-dev-environment-foundation.md
project README.md
project SETUP.md
existing compose/Docker/script files
```

Implement a local runtime that supports configurable ports and does not conflict with DEVBOX.

Preferred outputs:

```text
docs/local-dev-deployment.md
compose.local.yaml or compose.override.yaml
infra/docker/local/
scripts/local-start.sh
scripts/local-stop.sh
scripts/local-smoke.sh
```

Rules:

- Do not break DEVBOX runtime.
- Do not commit local .env files or credentials.
- Host ports must be configurable.
- Internal container ports may remain standard.
- Provide Windows/Linux/macOS notes where relevant.
- Run smoke tests.

REF: LOCAL-RUNTIME-ADOPTION-001
