# Git and Ownership Standard for Containerized Development

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Problem

Bind-mounted repositories often create ownership conflicts.

Example:

```text
Host repo owner: <USER>
Container process: root
Mounted path: /var/www/html
```

This can produce:

```text
fatal: detected dubious ownership in repository
```

It can also create root-owned files such as `vendor/`, `node_modules/`, or generated assets.

## Required mitigation

DEVBOX Dockerfiles should configure Git safe directory at image build time when the mounted path is known:

```dockerfile
RUN git config --system --add safe.directory /var/www/html
```

For non-PHP projects, replace `/var/www/html` with the container workdir.

## Preferred user model

Create a container user matching host UID/GID:

```dockerfile
ARG DEVBOX_UID=1000
ARG DEVBOX_GID=1000

RUN groupadd -g ${DEVBOX_GID} devbox \
    && useradd -m -u ${DEVBOX_UID} -g ${DEVBOX_GID} -s /bin/bash devbox
```

Then run dependency installers as that user where practical:

```bash
docker compose exec --user devbox app composer install
```

or equivalent for the project stack.

## One-time cleanup

If root-owned files already exist:

```bash
sudo chown -R $(id -u):$(id -g) vendor
```

Adjust the path for the project.

## AI agent rule

The AI coding agent must not leave root-owned generated files in a bind-mounted repository. If dependency installation creates root-owned files, the agent must either rerun as the project user or correct ownership and document the reason.
