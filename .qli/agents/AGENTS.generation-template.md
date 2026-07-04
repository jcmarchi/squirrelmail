# AGENTS.md Generation Template

Use this template when creating a project-specific `AGENTS.md` from a project skeleton.

```markdown
# AGENTS.md — [Project Name] Agent Instructions

This repository uses **QLi Buildline**.

Before planning, editing, testing, refactoring, or reporting, read and follow `./QLI.md`.

`AGENTS.md` is intentionally project-specific. Developers may add local instructions here, but those instructions must not override QLi Buildline gates, evidence requirements, security controls, deferral rules, or `.qli/project/` state unless the project owner explicitly updates the Buildline project profile.

## Project Identity

| Field | Value |
|---|---|
| Product | [Project Name] |
| Tagline | [Short description] |
| Owner | [Owner / Organization] |
| Website | [Domain] |
| License | [License type] |
| Repository | [Repository URL] |
| Version | [Version] |

## Project-Specific Agent Instructions

[Generated from project scope, technology choices, constraints, stack decisions, and delivery expectations.]

## Non-Override Rule

When `AGENTS.md` and `QLI.md` appear to conflict, follow `QLI.md` for Buildline governance and use `AGENTS.md` only for project-specific details. If the conflict is material, stop and ask the project owner or update the appropriate `.qli/project/` profile/status file as part of an approved architecture decision.
```

## Generation Inputs

A project-specific `AGENTS.md` should be composed from:

```text
1. Generic project skeleton agent wrapper.
2. Project-specific product scope and stack decisions.
3. Project-specific constraints, prohibited technologies, and delivery expectations.
4. A reference to root QLI.md for Buildline governance.
```

Do not paste the full QLi Buildline doctrine into `AGENTS.md`. Keep the Buildline contract in root `QLI.md`.
