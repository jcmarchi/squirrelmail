# Development Runtime Security Checklist

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


- [ ] `.env` is not tracked.
- [ ] Secrets are not in compose files.
- [ ] Public web route goes through reverse proxy.
- [ ] App service binds to loopback on DEVBOX.
- [ ] Database is not publicly exposed.
- [ ] Cache/queue is not publicly exposed.
- [ ] Object-storage console is not publicly exposed unless explicitly protected.
- [ ] SSH is key-only if public.
- [ ] Firewall rules are active on DEVBOX.
- [ ] Fail2Ban or equivalent is active if public SSH is enabled.
