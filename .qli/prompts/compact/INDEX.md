# Compact Prompt Index

Use compact prompts only with active Buildline state files.

| Prompt | Use when | Product code changes? |
|---|---|---|
| 00 Context Packet | Context is missing, stale, or unclear | No |
| 01 Bind Project | Creating or repairing project binding | No |
| 02 Build Foundation Spine | Building upfront implementation spine | Yes |
| 03 Active Vertical Slice | Implementing approved product slice | Yes |
| 04 Gate Review | Reviewing completion/evidence | No |
| 05 Hardening Review | Demo/release/production readiness review | No by default |
| 06 Doctor Audit | Running/repairing Buildline structural audit | Structural only |
| 07 AGENTS Integration | Merging Buildline block into AGENTS.md | AGENTS only |

Rule: use the smallest prompt that matches the pass. Do not use a product-code prompt for read-only work.
