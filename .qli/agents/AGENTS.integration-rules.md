# Agent Instruction Integration Rules

## Ownership

`AGENTS.md` belongs to the project skeleton and generated project.

`QLI.md` belongs to QLi Buildline integration.

Do not make `AGENTS.md` the canonical source for Buildline doctrine. Keep `AGENTS.md` thin enough for developers to customize without weakening Buildline governance.

## Required Root Files

A Buildline-enabled repository should include:

```text
AGENTS.md
QLI.md
```

Optional tool adapters:

```text
CLAUDE.md
CODEX.md
.github/copilot-instructions.md
```

## Required AGENTS.md Behavior

Root `AGENTS.md` must:

```text
1. Tell agents the repository uses QLi Buildline.
2. Instruct agents to read ./QLI.md before planning, editing, testing, refactoring, or reporting.
3. Preserve a section for project-specific agent instructions.
4. State that project-specific instructions must not override Buildline gates, evidence requirements, security controls, deferral rules, or .qli/project/ state without an approved project-profile update.
```

## Required QLI.md Behavior

Root `QLI.md` must contain or reference:

```text
.qli/buildline.yml
.qli/project/manifest.yml
.qli/project/operating-profile.yml
.qli/project/foundation-target.yml
.qli/project/foundation-applicability.yml
.qli/project/foundation-status.yml
.qli/binding/agent-context-loading-rules.md
.qli/workflows/
.qli/gates/
.qli/evidence/
.qli/tools/qli-buildline-doctor.sh
```

## Tool Adapter Rules

Claude-compatible adapters may use:

```text
@QLI.md
```

Do not assume all coding agents support import syntax. For Codex and generic agents, use explicit reference language:

```text
Read QLI.md before planning or editing.
```

## Safe Modification Policy

Do not overwrite a project-specific `AGENTS.md` blindly. If a project already has one, preserve its project-specific content and update only the Buildline reference to `QLI.md` unless the human architect explicitly approves broader regeneration.

Do not edit `QLI.md` casually. Updates to `QLI.md` affect Buildline governance and should be treated as a skeleton-level or architecture-level change.
