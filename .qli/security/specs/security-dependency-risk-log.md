# Security Dependency Risk Log

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


| Dependency / Package | Purpose | Runtime / Dev | Version | Risk | Review Date | Decision | Notes |
|---|---|---|---|---|---|---|---|
| `[name]` | `[purpose]` | `[runtime/dev]` | `[version]` | `[low/medium/high]` | `[date]` | `[approved/deferred/replace]` | |

## Review Rules

- Do not add dependencies casually.
- Prefer maintained, boring, widely understood packages.
- Document why a security-sensitive package was introduced.
- Re-check dependency impact before release when tooling is available.
- Node.js and Laravel must not become core application technologies unless explicitly approved; tooling or non-core modules may be documented exceptions.
