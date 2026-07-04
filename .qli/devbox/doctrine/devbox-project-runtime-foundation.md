# DEVBOX Project Runtime Foundation

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Definition

DEVBOX is a centralized development and demonstration runtime. It is normally a Linux server, VM, VPS, or bare-metal machine running Docker/Compose behind a reverse proxy.

DEVBOX is intended for:

- solo AI-assisted development;
- persistent development data;
- remote VS Code over SSH;
- browser-based demos;
- project consistency across machines;
- quick changes during presentations;
- controlled public URLs for known projects.

## DEVBOX responsibilities

DEVBOX owns:

```text
project folder placement
port block allocation
Caddy/reverse-proxy routing
runtime container execution
development data retention
public demo URL consistency
centralized smoke testing
```

The project repository owns:

```text
application code
project-specific Dockerfiles
project-specific compose files
project-specific start/stop/smoke scripts
project deployment profile documentation
```

## Standard project path

```text
/srv/dev/projects/<PROJECT_DOMAIN>
```

## Standard project route

Without a subdomain namespace:

```text
https://<SLUG>.<DOMAIN>
```

With a subdomain namespace:

```text
https://<SLUG>.<SUBDOMAIN>.<DOMAIN>
```

## Standard port allocation

DEVBOX assigns each project a `<PORT_BLOCK>`. Project services derive ports from that block.

Example model:

```text
<PORT_BLOCK> + 10 = public app/UI host port
<PORT_BLOCK> + 11 = public API host port, only if explicitly exposed
<PORT_BLOCK> + 20 = internal admin host port, VPN/local only if exposed
<PORT_BLOCK> + 30 = mail/dev service, local only if exposed
<PORT_BLOCK> + 40 = debug tool, local only if exposed
```

The exact mapping must be recorded in the project-specific deployment profile.

## Public ingress rule

Caddy or the chosen reverse proxy is the only public HTTP/HTTPS ingress.

Project containers must bind public web services to loopback only:

```yaml
ports:
  - "127.0.0.1:<APP_PORT>:<CONTAINER_PORT>"
```

Databases, caches, queues, object stores, dashboards, and debug tools must not bind publicly by default.

## DEVBOX profile

Every DEVBOX-adopted project should have a profile containing:

```text
PROJECT_DOMAIN=<PROJECT_DOMAIN>
SLUG=<SLUG>
DOMAIN=<DOMAIN>
PUBLIC_HOST=<SLUG>.<DOMAIN>
PORT_BLOCK=<PORT_BLOCK>
APP_PORT=<APP_PORT>
PUBLIC_SERVICE=<SERVICE_NAME>
PUBLIC_INTERNAL_PORT=<CONTAINER_PORT>
HEALTH_PATH=<HEALTH_PATH>
COMPOSE_PROJECT_NAME=<SLUG>_main
```

## Adoption output

The AI coding agent should normally create:

```text
docs/devbox-deployment.md
scripts/devbox-start.sh
scripts/devbox-stop.sh
scripts/devbox-smoke.sh
infra/docker/devbox/<runtime>.Dockerfile
compose.yaml or compose.devbox.yaml
```

Only create files that the project actually needs.
