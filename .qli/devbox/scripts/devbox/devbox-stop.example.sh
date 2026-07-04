#!/usr/bin/env bash
set -euo pipefail

COMPOSE_PROJECT_NAME="${COMPOSE_PROJECT_NAME:-<SLUG>_main}"

docker compose -p "$COMPOSE_PROJECT_NAME" down --remove-orphans

echo "DEVBOX runtime stopped."
