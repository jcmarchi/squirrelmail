#!/usr/bin/env bash
set -euo pipefail

APP_PORT="${APP_PORT:-<APP_PORT>}"
PUBLIC_HOST="${PUBLIC_HOST:-<SLUG>.<DOMAIN>}"
HEALTH_PATH="${HEALTH_PATH:-/health}"

curl -fsS "http://127.0.0.1:${APP_PORT}${HEALTH_PATH}"

echo
curl -I -H "Host: ${PUBLIC_HOST}" http://127.0.0.1

echo
echo "DEVBOX smoke test complete."
