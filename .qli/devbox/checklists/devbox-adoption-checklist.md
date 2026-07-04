# DEVBOX Adoption Checklist

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Before implementation

- [ ] Project cloned under `/srv/dev/projects/<PROJECT_DOMAIN>`.
- [ ] DEVBOX registry entry exists.
- [ ] Assigned `<PORT_BLOCK>` confirmed.
- [ ] Assigned `<APP_PORT>` confirmed.
- [ ] Public route confirmed.
- [ ] Existing project runtime reviewed.
- [ ] Branch created for runtime changes.

## Implementation

- [ ] `.env` created locally but not committed.
- [ ] Compose config uses assigned port.
- [ ] Public service binds to loopback.
- [ ] Internal services have no public host ports.
- [ ] Dockerfile includes required runtime dependencies.
- [ ] Git safe.directory issue handled where relevant.
- [ ] Dependency installation does not leave root-owned files.

## Validation

- [ ] `docker compose config` passes.
- [ ] Stack starts.
- [ ] Health endpoint responds.
- [ ] Caddy/reverse proxy route responds.
- [ ] Browser URL works.
- [ ] Git status reviewed.
- [ ] Only safe files staged.
