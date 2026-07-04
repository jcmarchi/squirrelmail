# Local Development Environment Foundation

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Purpose

Local runtime support exists to keep a project portable and to support onboarding, fallback development, and disconnected work.

Local runtime support does not replace DEVBOX. DEVBOX is the preferred active runtime when centralized data, demos, and remote AI-assisted execution matter.

## Local runtime responsibilities

A local runtime should provide:

- deterministic setup;
- cross-platform documentation;
- configurable non-standard host ports;
- simple start/stop/reset commands;
- smoke-test commands;
- clear cleanup behavior;
- no hard-coded user-specific paths;
- no secrets committed to Git.

## Platform policy

Local runtime scripts may support:

```text
Linux
Windows with WSL2/Docker Desktop
macOS with Docker Desktop or equivalent
```

When platform-specific scripts are required, isolate them clearly.

## Profiles

Local runtime should use a local profile file, for example:

```text
.dev/local.env
```

or a non-committed copy of:

```text
docs/devenv/templates/local/local-profile.example.env
```

Do not commit local profile files containing secrets or personal paths.

## Host ports

Local runtime host ports must be configurable because developers often run multiple projects.

Internal container ports may remain standard.

External host ports should be configurable in the local profile.

## Relationship with DEVBOX

Local runtime validates portability.

DEVBOX validates centralized runtime consistency.

Both should use the same application architecture and similar service names when practical.
