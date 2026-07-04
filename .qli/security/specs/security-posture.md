# Security Posture — [Project Name]

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Purpose:** Translate the Project Operating Profile into concrete security assumptions and required controls.

## Source Operating Profile

Read: `.qli/project-operating-profile.md`

## Current Security Classification

| Axis | Current Decision | Notes |
|---|---|---|
| Product Stage | `[MVP / Beta / Production / Enterprise / Open Source]` | |
| Distribution Model | `[Internal / Hosted / Client-hosted / Open Source / SaaS / On-prem]` | |
| Deployment Target | `[Shared Hosting / VPS / Docker / Kubernetes / Hybrid]` | |
| Exposure | `[Private / Public Web / Public API / Partner API / Public Signup]` | |
| Tenancy | `[None / Single / Organization / Workspace / Multi-tenant / Hybrid]` | |
| Identity Model | `[No Login / Users / Admins / Tenant Admins / Platform Admins / API Clients / SSO]` | |
| Data Sensitivity | `[Public / Confidential / PII / Financial / Secrets / Regulated / Audit]` | |
| Runtime Model | `[Request / Cron / Jobs / Queues / Webhooks / Event Consumers]` | |

## Active Security Requirements

- `[Example: secure session handling]`
- `[Example: CSRF protection for browser writes]`
- `[Example: server-side authorization for protected routes]`
- `[Example: tenant-aware query/file/cache/log isolation]`
- `[Example: privacy-safe logging]`
- `[Example: dev/debug route blocking in production]`

## Current Infrastructure Overlay

Describe controls available in the current deployment target:

```text
[Example: Shared hosting now; no long-running workers or container assumptions. VPS/container deployment may be added later.]
```

## Not Applicable Right Now

- `[Example: Kubernetes network policies]`
- `[Example: enterprise SSO]`
- `[Example: formal compliance evidence mapping]`

## Upgrade / Activation Triggers

- Add file uploads -> activate upload security controls.
- Add API tokens -> activate token lifecycle controls.
- Add billing webhooks -> activate webhook signature/replay/idempotency controls.
- Add public SaaS signup -> activate rate-limit/abuse controls.
- Add enterprise customers -> activate stronger audit, SSO/MFA, data-protection, and evidence controls.

## Deferred Security Decisions

| Decision | Reason | Target Resolution | Owner |
|---|---|---|---|
| `[decision]` | `[reason]` | `[date/version]` | `[owner]` |
