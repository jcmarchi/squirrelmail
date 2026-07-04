---
name: buildline-agent-integration
description: Align AGENTS.md, QLI.md, CLAUDE.md, CODEX.md, SKILLS.md, and tool-specific adapters while preserving developer-owned project instructions.
---

# Buildline Agent Integration Skill

Use this skill when modifying AI-agent instruction files or integrating Buildline with a project skeleton.

## Required Inputs

Read:

```text
AGENTS.md
QLI.md
SKILLS.md
CLAUDE.md
CODEX.md
.qli/agents/README.md
.qli/agents/AGENTS.integration-rules.md
.qli/agents/AGENTS.generation-template.md
.qli/agents/AGENTS.foundation-block.md
.qli/skills/skill-index.yml
```

## Procedure

1. Preserve `AGENTS.md` as developer-owned and project-specific.
2. Keep QLi Buildline governance in `QLI.md` and `.qli/`.
3. Keep `SKILLS.md` as a short human index; canonical skill logic lives under `.qli/skills/`.
4. Keep `CLAUDE.md` and `CODEX.md` as adapters that reference `QLI.md`.
5. Do not move project-specific rules into generic Buildline files.
6. Do not remove developer sections unless explicitly requested.

## Required Output

```text
Agent Integration Result:
- Files changed:
- Developer-owned content preserved:
- Buildline references verified:
- Skill references verified:
- Risks or conflicts:
```

## Stop Conditions

Stop if a requested change would overwrite project-specific instructions, remove Buildline governance, or create conflicting agent entrypoints.
