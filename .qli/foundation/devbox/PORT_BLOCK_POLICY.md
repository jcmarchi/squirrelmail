# Port Block Policy

## Purpose

DevBox assigns a port block to each managed project. The assigned port block is mandatory for DevBox operation and takes precedence over any project-native default ports for all DevBox-hosted runtime.

---

## Port block assignment is mandatory

Every DevBox-managed project must have an assigned DevBox port block.

The port block defines the host-side port range reserved for this project's containers on the DevBox server. Port block assignments are recorded in:

- `.qli/project/` metadata within the project repository
- DevBox server-side registry metadata as applicable

Port block assignments must not be chosen ad hoc during onboarding. They must be assigned through the DevBox port allocation process to prevent conflicts between projects.

---

## Project-native defaults are standalone defaults only

Many projects define default port numbers for local development. These defaults exist for standalone local use and have no authority inside a DevBox-managed environment.

Example: A project that defaults to port 41730 for a backend service and 41731 for a frontend service uses those values for the convenience of developers running the project directly on their laptops. Those values may already be in use by another DevBox-managed project. They must be overridden by the DevBox-assigned port block during onboarding.

AI Coding Agents and human operators must not assume that a project's README-documented or Compose-default ports are safe to use inside DevBox without checking the port allocation registry.

---

## Override strategy

Onboarding must:

1. Inspect current project-native defaults (from `README.md`, `docker-compose.yml`, `.env.example`, or equivalent).
2. Identify which ports are configurable via environment variable or Compose override.
3. Apply DevBox-assigned port block values through the appropriate override mechanism.
4. Prefer environment variable overrides (`docker-compose.override.yml` or `.env`) over source-code changes.
5. Document the override mechanism and assigned values in `.qli/project/` metadata.

---

## Host binding rules

- Application containers must bind to `127.0.0.1:<ASSIGNED_PORT>` on the host, not `0.0.0.0:<ASSIGNED_PORT>`.
- Binding to `0.0.0.0` is forbidden unless explicitly approved by the DevBox operator and documented in `.qli/project/` metadata with a justified reason.
- Caddy is the only ingress layer. Direct external access to application ports bypasses route policy and must not be enabled by default.

---

## Database port rules

- Database containers must not expose their ports publicly.
- A database port binding such as `0.0.0.0:5432->5432/tcp` is a misconfiguration in a DevBox-managed project.
- Database containers should be accessible only within Docker networks. Use Adminer, DbGate, or DevBox network helpers for administrative access.

---

## Caddy ingress rule

All external HTTP/HTTPS traffic must flow through Caddy. Direct container port exposure to the public network is not permitted for DevBox-managed projects. Route registration through the DevBox registry is the required path to external access.

---

## Recording port assignments

Port assignments must be recorded in two places:

1. `.qli/project/` — project-local record of the assigned port block, individual port assignments, and override mechanism used.
2. DevBox server-side registry — as part of the standard project registration process.

Port assignments are the responsibility of the DevBox operator and must be confirmed before any runtime or route generation work begins.
