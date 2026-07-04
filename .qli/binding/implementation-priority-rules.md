# Implementation Priority Rules

The Buildline implementation sequence is designed to prevent foundation work from becoming an abstract side project.

## Priority Order

1. Establish project profile and binding.
2. Establish the Foundation Spine.
3. Implement one real vertical product slice.
4. Validate through Gates and Evidence.
5. Continue by product slices, not by isolated foundation departments.

## Upfront Spine Before Feature Accumulation

The following must be established before broad feature development unless explicitly marked not applicable:

```text
UI/human-review surface
API/interface pattern
DATA conventions and migration/seed strategy
ACL actor/capability/policy baseline when identity or privilege exists
Security baseline
Testing harness and human smoke path
Runtime/start/stop/smoke profile
Observability minimum signals
Delivery/config/environment conventions
Foundation status and deferral register
```

## Avoid These Failure Modes

```text
Backend-only implementation marked complete for a user-facing feature
UI built without testable data/API path
ACL deferred despite users/tenants/admin actions
Security treated as final hardening only
Tests run without human smoke/review surface
Foundation documents updated without product implementation evidence
Agent rereads all doctrine and restarts planning every prompt
```
