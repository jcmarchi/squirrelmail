# Caddy Host Redirect Correction — SquirrelMail

## Diagnosis

**Root cause**: Global Caddy wildcard redirect in `/etc/caddy/Caddyfile`:

```
http://*.qlidemo.com {
    redir https://qlinnovations.com{uri} 302
}
```

This wildcard intercepts ALL HTTP requests for any `*.qlidemo.com` subdomain and redirects them to `https://qlinnovations.com` instead of preserving the subdomain. The HTTPS route for `squirrelmail.qlidemo.com` works correctly because the generated per-project Caddy fragment handles HTTPS directly.

## Generated Route (Correct)

The generated Caddy fragment at `/srv/dev/reverse-proxy/sites/squirrelmail.generated.caddy` is correct:

```
squirrelmail.qlidemo.com {
    reverse_proxy 127.0.0.1:20110
}
```

No `qlinnovations.com` reference in the generated route.

## Required Fix

Change the global Caddy wildcard redirect to preserve the hostname:

```caddy
http://*.qlidemo.com {
    redir https://{host}{uri} 302
}
```

This requires:
1. Edit `/etc/caddy/Caddyfile` (replace `qlinnovations.com` with `{host}` in the wildcard redirect line)
2. Validate: `sudo -n /usr/bin/caddy validate --config /etc/caddy/Caddyfile`
3. Reload: `sudo -n /usr/bin/systemctl reload caddy`

## Why This Cannot Be Fixed In This Pass

- Editing `/etc/caddy/Caddyfile` requires sudo — forbidden in this pass
- Caddy validate/reload requires sudo
- The route-project tool also uses sudo internally for Caddy operations
- This is a DevBox server-level configuration, not a project-level fix

## Current State

| Check | Result |
|---|---|
| Generated Caddy fragment | ✅ Correct |
| HTTPS login page | ✅ HTTP 200 |
| HTTPS configtest | ✅ Blocked |
| HTTP redirect | ❌ → qlinnovations.com |
| Post-login redirect | ❌ → qlinnovations.com |

## Next Action Required

DevBox operator must apply the one-line fix to `/etc/caddy/Caddyfile` and reload Caddy.
