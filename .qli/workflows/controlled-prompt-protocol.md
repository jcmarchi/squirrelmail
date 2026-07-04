# Controlled Prompt Protocol

QLi Buildline uses short prompts only when project state and binding outputs carry the missing context.

A short prompt is not a compressed replacement for the Foundations. It is an execution trigger that points the AI coding agent to the correct state files, workflow, gates, and evidence requirements.

## Principle

```text
Do not make prompts long because the system is vague.
Make the system explicit, then make prompts short.
```

## Required prompt contract

Every implementation prompt must establish or reference:

```text
1. Project mode: new-project, active-development, maintenance, audit, or hardening.
2. Current slice or pass.
3. Triggered foundations.
4. Required context files.
5. Files or areas not to touch.
6. Expected product evidence.
7. Validation tier.
8. Stop conditions.
9. Required status/evidence updates.
```

If those fields are already present in `.qli/project/context-packet.yml` and `.qli/project/current-slice.yml`, the prompt may remain short and simply tell the agent to follow those files.

## Invalid compact prompt

```text
Implement the Foundation for this app.
```

This is invalid because it does not identify scope, binding, triggered foundations, validation tier, evidence, or stop conditions.

## Prompt length rule

Prompts should be as short as possible but no shorter than the context contract allows. The Foundation files remain complete; compact prompts must not delete, override, summarize away, or weaken doctrine.
