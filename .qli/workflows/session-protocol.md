# QLi Buildline Session Protocol

## Start of Session

1. Read `AGENTS.md`.
2. Read `.qli/README.md`.
3. Read `.qli/project/manifest.yml`.
4. Read `.qli/project/operating-profile.yml`.
5. Read `.qli/project/foundation-target.yml`.
6. Read `.qli/project/foundation-status.yml`.
7. Read `.qli/project/current-slice.yml` if present and populated.
8. Read `ROADMAP.md` and recent relevant ADRs if present.
9. Read only the foundation reference files triggered by the task.
10. Inspect the current implementation before changing code.

## During Session

- Work inside the approved slice.
- Keep product progress and foundation compliance together.
- Do not perform broad rewrites unless explicitly approved.
- Do not reread unrelated foundation documents.
- Do not create duplicate `.qli` foundation files.
- Use `.qli/project/deferral-register.md` for explicit deferrals.

## End of Session

1. Update product docs or roadmap if product scope changed.
2. Update `.qli/project/foundation-status.yml`.
3. Add an entry to `.qli/project/evidence-log.md`.
4. Update `.qli/project/deferral-register.md` if anything was deferred.
5. Update affected inventories/matrices/checklists where the foundation requires it.
6. Report validation by tier: static, focused automated, human smoke, full regression.
7. Provide one concrete next step.


## Workflow control addition

Read `.qli/project/context-packet.yml` before implementation when it exists. Compact prompts are valid only when the context packet or prompt defines the active slice, scope boundaries, triggered foundations, validation tier, evidence requirements, and stop conditions.
