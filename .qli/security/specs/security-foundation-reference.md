# Security Foundation Reference

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/security/security-foundation-reference.md`  
**Audience:** AI Coding Agents, human architects, reviewers, maintainers  
**Purpose:** Define a reusable, technology-agnostic security foundation for new and existing projects without forcing a single infrastructure model.

## 0. Mandatory Instruction to AI Coding Agents

Before creating or modifying security-sensitive behavior, read this file, `.qli/project-operating-profile.md`, and the project files under `.qli/security/`.

Do not treat hosting model as the whole security model. A shared-hosting-compatible application can run on a VPS, Docker, or Kubernetes while retaining the same application architecture. Apply infrastructure controls only where the deployment target supports them. Apply application controls based on exposure, data sensitivity, identity model, tenancy, and feature triggers.

## 1. Core Doctrine

Security is not only ACL. ACL governs authorization. Security governs how the application resists compromise, misuse, leakage, abuse, unsafe deployment, misconfiguration, and operational failure.

Mandatory principles:

1. Secure by default.
2. Deny dangerous behavior unless explicitly allowed.
3. Validate external input at boundaries.
4. Encode/escape output by context.
5. Protect sessions, cookies, forms, APIs, uploads, downloads, webhooks, and admin surfaces.
6. Never rely on frontend-only security.
7. Keep secrets out of source control, logs, fixtures, client payloads, and rendered errors.
8. Use least privilege for users, services, filesystems, API tokens, and integrations.
9. Make security controls testable.
10. Document deferred risk explicitly.

## 2. Security Posture Decision Chain

Security decisions must follow this chain:

1. What does the Project Operating Profile say?
2. What surfaces are exposed?
3. What data is sensitive?
4. What identity and tenancy model exists?
5. What feature is being implemented?
6. Which controls are triggered?
7. Which controls already exist?
8. What tests prove the controls?
9. What risks are deferred or accepted?

## 3. Posture Axes

The project posture is defined by these axes:

| Axis | Examples |
|---|---|
| Product stage | Prototype, MVP, public beta, production, enterprise, open source |
| Distribution model | Internal, proprietary hosted, client-hosted, open source, SaaS, white label, on-prem |
| Deployment target | Shared hosting, VPS, Docker, Kubernetes, PaaS, serverless, hybrid |
| Exposure | Local, private network, public web, public API, partner API, public signup |
| Tenancy | No tenancy, single tenant, organization/workspace scoped, multi-tenant, hybrid |
| Identity model | No login, users, admins, tenant admins, platform admins, API clients, SSO |
| Data sensitivity | Public, business confidential, PII, financial, secrets, regulated, audit records |
| Runtime model | Request-only, cron, workers, queues, event consumers, webhooks, imports/exports |

## 4. Baseline Application Controls

Every non-trivial application should implement or explicitly defer:

- Input validation and normalization.
- Output escaping/encoding.
- Safe error handling.
- Secure session and cookie configuration where sessions exist.
- CSRF protection for browser state-changing requests.
- Server-side authorization for protected actions.
- Route/surface classification.
- Dev/debug route blocking in production.
- Secure file and path handling.
- Dependency hygiene.
- Privacy-safe logging.
- Secrets outside source control.
- Security-relevant tests.

## 5. Infrastructure Overlay Controls

Infrastructure controls depend on the deployment target and must not rewrite application architecture by assumption.

| Overlay | Examples of applicable controls |
|---|---|
| Shared hosting | Webroot isolation, `.env` protection, filesystem permissions, upload path safety, no daemon assumptions |
| VPS/dedicated | TLS, firewall, deploy user, service separation, log rotation, backup encryption, cron supervision |
| Docker | Minimal images, non-root containers, env/secrets handling, volume permissions, image scanning where available |
| Kubernetes | Ingress/TLS, secrets, network policies, pod security context, resource limits, centralized logs |
| PaaS/serverless | Provider config, environment secrets, function timeouts, IAM minimization, cold-start safe behavior |
| Open-source/distributable | Safe installer defaults, generated secrets, upgrade safety, documented hardening, disclosure process |

## 6. Feature Trigger Rule

When a feature appears in `security-trigger-matrix.md`, its required controls must be implemented or explicitly deferred through `security-exception-register.md`. The feature is not complete merely because it works functionally.

## 7. Integration With Other Foundations

Security coordinates with:

- ACL for authorization, roles, permissions, scopes, and route classification.
- DATA for sensitivity, retention, deletion, tenancy, residency, and schema safety.
- API for contracts, validation, gateway behavior, rate limits, tokens, and webhooks.
- Runtime for sessions, jobs, queues, retries, locks, cache, and failure handling.
- Delivery for operating profile, deployment target, configuration, secrets, backups, and releases.
- Observability for safe logs, audit events, traces, alerts, and diagnostics.
- Testing for proof and regression control.
- UI for safe presentation and no frontend-only security.

## 8. New Project Procedure

1. Define or review `.qli/project-operating-profile.md`.
2. Create `.qli/security/security-posture.md`.
3. Fill initial surface, control, secrets, and data-protection inventories.
4. Apply baseline controls required by the operating profile.
5. Add tests for security-relevant features as they are built.
6. Update inventories and exceptions as scope changes.

## 9. Existing / Refactoring Procedure

1. Inspect existing security behavior before changing it.
2. Inventory current surfaces, secrets, controls, dependencies, and sensitive data.
3. Classify gaps against the current operating profile.
4. Preserve valid behavior unless migration is approved.
5. Refactor toward centralized, testable controls.
6. Add regression tests for fixed vulnerabilities and preserved behavior.
7. Document temporary exceptions.

## 10. Completion Standard

Security-sensitive work is complete only when:

- The posture and trigger matrix were checked.
- Required controls were implemented or documented as exceptions.
- Security inventories were updated.
- Tests or smoke checks were added or updated.
- Deferred risks were explicitly reported.

---

## QLi v2 Addendum — Security Baseline Controls

Security is triggered by exposure, identity, data sensitivity, tenancy, files, payments, integrations, webhooks, secrets, logging, dependencies, and deployment reality. It is not optional simply because the project is early-stage.

Minimum security baseline evidence:

- External input validation strategy.
- Output encoding / XSS prevention strategy for UI projects.
- CSRF/session/CORS/token policy where applicable.
- Authentication and authorization handoff to ACL where applicable.
- Secrets handling rule: no secrets in source, fixtures, logs, client payloads, screenshots, or error pages.
- File upload/download policy when files exist: type, size, storage, path traversal, access control, scan/quarantine decision.
- Webhook/API token policy when integrations exist: verification, replay/idempotency, logging safety.
- Dependency hygiene rule: no unexplained new packages in sensitive paths.
- Safe error policy: no stack traces or sensitive internals in public responses.
- Dev route/tooling exposure policy: no dev tools exposed publicly without explicit protection.

Advanced security controls are activated by profile and feature triggers, but these baseline decisions must be made early.

## Buildline Implementation Control

This foundation is governed operationally by `.qli/security/specs/security-implementation-control.md`.

Use the full reference for doctrine and vocabulary. Use the implementation-control file for the project-agnostic minimum spine, optional capability rules, deferral rules, evidence expectations, test/smoke expectations, common AI-agent failure modes, and definition of done.

Project-specific applicability is not decided inside this reference file. It is decided through `.qli/binding/` and recorded in `.qli/project/foundation-applicability.yml`.
