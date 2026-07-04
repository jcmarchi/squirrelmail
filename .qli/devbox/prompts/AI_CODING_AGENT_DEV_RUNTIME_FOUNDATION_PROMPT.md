# AI Coding Agent Prompt — Development Runtime Foundation

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


You are implementing development runtime support for this repository.

Read first:

```text
docs/devenv/README.md
docs/devenv/directives/AGENT_DIRECTIVE.md
project README.md
project SETUP.md, if present
project AGENTS.md, if present
project CLAUDE.md, if present
existing Docker/Compose/scripts files
```

Task:

Create or adjust the project runtime support without changing application architecture.

You must determine whether the project needs:

```text
DEVBOX runtime
local runtime
both
```

Rules:

- Do not overwrite root README.md, SETUP.md, AGENTS.md, CLAUDE.md, or compose files without explicit approval.
- Do not commit .env or credentials.
- Do not expose database/cache/object-storage/admin ports publicly.
- Use assigned DEVBOX ports.
- Keep product code portable.
- Prefer minimal wrappers and compose overrides.
- Validate compose configuration before starting.
- Run smoke tests.
- Report exact changed files and commands.

End your response with:

```text
Files changed:
Commands run:
Validation:
Smoke tests:
URLs:
Security notes:
Git status:
Known issues:
Next action:
REF: DEV-RUNTIME-FOUNDATION-001
```
