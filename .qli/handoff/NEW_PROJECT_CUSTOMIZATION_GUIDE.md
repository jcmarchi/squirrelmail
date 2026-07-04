# New Project Customization Guide

## Purpose

Use this guide when the AI Co-Architect converts the Universal Skeleton into a project-specific repository package after product brainstorming and architecture are complete.

## Required inputs

- Product scope and descriptive documentation.
- Technical architecture and implementation intent.
- Roadmap and first vertical slice.
- Stack decisions and prohibited technologies.
- Deployment and development environment expectations.
- Security, ACL, data, API, UI, runtime, testing, and observability expectations.
- Any supporting spreadsheets, diagrams, mockups, or market analysis.

## Required outputs

- Root markdown files customized to the project.
- `docs/` populated with product-specific scope, architecture, roadmap, implementation notes, and ADRs as applicable.
- `AGENTS.md` project-specific section completed.
- `QLI.md` kept as the Buildline contract unless a project-specific Buildline exception is required.
- `.qli/project/` state files completed.
- First coding-agent prompt sequence prepared.

## Non-goal

Do not run a questionnaire against the project owner for values that are already known from the brainstorming/product architecture session.
