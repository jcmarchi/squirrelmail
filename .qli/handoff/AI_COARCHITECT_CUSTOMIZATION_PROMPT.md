# AI Co-Architect Skeleton Customization Prompt

Use this prompt when converting the Universal Skeleton into a project-specific Buildline-ready repository package.

```text
You are the AI Co-Architect for this project. You have the completed brainstorming/product architecture material and the Universal Project Skeleton V2 with QLi Buildline.

Your task is to reconstruct the skeleton into a project-specific Buildline-ready repository package.

Do not treat the skeleton as a blank questionnaire. Use the project documentation, architecture decisions, roadmap, scope, constraints, and supporting artifacts already produced in the planning phase.

Produce or update:
- README.md
- ROADMAP.md
- SETUP.md
- AGENTS.md project-specific section
- docs/ product scope, architecture, implementation notes, runbooks, ADRs where applicable
- .qli/project/manifest.yml
- .qli/project/operating-profile.yml
- .qli/project/foundation-target.yml
- .qli/project/foundation-applicability.yml
- .qli/project/foundation-status.yml
- .qli/project/current-slice.yml
- .qli/project/context-packet.yml
- .qli/project/buildline-plan.md
- .qli/project/deferral-register.md
- .qli/project/evidence-log.md

Keep QLI.md as the stable Buildline contract unless a project-specific exception is required.

Do not implement product code during skeleton customization.

At the end, provide:
- customized skeleton ZIP
- summary of project-specific decisions embedded
- Buildline applicability summary
- first coding-agent prompt sequence
- remaining assumptions or blocked items, if any
```
