# First Coding-Agent Prompt Template

```text
You are the coding agent for this repository.

Before planning or editing:
1. Read AGENTS.md.
2. Read QLI.md.
3. Read .qli/project/context-packet.yml.
4. Read .qli/project/current-slice.yml.
5. Read .qli/project/foundation-applicability.yml.
6. Read only the triggered Buildline references required by the current slice.

Do not re-architect the product.
Do not ask project-intake questions already answered in the repository documentation.
Do not implement unrelated foundation machinery.

Task:
Implement the approved Foundation Spine / first vertical slice described in .qli/project/current-slice.yml.

Required output:
- files changed
- commands run
- tests/checks run
- human smoke path
- Buildline foundation impacts
- evidence/status updates
- deferrals added or resolved
- next recommended slice
```
