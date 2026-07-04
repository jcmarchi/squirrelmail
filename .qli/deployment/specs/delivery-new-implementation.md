# AI Coding Agent Prompt - Delivery Foundation New Implementation

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Use this prompt when starting delivery, setup, environment, deployment, or release work in a new project.**

You are implementing the Delivery / DevOps / Deployment Foundation for a new application. Do not begin from arbitrary deployment assumptions. Follow the product operating profile and preserve the project's intended portability and deployment target.

Required steps:

1. Read `AGENTS.md`.
2. Read `.qli/application-construction-doctrine.md` if present.
3. Read `.qli/delivery-foundation-reference.md`.
4. Create or update `.qli/project-operating-profile.md`.
5. Create or update `.qli/delivery-adapter.md`.
6. Create or update delivery inventories and matrices:
   - `delivery-environment-inventory.md`
   - `delivery-deployment-target-matrix.md`
   - `delivery-release-inventory.md`
   - `delivery-config-secrets-inventory.md`
   - `delivery-backup-restore-matrix.md`
   - `delivery-migration-rollback-plan.md`
   - `delivery-test-matrix.md`
   - `delivery-review-checklist.md`
7. Ensure setup is reproducible from documented steps.
8. Ensure the first deployable/demo target is clear.
9. Ensure vertical feature work remains reviewable through Core + Data + API + Test + UI.
10. Report delivery maturity, deployment target, setup status, smoke-test path, and deferred risks.

Do not introduce Docker, Kubernetes, cloud services, CI/CD, queues, managed services, Node.js, Laravel, or new infrastructure assumptions unless the operating profile or explicit task authorizes them.
