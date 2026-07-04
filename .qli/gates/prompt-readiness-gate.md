# Prompt Readiness Gate

Use this gate before giving a coding agent an implementation prompt.

## Required checks

- The task is expressed as a bounded pass or slice.
- `.qli/project/context-packet.yml` exists or the prompt itself includes equivalent context.
- Project mode is clear.
- Triggered foundations are named or discoverable through the Binding Layer.
- In-scope and out-of-scope areas are clear.
- Existing-project work has a behavior snapshot when behavior preservation matters.
- Validation tier is selected.
- Required evidence files are named.
- Stop conditions are active.

## Failure result

If this gate fails, do not send a broad implementation prompt. First create or repair the context packet.
