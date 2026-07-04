# Deferral Rules

Deferral is an accountability mechanism, not a way to hide technical debt.

A Buildline item may be deferred only when the project profile, target level, current slice, or operating model proves that the item is not needed now.

## Required fields

Every deferral must record:

- Foundation
- Item
- Decision: `deferred`, `partial`, `not_applicable`, or `blocked`
- Reason
- Risk
- Activation trigger
- Review point
- Owner/responsible role
- Evidence that current behavior remains safe

## Non-deferrable baselines

The following may not be silently deferred when applicable:

- Project manifest and operating profile
- Foundation applicability matrix
- Foundation status file
- Deferral register
- Human smoke path for implemented UI
- API response/error pattern for implemented endpoints
- Server-side ACL for protected actions
- Security baseline for public/authenticated applications
- Data classification for persisted/sensitive data
- Test command or explicit test-harness status
- Delivery/startup profile for demo/deployable projects

## Valid deferral examples

- Distributed tracing in a single-process MVP.
- Custom role builder before custom roles are required.
- Full public OpenAPI portal before external consumers exist.
- Queue system before asynchronous work exists.
- Backup automation before production data exists, provided production release gate blocks release until resolved.

## Invalid deferral examples

- Deferring ACL because only the UI hides the button.
- Deferring security because the project is in demo but publicly reachable.
- Deferring API contract while the UI consumes that endpoint.
- Deferring seed/demo data when the UI screen cannot be reviewed without it.
- Deferring migration discipline after modifying persistent schema.
