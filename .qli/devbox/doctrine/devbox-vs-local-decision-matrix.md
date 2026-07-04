# DEVBOX vs Local Runtime Decision Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Use DEVBOX when

- the project needs a stable demo URL;
- development data should persist centrally;
- AI coding agents need a consistent runtime;
- the human orchestrator works from multiple machines;
- browser testing must be available externally;
- the project benefits from production-like routing and TLS;
- quick presentation tweaks are likely.

## Use local runtime when

- a developer needs offline or isolated work;
- a new contributor needs onboarding;
- the project must prove portability;
- DEVBOX is unavailable;
- branch experiments should not touch the canonical demo runtime.

## Use both when

- the project has more than one developer;
- the project will evolve across several machines;
- local testing and centralized demos are both important;
- CI/staging/production discipline is expected later.

## Do not use DEVBOX as

- production;
- a replacement for GitHub;
- a replacement for CI;
- a multi-developer shared working tree without branch/workspace discipline;
- a place to expose databases publicly.

## Team expansion model

For team usage, avoid multiple developers editing the same working tree.

Preferred future structure:

```text
/srv/dev/projects/<PROJECT_DOMAIN>                  canonical demo runtime
/srv/dev/workspaces/<USER>/<PROJECT_DOMAIN>         per-developer workspace
/srv/dev/branches/<SLUG>-<BRANCH_NAME>              per-branch preview runtime
```

Each workspace should have its own route and port block.
