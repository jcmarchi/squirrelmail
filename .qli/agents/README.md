# Agent Integration Layer

`AGENTS.md` is developer-owned and project-specific.

`QLI.md` is the stable QLi Buildline integration contract.

This layer exists to document how agent instruction files should connect to Buildline without forcing developers to keep all QLi-specific instructions inside `AGENTS.md`.

## Root File Model

```text
AGENTS.md = thin project-specific agent file
QLI.md = QLi Buildline governance and execution contract
CLAUDE.md = Claude adapter; may import QLI.md with @QLI.md
CODEX.md = Codex adapter; explicitly instructs Codex to read QLI.md
.qli/ = Buildline operating system
```

## Files

```text
AGENTS.integration-rules.md
AGENTS.generation-template.md
AGENTS.foundation-block.md
AGENTS.prompt-control-block.md
```

`AGENTS.foundation-block.md` is retained as a compatibility reference for older Buildline packages. For new skeletons, prefer root `QLI.md`.
