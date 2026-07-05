#!/usr/bin/env bash
# deliver-mailpit-to-maildir.sh
# DevBox-only standalone script. Relays Mailpit-captured local messages
# into Dovecot Maildir inboxes for testuser and devbox.
# Not a daemon. Not production infrastructure. Not publicly exposed.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
STATE_FILE="$REPO_ROOT/docker/tools/.local-delivery-state"
MAILPIT_API="http://127.0.0.1:8025/api/v1"
TMP_DIR="${TMPDIR:-/tmp}/smq-delivery-$$"

cleanup() { rm -rf "$TMP_DIR" 2>/dev/null || true; }
trap cleanup EXIT

echo "=== SquirrelMail DevBox Local Delivery Harness ==="

# Verify containers
if ! docker compose -f "$REPO_ROOT/docker-compose.yml" ps smtp 2>/dev/null | grep -q "Up"; then
  echo "ERROR: smtp container not running."
  exit 1
fi
if ! docker compose -f "$REPO_ROOT/docker-compose.yml" ps imap 2>/dev/null | grep -q "Up"; then
  echo "ERROR: imap container not running."
  exit 1
fi

mkdir -p "$TMP_DIR"

# Local recipient map: email → maildir user name
declare -A LOCAL_RECIPIENTS
LOCAL_RECIPIENTS["testuser@devbox.local"]=testuser
LOCAL_RECIPIENTS["devbox@devbox.local"]=devbox

# Load delivery state (delivered message IDs)
declare -A DELIVERED
if [ -f "$STATE_FILE" ]; then
  while IFS= read -r line; do
    DELIVERED["$line"]=1
  done < "$STATE_FILE"
fi

# Fetch message list from Mailpit
MSGS_JSON=$(docker compose -f "$REPO_ROOT/docker-compose.yml" exec -T smtp \
  wget -qO- "${MAILPIT_API}/messages" 2>/dev/null || echo '{"messages":[]}')

INSPECTED=0
DELIVERED_COUNT=0
SKIPPED_NONLOCAL=0
SKIPPED_DUPLICATE=0
ERRORS=0

# Preflight: python3 required for JSON parsing
if ! command -v python3 &>/dev/null; then
  echo "ERROR: python3 is required for Mailpit JSON parsing."
  echo "python3 is a DevBox system dependency and should be available."
  exit 1
fi

# Process each message
while IFS= read -r msg_id; do
  [ -z "$msg_id" ] && continue
  INSPECTED=$((INSPECTED + 1))

  # Check if already delivered
  if [ -n "${DELIVERED[$msg_id]:-}" ]; then
    SKIPPED_DUPLICATE=$((SKIPPED_DUPLICATE + 1))
    continue
  fi

  # Get recipient from a quick API call
  msg_detail=$(docker compose -f "$REPO_ROOT/docker-compose.yml" exec -T smtp \
    wget -qO- "${MAILPIT_API}/message/${msg_id}" 2>/dev/null || echo '{}')

  # Find first local recipient using proper JSON To field parsing
  local_user=""
  for email in "${!LOCAL_RECIPIENTS[@]}"; do
    match=$(echo "$msg_detail" | python3 -c "
import sys, json
try:
    m = json.load(sys.stdin)
    to_list = m.get('To', [])
    for r in to_list:
        if r.get('Address', '') == '$email':
            print('match')
            break
except: pass
" 2>/dev/null)
    if [ "$match" = "match" ]; then
      local_user="${LOCAL_RECIPIENTS[$email]}"
      break
    fi
  done

  if [ -z "$local_user" ]; then
    SKIPPED_NONLOCAL=$((SKIPPED_NONLOCAL + 1))
    continue
  fi

  # Download raw message
  raw_file="$TMP_DIR/${msg_id}.eml"
  if ! docker compose -f "$REPO_ROOT/docker-compose.yml" exec -T smtp \
    wget -qO- "${MAILPIT_API}/message/${msg_id}/raw" > "$raw_file" 2>/dev/null; then
    echo "  ERROR: failed to download raw message $msg_id"
    ERRORS=$((ERRORS + 1))
    continue
  fi

  # Ensure INBOX directories exist
  docker compose -f "$REPO_ROOT/docker-compose.yml" exec -T imap \
    mkdir -p "/srv/mail/${local_user}/new" "/srv/mail/${local_user}/cur" "/srv/mail/${local_user}/tmp" 2>/dev/null || true

  # Deliver to Dovecot maildir new/
  dest="/srv/mail/${local_user}/new/$(date +%s).M$$.delivery-S=${msg_id:0:12}"
  docker compose -f "$REPO_ROOT/docker-compose.yml" exec -T imap \
    sh -c "cat > '$dest'" < "$raw_file" 2>/dev/null

  # Set ownership
  docker compose -f "$REPO_ROOT/docker-compose.yml" exec -T imap \
    chown dovecot:dovecot "$dest" 2>/dev/null || true

  # Record delivery
  echo "$msg_id" >> "$STATE_FILE"
  DELIVERED["$msg_id"]=1
  DELIVERED_COUNT=$((DELIVERED_COUNT + 1))
  echo "  Delivered: $msg_id → $local_user ($(wc -c < "$raw_file") bytes)"

done < <(echo "$MSGS_JSON" | python3 -c "
import sys, json
msgs = json.load(sys.stdin)
for m in msgs.get('messages', []):
    print(m['ID'])
" 2>/dev/null)

echo ""
echo "=== Delivery Report ==="
echo "  Inspected:     $INSPECTED"
echo "  Delivered:     $DELIVERED_COUNT"
echo "  Skipped (dup): $SKIPPED_DUPLICATE"
echo "  Skipped (non-local): $SKIPPED_NONLOCAL"
echo "  Errors:        $ERRORS"
