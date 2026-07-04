# Context Packet Protocol

The context packet is the operating handoff for an AI coding agent session.

Primary file:

```text
.qli/project/context-packet.yml
```

## What the context packet does

The context packet tells the agent what pass or slice is active; which project state files must be read; which Foundation implementation controls apply; which code areas are in scope; which areas are out of scope; which gates and evidence templates control completion; which validation tier is required; and when to stop instead of improvising.

## Lifecycle

```text
1. Human/co-architect defines or approves the context packet.
2. Coding agent reads the context packet before touching code.
3. Coding agent performs only the bounded work.
4. Coding agent updates evidence/status files.
5. Human/co-architect reviews the result through gates and smoke paths.
```

## Rule

A context packet is required for Foundation Spine implementation, ACL/security work, data model changes, release hardening, broad refactors, and any work that changes project architecture or Buildline state.

Small trivial edits may skip a context packet only when they do not affect architecture, UI behavior, API/data contracts, ACL/security posture, runtime, delivery, or project state.
