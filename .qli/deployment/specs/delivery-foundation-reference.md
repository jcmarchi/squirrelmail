# Delivery / DevOps / Deployment Foundation Reference

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Version:** 1.0-Universal  
**Intended location:** `.qli/delivery-foundation-reference.md`  
**Audience:** AI Coding Companions, human architects, implementation reviewers, release operators  
**Purpose:** Define a reusable, technology-agnostic delivery, DevOps, and deployment foundation for new and existing application projects.

---

## 0. Mandatory Instruction to the AI Coding Companion

Before creating, modifying, deploying, packaging, configuring, or refactoring any delivery, environment, build, release, migration, backup, runtime-startup, infrastructure, or deployment behavior, read this file and treat it as the delivery source of truth for the repository.

Do not invent ad hoc deployment scripts, environment variables, build steps, release procedures, migration behavior, rollback instructions, storage paths, background-worker startup rules, or production assumptions when the repository already has a delivery foundation, adapter, operating profile, or documented deployment target.

Required reading before delivery-related work:

1. `.qli/application-construction-doctrine.md` if present.
2. `.qli/project-operating-profile.md` if present.
3. `.qli/delivery-foundation-reference.md`.
4. `.qli/delivery-adapter.md` if present.
5. `.qli/delivery-environment-inventory.md` if present.
6. `.qli/delivery-deployment-target-matrix.md` if present.
7. `.qli/delivery-release-inventory.md` if present.
8. `.qli/delivery-config-secrets-inventory.md` if present.
9. `.qli/delivery-backup-restore-matrix.md` if present.
10. `.qli/delivery-migration-rollback-plan.md` if present.
11. `.qli/delivery-test-matrix.md` if present.
12. Existing `README.md`, `SETUP.md`, `.env.example`, scripts, CI files, Docker files, infra manifests, cron files, deployment notes, migrations, workers, and runtime documentation.

AI Coding Companions must preserve the project operating profile unless an intentional architecture migration is approved and documented. Shared-hosting compatibility, no-build compatibility, self-hosting compatibility, open-source distributability, or portability constraints are product decisions, not incidental implementation details.

---

## 1. What This Foundation Is

The Delivery / DevOps / Deployment Foundation defines how an application is prepared, configured, released, deployed, migrated, rolled back, backed up, restored, started, operated, and promoted across environments. It is infrastructure-aware but infrastructure-agnostic.

It does not require Kubernetes, Docker, CI/CD, cloud services, serverless platforms, or managed infrastructure. It supports simple shared-hosting deployments, VPS installs, dedicated servers, Dockerized deployments, Kubernetes deployments, PaaS deployments, open-source packages, white-label/client-hosted installs, and hybrid models.

The foundation's primary rule is simple:

**Delivery must follow the product operating profile. Do not force a deployment model onto the application that contradicts its product, business, hosting, portability, or distribution requirements.**

---

## 2. Relationship to the Other Foundations

Delivery is a coordination layer. It does not own business logic, data design, UI behavior, authorization, API contracts, runtime execution, testing, or observability. It defines how those systems are packaged and moved safely between environments.

| Foundation | Delivery relationship |
|---|---|
| Application Construction Doctrine | Defines the product-to-architecture-to-vertical-slice process that delivery must support. |
| Application Core / Domain | Core code is packaged and released through delivery workflows; delivery must not move business logic into scripts. |
| Data | Delivery coordinates migrations, seed data, backups, restores, and schema rollout. |
| API | Delivery publishes API contracts, deploys endpoint behavior, and protects compatibility during releases. |
| UI | Delivery builds or serves UI assets according to the project stack and deployment target. |
| ACL | Delivery ensures route/admin/API protection is not broken by environment or deployment changes. |
| Runtime / Operations | Delivery starts or configures workers, queues, cron jobs, caches, sessions, and runtime processes. |
| Testing / Quality | Delivery defines release gates, smoke tests, migration checks, rollback checks, and production-readiness validation. |
| Observability / Audit / Telemetry | Delivery ensures logs, metrics, health checks, traces, and alerts are configured per environment. |
| Security | Security consumes the operating profile and deployment target to determine applicable controls. |

---

## 3. Project Operating Profile

Every serious application should define a short operating profile at `.qli/project-operating-profile.md`. This is the simple decision chain that keeps delivery, security, runtime, and infrastructure decisions aligned.

The operating profile should not be a complex configuration engine. It is a concise declaration of the intended product stage, distribution model, deployment target, exposure, tenancy, identity, data sensitivity, runtime model, and future direction.

Required fields:

| Field | Purpose |
|---|---|
| Product Stage | Prototype, MVP, private beta, public beta, production, enterprise, open-source, etc. |
| Distribution Model | Internal, proprietary hosted, client-hosted, open-source, SaaS, white-label, on-prem, hybrid. |
| Deployment Target | Shared hosting, VPS, dedicated server, Docker, Kubernetes, PaaS, serverless, air-gapped, hybrid. |
| Exposure | Local only, private network, public web, public API, partner API, public SaaS signup. |
| Tenancy | Single-tenant, multi-tenant, organization-scoped, workspace-scoped, hybrid. |
| Identity Model | No login, single admin, users, users + admins, tenant admins, platform admins, API clients, SSO. |
| Data Sensitivity | Public, internal, business confidential, PII, financial, regulated, secrets. |
| Runtime Model | Request-only, cron, queue workers, event consumers, long-running workers, scheduled jobs. |
| Current Build Target | The practical target this phase must support. |
| Future Target | Expected evolution path that should not be blocked by current decisions. |

If a requested feature changes one of these fields, the AI Coding Companion must update the operating profile or explicitly report the mismatch.

---

## 4. Delivery Principles

1. **Product stage controls delivery depth.** A prototype does not need the same release ceremony as a regulated production system, but it still needs safe environment configuration and reproducible setup.
2. **Deployment target is a constraint, not an afterthought.** Shared-hosting compatibility, Docker compatibility, or Kubernetes support must shape codebase structure, runtime assumptions, file paths, workers, and build artifacts.
3. **Configuration is externalized.** Environment-specific values belong in config, environment variables, secret stores, installer settings, or deployment manifests, not hard-coded source files.
4. **Builds must be reproducible.** A new environment should be able to install, configure, migrate, seed, build, and smoke-test the application from documented steps.
5. **Releases must be reversible where practical.** Migrations, assets, config changes, queue changes, API changes, and background jobs need rollback or forward-fix guidance.
6. **Deployment must respect data safety.** Schema changes, destructive migrations, backfills, file moves, and cache invalidations must be planned and tested.
7. **Delivery does not own runtime logic.** Workers, jobs, cron commands, and event consumers call Runtime and Core components; they do not embed business rules.
8. **Delivery does not own security, but it enables it.** TLS, secrets, permissions, headers, file paths, dev-route blocking, and production flags must be deployable correctly.
9. **No hidden operator knowledge.** Setup, deployment, rollback, and troubleshooting steps must be documented in repository files.
10. **No accidental infrastructure lock-in.** Use adapters, environment profiles, and documented constraints to preserve portability.

---

## 5. Supported Deployment Targets

The foundation must support the following targets without forcing any one model onto every project.

| Target | Typical use | Delivery implications |
|---|---|---|
| Shared hosting | Low-infra PHP or static/server-rendered apps | No root access, limited daemons, cron-based workers, webroot isolation, FTP/SFTP or panel deploys, careful file permissions. |
| VPS / Dedicated Server | Self-managed production or staging | Reverse proxy, system services, deploy user, logs, backups, cron/workers, TLS, firewall, process supervision. |
| Docker Host | Portable self-hosting or controlled server deploys | Image build, volumes, environment files, container health checks, migrations, service dependencies. |
| Kubernetes | Scalable SaaS or larger platform | Manifests/Helm/Kustomize, ingress, secrets, config maps, probes, jobs, workers, rolling deployment, resource limits. |
| PaaS | Managed hosting with deployment pipeline | Buildpacks, env vars, add-on services, release phase commands, logs, dynos/workers. |
| Serverless | Event/API-centric applications | Function packaging, cold starts, queue/event triggers, secret bindings, statelessness. |
| Static/Hybrid | Frontend-heavy or content apps | Static build, CDN invalidation, API/backend separation, environment injection. |
| Air-gapped / On-prem | Enterprise or regulated installs | Offline dependencies, installer packages, operator guide, upgrade/rollback bundles, no external calls by default. |
| Open-source distributable | Community/client installs | Safe defaults, installer checks, documented requirements, upgrade path, no proprietary assumptions. |

A project may support multiple targets. The operating profile must declare the current target and future target.

---

## 6. Environment Model

Recommended environments:

| Environment | Purpose | Required discipline |
|---|---|---|
| Local | Developer work and AI-agent implementation | Easy setup, local seed data, no production secrets. |
| Test / CI | Automated validation | Deterministic tests, isolated services, repeatable fixtures. |
| Demo | Human architect review, stakeholder preview | Stable sample data, demo-safe credentials, clear non-production banner. |
| Staging | Production-like validation | Production-like config, migrations, smoke tests, rollback checks. |
| Production | Real users and real data | Locked secrets, backups, monitoring, migration controls, dev routes disabled. |

Each environment should declare:

- base URL or route prefix;
- database/storage target;
- cache/session target;
- queue/worker mode;
- logging mode;
- debug/dev route availability;
- email/sms/payment mode;
- seed data policy;
- backup policy;
- access restrictions;
- smoke-test command/path.

---

## 7. Configuration and Secrets

Configuration is non-sensitive behavior selection. Secrets are sensitive credentials or tokens. They must not be mixed casually.

Configuration examples:

- app environment;
- base URL;
- feature flags;
- driver selection;
- mail mode;
- queue mode;
- cache mode;
- public asset URL;
- upload size limits.

Secret examples:

- database password;
- API keys;
- OAuth client secret;
- webhook signing secrets;
- encryption keys;
- SMTP password;
- private tokens;
- object storage keys.

Rules:

1. Provide `.env.example` or equivalent with safe placeholder values.
2. Never commit real secrets.
3. Fail safely when required secrets are absent.
4. Do not log secrets.
5. Use environment-appropriate secret storage: shared-hosting config file outside webroot, environment variables, platform secrets, Docker secrets, Kubernetes secrets, or external secret manager where available.
6. Keep application code independent from the secret source.
7. Document all required variables in the delivery adapter.

---

## 8. Build, Release, and Versioning

A release is not just a code change. It may include code, database migrations, data backfills, static assets, compiled frontend assets, worker changes, queue changes, API contract changes, config changes, scheduled tasks, and documentation.

Every release should document:

- release identifier or version;
- source branch/tag/commit;
- migration requirements;
- build commands;
- deployment target;
- environment variables changed;
- background workers/cron changes;
- API contract changes;
- data compatibility impact;
- smoke tests;
- rollback/forward-fix plan;
- known risks.

Versioning should be project-appropriate. Semantic versioning is recommended for distributable packages and APIs. Internal SaaS may use release IDs, tags, or deployment numbers, but externally visible API contracts must still be versioned.

---

## 9. Deployment Workflow Standards

A generic deployment workflow should include:

1. Preflight: confirm branch, tag, environment, dependencies, secrets, backup, migration plan, and target.
2. Build/package: produce artifacts according to the operating profile.
3. Maintenance/traffic handling: decide whether the deployment is zero-downtime, maintenance-mode, rolling, blue/green, or manual.
4. Database/schema: run safe migrations, backfills, or schema checks.
5. Assets: publish or invalidate assets.
6. Runtime: restart/reload required processes, workers, cron, queues, or caches.
7. Smoke test: run minimum endpoint/UI/API/CLI checks.
8. Observability: confirm logs/health/error reporting.
9. Release record: update release inventory or deployment notes.
10. Rollback readiness: confirm the rollback or forward-fix path remains valid.

Deployment style is target-specific. A shared-hosting deployment may be SFTP plus migration script plus smoke test. A Kubernetes deployment may be image build, manifest apply, migration job, rolling rollout, and health check.

---

## 10. Migrations, Backfills, and Rollbacks

Migrations are delivery events and data events. They must follow both Delivery and Data Foundation rules.

Rules:

1. Prefer backward-compatible additive changes.
2. Do not remove live fields, tables, endpoints, or event payloads without a migration plan.
3. Separate schema change from data backfill where risk is meaningful.
4. Make migrations idempotent where practical.
5. Record whether a migration is reversible, forward-only, or requires manual recovery.
6. Do not deploy code that assumes a migration has completed unless the deployment sequence guarantees it.
7. Test old-record readability after migrations.
8. Take backups before destructive or high-risk migrations.
9. Record rollback limits explicitly.

Rollback types:

| Type | Description |
|---|---|
| Code rollback | Revert code/assets to previous release. |
| Config rollback | Restore previous environment settings. |
| Migration rollback | Reverse schema/data changes when safe. |
| Forward fix | Apply corrective patch when rollback is unsafe. |
| Restore | Recover data from backup. |
| Reconciliation | Repair projections, caches, queues, or external sync state. |

---

## 11. Backups and Restore

Backups are not complete until restore has been tested.

Backup policy should cover:

- database;
- files/uploads;
- object storage;
- configuration;
- secrets source references;
- logs/audit records where retention requires it;
- generated assets or rebuild instructions;
- external service state if applicable.

Restore policy should define:

- restore owner;
- restore command/process;
- expected restore time;
- expected restore point;
- test frequency;
- environment where restore is validated;
- limitations.

For MVPs, this can be simple. For production, it cannot be informal.

---

## 12. Delivery for New Projects

For a new project, do not begin coding from an arbitrary scaffold. Follow this sequence:

1. Product/market/feature work is completed enough to justify an architecture direction.
2. Tech stack is selected based on business, product, deployment, UI, data, API, runtime, and security expectations.
3. Create or adapt the codebase skeleton.
4. Add `AGENTS.md` and foundation documents.
5. Create `.qli/project-operating-profile.md`.
6. Create `.qli/delivery-adapter.md`.
7. Create environment and setup documentation.
8. Establish local setup and smoke-test path.
9. Establish first deployable/demo target.
10. Deliver the first vertical slice through Core + Data + API + Test + UI.

The UI foundation must be built early enough to allow human review of implemented features through working screens.

---

## 13. Delivery for Existing / Refactoring Projects

For existing projects, do not replace working deployment behavior blindly. First document what exists.

Required audit:

- current stack and runtime;
- current deployment process;
- current environments;
- current config/secrets mechanism;
- current build pipeline;
- current database migrations;
- current backup/restore process;
- current workers/cron/scheduled tasks;
- current CI/CD or manual release process;
- current production risks;
- known drift between documentation and reality.

Then map current behavior to the foundation. Refactor incrementally, preserving valid behavior unless migration is explicitly approved.

---

## 14. Delivery Maturity Levels

| Level | Meaning |
|---|---|
| 0 | No reproducible setup or deployment documentation. |
| 1 | Local setup documented; manual deployment possible; no reliable release discipline. |
| 2 | Environment variables, migration process, smoke tests, and basic release notes exist. |
| 3 | Repeatable deployment, backups, rollback/forward-fix notes, and environment inventory exist. |
| 4 | CI/CD or scripted release path, automated tests, health checks, observability, and restore tests exist. |
| 5 | Production-grade release governance, multi-environment promotion, automated safety gates, tested rollback/restore, audit-ready deployment evidence. |

The target maturity depends on product stage and operating profile. A prototype may be Level 1 or 2. A public production app should not remain below Level 3.

---

## 15. Technology Policy

This foundation is technology-agnostic. It supports PHP, Python, Go, Java, .NET, Ruby, static/hybrid systems, server-rendered applications, and other stacks.

Project-specific technology restrictions must be preserved. If the project states that Node.js or Laravel are not allowed as core application technologies, the AI Coding Companion must not introduce them as core runtimes or frameworks. Node-based tooling, generated clients, frontend build utilities, or non-core modules may be used only when explicitly documented and compatible with the operating profile.

Do not introduce Docker, Kubernetes, cloud services, CI/CD platforms, queues, managed databases, or deployment automation merely because they are common. They must match the operating profile.

---

## 16. Acceptance Checklist

Delivery work is not complete until the following are true, as applicable:

- [ ] Operating profile is present or updated.
- [ ] Delivery adapter maps the repository to the operating profile.
- [ ] Setup instructions are accurate.
- [ ] Environment variables and secrets are documented safely.
- [ ] Deployment target is documented.
- [ ] Build/package steps are documented.
- [ ] Migrations/backfills are documented and tested.
- [ ] Rollback or forward-fix path is documented.
- [ ] Backup/restore expectations are documented.
- [ ] Runtime dependencies such as workers, cron, queues, cache, and sessions are documented.
- [ ] UI/API/Data/ACL/Runtime/Observability impacts are addressed.
- [ ] Smoke tests are defined and run.
- [ ] Known delivery risks are reported.

---

## QLi v2 Addendum — Delivery Spine

Delivery must make the product startable, inspectable, and recoverable according to its stage. Do not impose heavyweight infrastructure without operating-profile justification.

Minimum delivery spine evidence:

- Local or DevBox start command.
- Smoke command or manual smoke path.
- Environment/config file convention.
- Secrets handling rule.
- Migration command and rollback/forward policy when database migrations exist.
- Deployment target decision.
- Backup/restore decision when persistent production data exists.

## Buildline Implementation Control

This foundation is governed operationally by `.qli/deployment/specs/delivery-implementation-control.md`.

Use the full reference for doctrine and vocabulary. Use the implementation-control file for the project-agnostic minimum spine, optional capability rules, deferral rules, evidence expectations, test/smoke expectations, common AI-agent failure modes, and definition of done.

Project-specific applicability is not decided inside this reference file. It is decided through `.qli/binding/` and recorded in `.qli/project/foundation-applicability.yml`.
