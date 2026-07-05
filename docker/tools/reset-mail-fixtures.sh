#!/usr/bin/env bash
# reset-mail-fixtures.sh — Remove fixture messages from Dovecot maildirs.
# Default: removes only fixture messages (tagged smq-fixture).
# --all-devbox-mail: removes ALL mail from all users (use with caution).
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
FIXTURE_TAG="smq-fixture"
ALL_MAIL=false

if [ "${1:-}" = "--all-devbox-mail" ]; then
  ALL_MAIL=true
  echo "WARNING: --all-devbox-mail specified. Will remove ALL mail for all users."
  echo "Press Ctrl+C within 5 seconds to cancel..."
  sleep 5
fi

echo "=== SquirrelMail DevBox Mail Fixture Reset ==="

if ! docker compose -f "$REPO_ROOT/docker-compose.yml" ps imap 2>/dev/null | grep -q "Up"; then
  echo "ERROR: imap container is not running."
  exit 1
fi

USERS="testuser devbox"
REMOVED=0

for user in $USERS; do
  maildir="/srv/mail/$user"
  echo "Resetting $user..."

  if $ALL_MAIL; then
    # Remove all message files, preserve Dovecot indexes
    count=$(docker compose -f "$REPO_ROOT/docker-compose.yml" exec -T imap \
      sh -c "find $maildir -type f -not -name 'dovecot*' -not -name 'subscriptions' -not -name 'maildirfolder' -delete -print 2>/dev/null | wc -l" 2>/dev/null || echo "0")
  else
    # Remove only fixture-tagged files
    count=$(docker compose -f "$REPO_ROOT/docker-compose.yml" exec -T imap \
      sh -c "find $maildir -type f -name '*$FIXTURE_TAG*' -delete -print 2>/dev/null | wc -l" 2>/dev/null || echo "0")
  fi

  count=$(echo "$count" | tr -d ' ')
  echo "  Removed $count files from $user"
  REMOVED=$((REMOVED + count))
done

echo ""
echo "=== Reset complete ==="
echo "Files removed: $REMOVED"
if $ALL_MAIL; then
  echo "Mode: ALL mail removed"
else
  echo "Mode: fixture messages only (tag: $FIXTURE_TAG)"
fi
