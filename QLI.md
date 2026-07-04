# QLi Buildline Instructions — Existing Project Adoption

**QLi Buildline** is a foundation-driven system for predictable AI-assisted software construction.

This repository contains **SquirrelMail QLi**, an existing-project Buildline adoption and legacy modernization/revitalization case. The Buildline overlay has been applied to an already-existing SquirrelMail codebase. This is not a new-project skeleton.

The first obligation is to understand and preserve the existing product behavior. Do not refactor, reorganize, or implement Foundation requirements before completing read-only discovery and an adoption plan.

## 1. Operating Position

This package is for an **existing project** — SquirrelMail, a legacy PHP webmail application undergoing QLi Buildline adoption and eventual modernization.

The overlay provides:

```text
- Buildline governance contract
- generic Foundation reference controls
- project discovery tooling
- adoption intake workflow
- behavior snapshot workflow
- risk mapping workflow
- staged Foundation applicability and implementation workflow
- gates, evidence templates, and audit tooling
- optional bounded skills for skill-aware AI coding agents
```

The Foundation is not the work. The existing product is the work. The Foundation governs adoption without breaking current behavior.

## 2. Canonical Sources

The canonical Buildline source is `.qli/`.

```text
.qli/buildline.yml
.qli/README.md
.qli/foundation-map.yml
.qli/adoption/
.qli/binding/
.qli/project/
.qli/spine/
.qli/workflows/
.qli/gates/
.qli/evidence/
.qli/skills/
.qli/tools/
.qli/devbox/
```

Existing project documentation remains authoritative for product behavior. Buildline files record how the existing project is being brought under Foundation governance.

Do not move product documentation into `.qli/`. Use `.qli/` for Buildline governance, discovery output, adoption state, evidence, gates, and audit controls.

Use `docs/` for human-facing product documentation, ADRs, runbooks, implementation notes, and roadmap annotations. Do not create duplicate Foundation source files under `docs/`.

## 3. Required Startup Sequence for AI Coding Agents

At the start of an existing-project Buildline adoption session:

```text
1. Read this QLI.md file.
2. Read AGENTS.md if the repository already has one.
3. Read README.md, SETUP.md, CONTRIBUTING.md, ROADMAP.md, CHANGELOG.md, docs/, and other existing project documentation if present.
4. Read .qli/buildline.yml.
5. Read .qli/README.md.
6. Read .qli/project/manifest.yml.
7. Read .qli/project/operating-profile.yml.
8. Read .qli/project/foundation-target.yml.
9. Read .qli/project/foundation-applicability.yml.
10. Read .qli/project/foundation-status.yml.
11. Read .qli/project/context-packet.yml when using compact prompts.
12. Read .qli/project/current-slice.yml only after a first adoption slice is approved.
13. Read only the Foundation references triggered by the current adoption/evaluation task.
14. Inspect source code before proposing changes.
```

Do not reread the entire Buildline package by default. Context loading must follow `.qli/binding/agent-context-loading-rules.md` and `.qli/workflows/context-packet-protocol.md`.

## 4. Discovery Before Implementation

Before changing source code, the AI coding agent must perform a read-only discovery pass for this existing project. SquirrelMail is a legacy PHP webmail application. Understand its architecture, runtime, and behavior before any modernization work.

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

The Foundation reference layer is generic. The project binding layer determines what applies to this project. The adoption workflow executes only the approved scope.

## 6. DevBox Integration

SquirrelMail QLi runs inside QLi DevBox. The DevBox runtime baseline was established in PR #1. Key files:

- `docker-compose.yml` — DevBox runtime (PHP 8.3 Apache + Dovecot IMAP + Mailpit SMTP)
- `DEVBOX.md` — operator documentation
- `devbox-setup.sh` — one-command setup/start script
- `.qli/devbox/` — current Buildline DevBox foundation (canonical path)

The DevBox app port is `127.0.0.1:20110` (block-app-20110). All internal services (IMAP, SMTP) are private to the Docker network.

## 7. Non-Goals for This Pass

This existing-project Buildline overlay pass establishes governance structure only. It does not modify SquirrelMail application code, replace the architecture, introduce new frameworks, or perform modernization. Those are separate passes governed by the adoption plan.
