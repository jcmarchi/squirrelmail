# AI Coding Agent Prompt — DEVBOX Runtime Adoption

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


You are adapting this existing project to run on DEVBOX.

Inputs to confirm from the project owner or DEVBOX registry:

```text
PROJECT_DOMAIN=<PROJECT_DOMAIN>
SLUG=<SLUG>
DOMAIN=<DOMAIN>
PUBLIC_HOST=<SLUG>.<DOMAIN>
PORT_BLOCK=<PORT_BLOCK>
APP_PORT=<APP_PORT>
COMPOSE_PROJECT_NAME=<SLUG>_main
HEALTH_PATH=<HEALTH_PATH>
```

Read:

```text
docs/devenv/README.md
docs/devenv/directives/AGENT_DIRECTIVE.md
README.md
SETUP.md
AGENTS.md, if present
CLAUDE.md, if present
existing compose/Docker/script files
```

Implement:

```text
docs/devbox-deployment.md
compose.yaml or compose.devbox.yaml
infra/docker/devbox/
scripts/devbox-start.sh
scripts/devbox-stop.sh
scripts/devbox-smoke.sh
```

Only create what is needed.

Runtime rules:

- Public web service binds to 127.0.0.1:<APP_PORT>.
- Reverse proxy owns public HTTPS.
- Internal services stay internal.
- Dependency installers should not create root-owned files in bind-mounted repos.
- Dockerfiles should include Git safe.directory mitigation where applicable.
- .env must not be committed.

Run:

```text
docker compose config
docker compose up -d --build
health checks
reverse-proxy/Caddy route check
```

Do not commit without explicit approval.

REF: DEVBOX-ADOPTION-001
