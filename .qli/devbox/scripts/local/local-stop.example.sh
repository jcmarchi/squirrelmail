#!/usr/bin/env bash
set -euo pipefail

COMPOSE_FILE="${COMPOSE_FILE:-compose.local.yaml}"
PROJECT_NAME="${COMPOSE_PROJECT_NAME:-<SLUG>_local}"

docker compose -p "$PROJECT_NAME" -f "$COMPOSE_FILE" down --remove-orphans

echo "Local runtime stopped."
