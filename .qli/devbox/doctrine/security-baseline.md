# Development Environment Security Baseline

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Scope

This baseline applies to DEVBOX and local runtimes.

## Minimum DEVBOX security posture

A DEVBOX exposed to the internet should use:

```text
SSH key-only authentication
PasswordAuthentication no
PermitRootLogin no
UFW or equivalent firewall
Fail2Ban or equivalent intrusion throttling
Caddy or equivalent reverse proxy as HTTP/HTTPS ingress
No public database ports
No public cache/queue ports
No public object-storage admin consoles unless explicitly protected
No committed secrets
```

## SSH guidance

If public SSH is required for VS Code Remote SSH, prefer:

```text
ssh.<DOMAIN>
<SSH_PUBLIC_PORT>
key-only authentication
sshd listening on both 22 and <SSH_PUBLIC_PORT> when internal DNS resolves directly to DEVBOX
router/cloud firewall forwarding <SSH_PUBLIC_PORT> to DEVBOX:<SSH_PUBLIC_PORT>
```

## Reverse proxy rule

Only known project routes should be publicly exposed.

Unknown HTTP routes may redirect to `<FALLBACK_URL>`.

Unknown HTTPS routes require wildcard TLS or controlled on-demand TLS to redirect cleanly. Do not assume wildcard DNS means wildcard TLS.

## Local runtime security

Local runtime can be less strict, but must still avoid committing secrets and should avoid exposing services beyond localhost.
