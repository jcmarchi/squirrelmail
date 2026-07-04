# Security Review Checklist

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Use this before accepting security-sensitive work.

## Posture and Scope

- [ ] Project Operating Profile was reviewed.
- [ ] Security Posture matches the current product stage, exposure, tenancy, identity model, and deployment target.
- [ ] Trigger Matrix was checked for the requested feature.
- [ ] Required controls were implemented or added to the Exception Register.

## Application Controls

- [ ] Input validation exists at external boundaries.
- [ ] Output is escaped/encoded in the correct context.
- [ ] Sessions/cookies are safe where sessions exist.
- [ ] CSRF is enforced for browser state-changing requests where applicable.
- [ ] Server-side authorization is enforced for protected operations.
- [ ] Tenant/scope containment is enforced where scope exists.
- [ ] Errors do not leak secrets, internals, or sensitive data.

## Surfaces and Secrets

- [ ] Security Surface Inventory was updated.
- [ ] Secrets Inventory was updated without secret values.
- [ ] No secrets were committed, logged, exposed, or placed in fixtures.
- [ ] Dev/debug routes are blocked in production.

## Data and Observability

- [ ] Data Protection Matrix was updated for sensitive data.
- [ ] Logs and telemetry are privacy-safe.
- [ ] Audit events exist for privileged/security-relevant actions.

## Testing

- [ ] Security Test Matrix was updated.
- [ ] Positive and negative tests were added where applicable.
- [ ] Manual smoke checks were documented if automated tests are not yet available.

## Final Decision

- [ ] Approved.
- [ ] Approved with exceptions recorded.
- [ ] Rejected pending security correction.
