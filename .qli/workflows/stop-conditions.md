# Agent Stop Conditions

The AI coding agent must stop and report instead of continuing when any of these conditions occurs.

## Binding and scope stops

- Required project profile fields are missing and the missing value affects implementation.
- `.qli/project/foundation-applicability.yml` is absent, stale, or contradicts the current task.
- The prompt asks for broad implementation without a bounded slice.
- The task requires changing areas marked out of scope in `.qli/project/context-packet.yml`.
- The agent discovers that the selected slice is too large to validate honestly.

## Existing-project safety stops

- The agent cannot identify behavior that must be preserved.
- Characterization/smoke tests are missing for a risky refactor.
- A proposed refactor would replace working behavior without explicit approval.
- The implementation requires data migration but current data assumptions are unknown.

## ACL, security, and data stops

- A protected route/action exists without server-side ACL.
- Tenant/account/workspace boundaries are unclear.
- Sensitive or persisted data exists without classification.
- A public/authenticated surface lacks the required security baseline.
- File upload/download, webhook, billing, or privileged operation scope is discovered but not in the context packet.

## Validation stops

- Required tests cannot run and there is no documented reason.
- A UI feature cannot be reviewed through a human smoke path.
- An API endpoint is consumed but response/error contract is undefined.
- The agent cannot produce evidence for the gate.

## Reporting rule

When a stop condition is hit, the agent must not invent a workaround. It must produce:

```text
Stop condition:
Why it blocks safe implementation:
Files/state inspected:
Recommended next action:
Minimal safe work, if any:
```
