# SquirrelMail QLi Buildline Adoption Plan

## Purpose

This plan governs the existing-project Buildline adoption of SquirrelMail QLi — a legacy PHP webmail application. The plan enforces behavior preservation, read-only discovery, Foundation applicability, and staged modernization readiness. SquirrelMail is an existing codebase, not a new project.

## Project Mode

- Mode: `existing_project_adoption`
- Target level: `spine`
- Current slice: `buildline-overlay`

## Foundation Spine

| Area | Required upfront? | Current status | Evidence | Deferrals |
|---|---:|---|---|---|
| ACD/Core | yes | not-started |  |  |
| UI/UX | profile-triggered | not-started |  |  |
| DATA | yes | not-started |  |  |
| API | profile-triggered | not-started |  |  |
| ACL | profile-triggered | not-started |  |  |
| Runtime | profile-triggered | not-started |  |  |
| Testing | yes | not-started |  |  |
| Observability | baseline | not-started |  |  |
| Delivery | yes | not-started |  |  |
| Security | baseline | not-started |  |  |
| DevBox | required | not-started | PR #1 runtime baseline merged |  |

## Existing-Project Adoption Sequence

1. **DevBox runtime baseline** — complete (PR #1). Docker Compose runtime with PHP 8.3 Apache, Dovecot test IMAP, Mailpit SMTP capture. App on 127.0.0.1:20110.
2. **Buildline overlay** — current (PR #2). Replace old Foundation overlay with current QLi Buildline model corrected for existing-project adoption.
3. **Adoption intake and behavior snapshot** — next pass. Read-only discovery of SquirrelMail architecture, runtime behavior, plugin model, data model, and configuration surface. Produce `.qli/project/adoption-intake.md` and `.qli/project/behavior-snapshot.md`.
4. **Risk map and Foundation applicability refinement** — populate `.qli/project/risk-map.md`. Refine `.qli/project/foundation-applicability.yml` based on discovery output.
5. **Baseline validation and smoke-test evidence** — verify DevBox runtime, login flow, IMAP/SMTP paths, configtest. Record evidence in `.qli/project/evidence-log.md`.
6. **Foundation Spine planning** — determine the minimum applicable Foundation Spine for SquirrelMail modernization based on operating profile and risk map.
7. **First controlled modernization slice** — execute the first approved modernization slice under Buildline gate control, with behavior preservation, evidence, and human smoke review.

## Risk Controls

- Preserve existing SquirrelMail behavior. Do not break the current application.
- Do not infer product architecture from placeholders. Base decisions on discovery.
- Defer only through `.qli/project/deferral-register.md`.
- Every adoption step must update `.qli/project/evidence-log.md` and `.qli/project/foundation-status.yml`.
- DevBox runtime is required; all work must be validated against the DevBox baseline.
