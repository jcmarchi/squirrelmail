# QLi Buildline Skills

QLi Buildline skills are optional bounded execution modules for skill-aware AI agents.

They do not replace Buildline foundations, binding, gates, or evidence. They exist to help agents load only the execution instructions relevant to the current task.

## Default universal skills

The Universal Skeleton includes only Buildline-control skills:

- `buildline-context-packet`
- `buildline-bind-project`
- `buildline-spine`
- `buildline-vertical-slice`
- `buildline-gate-review`
- `buildline-evidence-report`
- `buildline-doctor-audit`
- `buildline-agent-integration`

Stack-specific skills such as API endpoint, UI component, data model, or ACL policy skills should be generated later from project-specific binding if needed.

## Disable a skill

Edit `.qli/skills/skill-index.yml` and set `enabled: false` for the skill.
