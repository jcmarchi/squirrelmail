# QLi Buildline BuildGuide — New Project Baseline

This BuildGuide explains how this Universal Skeleton is used for new projects.

## Correct new-project flow

```text
1. Product brainstorming and architecture discussion with the AI Co-Architect.
2. Product documentation, scope, roadmap, architecture, and implementation intent are produced.
3. Optional spreadsheets, market/competition studies, diagrams, and mockups are produced when applicable.
4. The generic Universal Skeleton is uploaded to the AI Co-Architect.
5. The AI Co-Architect reconstructs the skeleton into a project-specific Buildline-ready repo package.
6. The user creates the repository and uploads the generated contents.
7. The AI Co-Architect performs one final repository safety pass.
8. The AI Co-Architect issues the first coding-agent implementation prompt.
```

## What the coding agent should receive

The coding agent should receive a repository where these are already set:

```text
README.md
ROADMAP.md
SETUP.md
AGENTS.md
QLI.md
docs/
.qli/project/manifest.yml
.qli/project/operating-profile.yml
.qli/project/foundation-target.yml
.qli/project/foundation-applicability.yml
.qli/project/current-slice.yml
.qli/project/context-packet.yml
```

The coding agent should not be asked to guess the product architecture from a blank skeleton.

## Agent rule

Do not ask an AI coding agent to implement every Foundation blindly. Ask it to execute the current slice under the current Buildline profile, reading only the context packet, triggered workflows, triggered foundations, gates, and evidence template.
