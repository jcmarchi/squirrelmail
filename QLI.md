# QLi Buildline Instructions

**QLi Buildline** is a foundation-driven system for predictable AI-assisted software construction.

This file is the stable Buildline integration contract for this repository. It keeps QLi-specific operating rules outside `AGENTS.md` so developers can customize `AGENTS.md` without weakening Buildline governance.

## 1. Operating Position

This Universal Skeleton is a **new-project baseline**. It is not an existing-project adoption package and it is not a runtime questionnaire system.

In the intended workflow, the AI Co-Architect customizes this skeleton after the product brainstorming and architecture discussion are complete. The customized project repo should already contain the product documentation, root markdown files, Buildline project profile, applicability model, and first implementation direction before the coding agent begins.

Buildline controls:

```text
- project profiling
- foundation applicability
- upfront Foundation Spine
- vertical-slice execution
- gates and evidence
- deferrals and activation triggers
- human smoke review
- audit/doctor checks
- optional bounded skills
```

The Foundation is not the work. The product slice is the work. The Foundation governs the slice.

## 2. Canonical Sources

The canonical Buildline source is `.qli/`.

```text
.qli/buildline.yml
.qli/README.md
.qli/foundation-map.yml
.qli/binding/
.qli/project/
.qli/spine/
.qli/workflows/
.qli/gates/
.qli/evidence/
.qli/skills/
.qli/tools/
```

Use `docs/` for human-facing product documentation, ADRs, runbooks, implementation notes, and roadmap annotations. Do not create duplicate Foundation source files under `docs/`.

## 3. Required Startup Sequence for AI Coding Agents

At the start of a planning, coding, review, refactoring, or delivery session:

```text
1. Read AGENTS.md for project-specific instructions.
2. Read this QLI.md file.
3. Read .qli/buildline.yml.
4. Read .qli/README.md if present.
5. Read .qli/foundation-map.yml if present.
6. Read .qli/project/manifest.yml.
7. Read .qli/project/operating-profile.yml.
8. Read .qli/project/foundation-target.yml.
9. Read .qli/project/foundation-applicability.yml.
10. Read .qli/project/foundation-status.yml.
11. Read .qli/project/current-slice.yml when doing implementation work.
12. Read .qli/project/context-packet.yml when using compact prompts.
13. Read ROADMAP.md if present.
14. Read the most recent relevant ADRs under docs/adr/ if present.
15. Read only the Foundation references triggered by the task.
16. If the task matches an enabled preset skill, read SKILLS.md, .qli/skills/skill-index.yml, and only the selected skill's SKILL.md.
17. Inspect the current implementation before proposing or making changes.
```

Do not reread the entire Buildline package by default. Context loading must follow `.qli/binding/agent-context-loading-rules.md` and `.qli/workflows/context-packet-protocol.md`.

## 4. Project State Files

Project-specific Buildline state is maintained under `.qli/project/`.

Required state files:

```text
.qli/project/manifest.yml
.qli/project/operating-profile.yml
.qli/project/foundation-target.yml
.qli/project/foundation-applicability.yml
.qli/project/foundation-status.yml
.qli/project/current-slice.yml
.qli/project/context-packet.yml
.qli/project/buildline-plan.md
.qli/project/evidence-log.md
.qli/project/deferral-register.md
.qli/project/prompt-log.md
```

Do not silently defer required foundation work. Use `.qli/project/deferral-register.md`.

## 5. Buildline Layers

```text
QLi Buildline = the whole system
QLi Foundations = generic doctrine/reference layer
QLi Binding = project-specific applicability layer
QLi Spine = required upfront implementation baseline
QLi Gates = completion and review controls
QLi Evidence = proof trail
QLi Doctor = audit/checking tool
QLi Skills = optional bounded execution modules
```

The Foundation reference layer is generic. The project binding layer determines what applies to this project. The implementation workflow executes only the approved scope.

## 6. Foundation Spine Rule

The Foundation must be built upfront as an operational spine sufficient to prevent predictable technical debt.

The minimum applicable spine includes:

```text
- UI shell or human-review surface when user-facing
- Core/domain/use-case boundary
- DATA classification and persistence convention
- API/interface pattern where applicable
- ACL policy/guard spine where applicable
- Security baseline from the operating profile and feature triggers
- Testing adapter, focused test command, and human smoke path
- Runtime/delivery setup, start/stop/smoke model, and configuration policy
- Observability baseline for health, safe errors, logs, and audit where applicable
- Foundation status and evidence trail
- Deferral register for approved non-implementation
```

Do not implement irrelevant enterprise machinery merely because a Foundation reference describes it. Defer only through `.qli/project/deferral-register.md`, with reason, activation trigger, owner/reviewer, and risk.

## 7. Skills Rule

Skills are optional bounded execution modules under `.qli/skills/`. They help skill-aware agents load only the execution guidance relevant to the current task.

Skills do not override `QLI.md`, `.qli/project/`, Buildline Binding, Gates, Evidence, or deferral rules.

## 8. Doctor Command

Use the Doctor as a structural verification tool when the skeleton or Buildline files change:

```bash
python .qli/tools/qli-buildline-doctor.py .
```

Git Bash / Linux / macOS may also run:

```bash
bash .qli/tools/qli-buildline-doctor.sh .
```

The Doctor is not a product build command. It checks Buildline structure only.

## 9. Non-Goals for This Skeleton

This Universal Skeleton does not provide runtime initialization scripts or existing-project adoption automation. For new projects, the AI Co-Architect performs skeleton customization before the repository is created or before the coding agent begins implementation.
