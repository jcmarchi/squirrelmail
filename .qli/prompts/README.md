# QLi Buildline Prompts

This directory contains controlled prompts for AI coding agents.

```text
compact/     Short execution prompts that rely on Buildline project state and the context packet.
```

Compact prompts must not reduce doctrine. They are valid only when `.qli/project/context-packet.yml`, binding outputs, workflows, gates, and evidence templates exist.

Use `.qli/workflows/prompt-usage-lifecycle.md` to choose the correct prompt.
