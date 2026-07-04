#!/usr/bin/env bash
set -euo pipefail
ROOT="${1:-.}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
python "${SCRIPT_DIR}/qli-buildline-doctor.py" "$ROOT"
