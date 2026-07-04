# Delivery Review Checklist

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/delivery-review-checklist.md`

Use this checklist before accepting delivery, environment, deployment, release, setup, or operations changes.

## Operating Profile

- [ ] `.qli/project-operating-profile.md` exists or was updated.
- [ ] Deployment target is clear.
- [ ] Product stage and exposure are clear.
- [ ] Runtime model is clear.
- [ ] Future target is documented.

## Setup and Environments

- [ ] `SETUP.md` is accurate.
- [ ] `.env.example` is safe and complete.
- [ ] Environment inventory is current.
- [ ] No real secrets are committed.
- [ ] Debug/dev routes are disabled in production.

## Release and Deployment

- [ ] Build/package steps are documented.
- [ ] Deployment steps are documented for the target environment.
- [ ] Required migrations are documented.
- [ ] Rollback or forward-fix path is documented.
- [ ] Runtime processes/cron/workers are documented.
- [ ] Smoke tests were run.

## Data Safety

- [ ] Backup/restore expectations are documented.
- [ ] Destructive migrations have explicit approval.
- [ ] Old-record readability is preserved where required.
- [ ] File/storage paths are appropriate for the target environment.

## Foundation Integration

- [ ] UI implications are handled.
- [ ] API contract implications are handled.
- [ ] DATA migration/storage implications are handled.
- [ ] ACL/security implications are handled.
- [ ] Runtime/worker implications are handled.
- [ ] Observability/logging implications are handled.
- [ ] Testing/quality gates are handled.
