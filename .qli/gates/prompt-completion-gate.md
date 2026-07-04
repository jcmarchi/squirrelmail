# Prompt Completion Gate

Use this gate to decide whether an AI coding agent response is complete enough to accept.

## Required result content

The response must include what changed; what did not change; which foundations were applied; which status/evidence files were updated; what tests or checks were run; the human smoke path when UI or reviewable behavior applies; valid deferrals or explicit statement that none were added; known remaining gaps; and one concrete next step.

## Rejection conditions

Reject the result or send it back for correction when code changed but foundation status/evidence did not; UI changed without a human smoke path; protected behavior changed without ACL/security evidence; data model changed without migration/classification evidence; tests are claimed but commands/results are missing; the agent broadened scope without approval; or the agent silently deferred required controls.
