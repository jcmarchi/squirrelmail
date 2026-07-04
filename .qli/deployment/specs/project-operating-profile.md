# Project Operating Profile

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/project-operating-profile.md`  
**Purpose:** Declare the current and expected operating reality of the project so delivery, security, runtime, observability, testing, data, API, UI, and ACL decisions remain aligned.

---

## 1. Current Project Stage

| Field | Value |
|---|---|
| Product Stage | Prototype / MVP / Private Beta / Public Beta / Production / Enterprise / Open Source |
| Current Build Target | [What this phase must support now] |
| Future Target | [Where the product is expected to evolve] |
| Human Review Mode | Local smoke test / Demo URL / Staging / Production-like review |

---

## 2. Product and Distribution Model

| Field | Value |
|---|---|
| Distribution Model | Internal / Proprietary Hosted / Client-Hosted / Open Source / SaaS / White Label / On-Prem / Hybrid |
| License Model | Proprietary / Open Source / Dual License / Client-Owned / Other |
| Operator | Internal team / Client operator / Community operator / Mixed |
| Installation Model | One hosted instance / Many client installs / Multi-tenant service / Downloadable package |

---

## 3. Deployment Target

| Field | Current | Future / Possible |
|---|---|---|
| Primary Deployment Target | Shared Hosting / VPS / Dedicated / Docker / Kubernetes / PaaS / Serverless / Static / On-Prem | |
| Build Requirement | No build / simple asset build / full build pipeline | |
| Server Access Assumption | None / FTP-SFTP / SSH / root / container registry / cluster access | |
| Worker Capability | None / cron only / supervised workers / container workers / queue consumers | |
| Storage Capability | local disk / object storage / mounted volume / hybrid | |

---

## 4. Exposure and Identity

| Field | Value |
|---|---|
| Exposure | Local Only / Private Network / Public Web / Public API / Partner API / Public SaaS Signup |
| Identity Model | No Login / Single Admin / Users / Users + Admins / Tenant Admins / Platform Admins / API Clients / SSO |
| Tenancy | Single-Tenant / Multi-Tenant / Organization-Scoped / Workspace-Scoped / Hybrid |
| Public Surfaces | [List] |
| Admin Surfaces | [List] |
| API Surfaces | [List] |

---

## 5. Data and Runtime

| Field | Value |
|---|---|
| Data Sensitivity | Public / Internal / Business Confidential / PII / Financial / Regulated / Secrets |
| Runtime Model | Request-Only / Cron / Queue Workers / Event Consumers / Long-Running Workers / Scheduled Jobs |
| Database Mode | Local DB / Managed DB / Client DB / File-based / Hybrid |
| File/Upload Mode | None / Local uploads / Object storage / External storage / Hybrid |
| Backup Expectation | Manual / Scheduled / Managed / Client-owned / Not yet defined |

---

## 6. Active Directional Decision

State the practical decision for the current build phase.

```text
This project is currently being built for: [selected target]
The implementation must preserve: [portability/security/distribution constraints]
The next likely operating stage is: [future target]
```

---

## 7. Change Triggers

Update this file when any of the following changes:

- deployment target changes;
- app becomes public;
- user login is added;
- admin surfaces are added;
- multi-tenancy is added;
- file upload/download is added;
- public API or API tokens are added;
- billing/webhooks are added;
- workers/queues/scheduled jobs are added;
- production deployment begins;
- open-source or client-hosted distribution begins;
- sensitive or regulated data enters the system.
