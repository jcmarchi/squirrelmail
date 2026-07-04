# Release Readiness Gate

Use this gate before demo, beta, production, enterprise delivery, or any externally reachable deployment.

## Required checks

- Buildline Foundation Gate passed or passed with valid deferrals.
- No unresolved blocker deferrals affecting release safety.
- Setup/start/deploy path documented.
- Required environment variables and secrets documented.
- Database migrations are controlled.
- Backup/restore posture is acceptable for the data risk.
- Public/authenticated/admin/API surfaces have security posture.
- ACL deny paths pass for protected actions.
- Human smoke paths pass.
- Health/observability path works.
- DevBox route/port/access audit passes when DevBox is used.

## Result

Release may proceed only if release-affecting risks are resolved or explicitly accepted by the project owner.
