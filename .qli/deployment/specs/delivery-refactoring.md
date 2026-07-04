# AI Coding Agent Prompt - Delivery Foundation Refactoring

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Use this prompt when an existing project already has setup, deployment, environment, release, scripts, CI, migrations, or infrastructure behavior.**

You are refactoring delivery behavior into the Delivery / DevOps / Deployment Foundation. Preserve working behavior unless a migration is explicitly approved.

Required steps:

1. Read `AGENTS.md`.
2. Read existing setup, deployment, CI, scripts, Docker/infra files, migrations, cron, workers, and environment documentation.
3. Read `.qli/delivery-foundation-reference.md`.
4. Create or update `.qli/project-operating-profile.md` based on actual current behavior.
5. Create or update `.qli/delivery-adapter.md`.
6. Inventory current environments, targets, config/secrets, migrations, releases, backups, and delivery risks.
7. Identify drift between documentation and reality.
8. Refactor incrementally; do not replace a working process blindly.
9. Add smoke tests or documented validation paths.
10. Update delivery matrices and report compatibility impact.

Required report:

- Current delivery maturity.
- Existing deployment behavior preserved.
- Changes made.
- Setup/deploy commands validated.
- Migration/rollback impact.
- Deferred delivery risks.
- Next safe refactoring step.
