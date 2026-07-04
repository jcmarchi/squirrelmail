# Port Allocation Standard

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Purpose

Port collisions are common when many projects run on the same development server or workstation. This standard defines a predictable port-block model.

## Internal vs host ports

Internal container ports may remain standard:

```text
80
443
3306
5432
6379
8000
```

Host ports must be assigned, non-conflicting, and documented.

## DEVBOX port block model

Each project receives a `<PORT_BLOCK>`.

Suggested offsets:

```text
+10  public app/UI
+11  public API, only if explicitly exposed
+20  admin/internal UI, local/VPN only
+30  mail/dev utility, local/VPN only
+40  debugger/inspection, local/VPN only
+42  database host access, local only if absolutely needed
+80  cache host access, local only if absolutely needed
```

## Binding rule

Public web-facing services should bind to loopback:

```yaml
ports:
  - "127.0.0.1:<APP_PORT>:<INTERNAL_PORT>"
```

This lets the reverse proxy reach the service while preventing direct LAN/public exposure.

## Database rule

Do not expose databases by default.

If temporary host access is required:

```yaml
ports:
  - "127.0.0.1:<DB_PORT_HOST>:3306"
```

Never bind database ports to `0.0.0.0` in a development estate.

## Documentation rule

Every exposed host port must appear in:

```text
docs/devbox-deployment.md
docs/local-dev-deployment.md
```
