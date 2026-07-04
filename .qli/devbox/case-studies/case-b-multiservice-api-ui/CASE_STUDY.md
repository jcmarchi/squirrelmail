# Case Study B — Multi-Service API + UI Platform

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Scenario

A project contains multiple services such as:

```text
API
UI
database
cache
queue
object storage
background workers
admin dashboards
optional local AI service
```

The project already has a Docker Compose development workflow.

## Generic profile

```text
PROJECT_DOMAIN=<PROJECT_DOMAIN>
SLUG=<SLUG>
PUBLIC_HOST=<SLUG>.<DOMAIN>
PORT_BLOCK=<PORT_BLOCK>
UI_PORT=<PORT_BLOCK + 10>
API_PORT=<PORT_BLOCK + 11>
ADMIN_PORT=<PORT_BLOCK + 20>
COMPOSE_PROJECT_NAME=<SLUG>_main
```

## Required adaptations

1. Preserve existing local workflow.
2. Add DEVBOX-specific compose override or profile.
3. Expose only the public UI or public API through loopback-bound host ports.
4. Keep database/cache/queue/object-storage services internal.
5. Expose internal admin dashboards only through VPN/local routes if approved.
6. Update app environment variables so browser-facing URLs use the DEVBOX public route.
7. Validate API health and UI access.
8. Document any services intentionally left internal.

## Key lesson

Do not blindly expose every existing local development port on DEVBOX. DEVBOX should expose only what is required for browser testing and demos.
