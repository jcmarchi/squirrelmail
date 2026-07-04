# Development Environment Foundation Manifest

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Package root

```text
/docs/devenv/
```

## Contents

```text
README.md
MANIFEST.md

doctrine/
  dev-environment-foundation.md
  devbox-project-runtime-foundation.md
  local-dev-environment-foundation.md
  devbox-vs-local-decision-matrix.md
  ai-agent-dev-environment-protocol.md
  port-allocation-standard.md
  security-baseline.md
  git-and-ownership-standard.md

directives/
  AGENT_DIRECTIVE.md

templates/
  devbox/
    devbox-profile.example.env
    docker-compose.php-mysql.yml
    docker-compose.python-fastapi.yml
    docker-compose.static-site.yml
    php-apache.Dockerfile
    python-fastapi.Dockerfile
    static-nginx.Dockerfile

  local/
    local-profile.example.env
    local-start.example.sh
    local-stop.example.sh
    local-smoke.example.sh
    docker-compose.local.example.yml

scripts/
  devbox/
    devbox-start.example.sh
    devbox-stop.example.sh
    devbox-smoke.example.sh

  local/
    local-start.example.sh
    local-stop.example.sh
    local-smoke.example.sh

prompts/
  AI_CODING_AGENT_DEV_RUNTIME_FOUNDATION_PROMPT.md
  AI_CODING_AGENT_DEVBOX_ADOPTION_PROMPT.md
  AI_CODING_AGENT_LOCAL_RUNTIME_ADOPTION_PROMPT.md

case-studies/
  case-a-php-mysql-webapp/
    CASE_STUDY.md
    devbox-profile.example.env

  case-b-multiservice-api-ui/
    CASE_STUDY.md
    devbox-profile.example.env

checklists/
  devbox-adoption-checklist.md
  local-runtime-checklist.md
  security-checklist.md
  handoff-report-template.md
```

## Intended use

This foundation is reusable. It should be copied into a project under `/docs/devenv/`. An AI coding agent may then read it and implement project-specific runtime files in active folders.

## Not intended use

Do not run this package as-is. Do not copy example files into active runtime locations without adaptation. Do not commit credentials, local `.env` files, private domains, private IP addresses, or personal user names.
