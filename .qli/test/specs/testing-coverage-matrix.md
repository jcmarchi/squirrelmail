# Testing Coverage Matrix — [Project Name]

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Purpose:** Map product features and architecture layers to required validation so vertical slices are reviewable and risk is visible.

| Feature / Flow | Core Test | Data Test | API/Event Test | UI Smoke/Browser Test | ACL Test | Runtime Test | Manual QA | Risk Level | Gap / Next Action |
|---|---|---|---|---|---|---|---|---|---|
| | yes/no/n/a | yes/no/n/a | yes/no/n/a | yes/no/n/a | yes/no/n/a | yes/no/n/a | yes/no | low/medium/high/critical | |

## Rule

A feature exposed to users should not remain with `no` across all validation columns. If automation is deferred, record the manual QA path and the reason automation is deferred.
