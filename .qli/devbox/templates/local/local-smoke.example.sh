#!/usr/bin/env bash
set -euo pipefail

LOCAL_APP_PORT="${LOCAL_APP_PORT:-<LOCAL_APP_PORT>}"
HEALTH_PATH="${HEALTH_PATH:-/health}"

curl -fsS "http://127.0.0.1:${LOCAL_APP_PORT}${HEALTH_PATH}"

echo
echo "Local smoke test passed."
