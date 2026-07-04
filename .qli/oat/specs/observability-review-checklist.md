# Observability Review Checklist

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Use this checklist before accepting observability, audit, telemetry, diagnostics, or error-reporting work.

## Signal Design

- [ ] Signal type is clearly classified.
- [ ] Signal name is stable and follows naming conventions.
- [ ] Signal includes request/correlation context where applicable.
- [ ] Actor, tenant/scope, resource, and operation context are included where applicable.
- [ ] Severity is correct.
- [ ] Expected volume/cardinality is safe.

## Privacy and Security

- [ ] No secrets, credentials, tokens, raw cookies, or auth headers are emitted.
- [ ] No full request/response body dump exists by default.
- [ ] Sensitive fields are redacted, masked, hashed, or omitted.
- [ ] Audit records do not hide original actor during impersonation/delegation.
- [ ] Debug/diagnostic routes are access-controlled or disabled in production.

## Operations

- [ ] Health/status behavior is appropriate to deployment profile.
- [ ] Runtime/job failures emit actionable signals.
- [ ] Dead-letter/retry paths are visible.
- [ ] Alerts have owners and recovery instructions where production-relevant.
- [ ] Dashboards use documented signals.

## Testing and Documentation

- [ ] Signal inventories were updated.
- [ ] Audit event inventory was updated if audit behavior changed.
- [ ] Metric inventory was updated if metrics changed.
- [ ] Trace map was updated if flow boundaries changed.
- [ ] Privacy/safety matrix was updated if sensitive context changed.
- [ ] Tests or smoke checks validate signal emission.
- [ ] Tests verify sensitive data is not emitted.
