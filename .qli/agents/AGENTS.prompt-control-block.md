# AGENTS.md Prompt Control Block

This block may be merged into a project-specific `AGENTS.md` when QLi Buildline is used.

## Compact prompt rule

Compact prompts are allowed only because Buildline state files carry the missing context. Before implementation, read:

```text
.qli/project/context-packet.yml
.qli/project/current-slice.yml
.qli/project/foundation-applicability.yml
.qli/project/foundation-status.yml
.qli/binding/agent-context-loading-rules.md
.qli/workflows/controlled-prompt-protocol.md
.qli/workflows/stop-conditions.md
```

## Scope rule

Do not broaden the task beyond the active pass or slice. If the work requires changing out-of-scope files, stop and report.

## Evidence rule

Implementation is incomplete until the required status/evidence/deferral files are updated or the report explains why no update applies.

## Stop rule

When a Buildline stop condition is hit, do not improvise. Stop, report the blocking condition, and recommend the smallest safe next action.
