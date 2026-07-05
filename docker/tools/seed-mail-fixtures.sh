#!/usr/bin/env bash
# seed-mail-fixtures.sh — Seed Dovecot maildirs with deterministic test messages.
# DevBox-only. Safe for repeated runs. No secrets. No production data.
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
FIXTURE_DIR="$REPO_ROOT/docker/mail-fixtures"
FIXTURE_TAG="smq-fixture"

echo "=== SquirrelMail DevBox Mail Fixture Seed ==="

# Verify docker compose is available
if ! docker compose version &>/dev/null; then
  echo "ERROR: docker compose not found."
  exit 1
fi

# Verify imap container is running
if ! docker compose -f "$REPO_ROOT/docker-compose.yml" ps imap 2>/dev/null | grep -q "Up"; then
  echo "ERROR: imap container is not running. Start with: docker compose up -d"
  exit 1
fi

# Verify fixtures exist
if [ ! -f "$FIXTURE_DIR/plain-text.eml" ]; then
  echo "ERROR: fixture files not found in $FIXTURE_DIR"
  exit 1
fi

USERS="testuser devbox"

seed_user() {
  local user="$1"
  local maildir="/srv/mail/$user"
  local count=0

  echo "Seeding $user..."

  # Ensure INBOX directories exist
  docker compose -f "$REPO_ROOT/docker-compose.yml" exec -T imap \
    mkdir -p "$maildir/new" "$maildir/cur" "$maildir/tmp" 2>/dev/null || true

  # Remove any previous fixture messages (idempotency)
  docker compose -f "$REPO_ROOT/docker-compose.yml" exec -T imap \
    sh -c "find $maildir -type f -name '*$FIXTURE_TAG*' -delete 2>/dev/null" || true

  # Seed each fixture into INBOX/new (Dovecot moves to cur on first access)
  for eml in "$FIXTURE_DIR"/*.eml; do
    local basename
    basename=$(basename "$eml" .eml)
    local dest="$maildir/new/$(date +%s).M$$.$(hostname),S=$FIXTURE_TAG-$basename"

    docker compose -f "$REPO_ROOT/docker-compose.yml" exec -T imap \
      sh -c "cat > '$dest'" < "$eml" 2>/dev/null || true

    docker compose -f "$REPO_ROOT/docker-compose.yml" exec -T imap \
      chown dovecot:dovecot "$dest" 2>/dev/null || true

    count=$((count + 1))
  done

  echo "  Seeded $count messages for $user"
}

for user in $USERS; do
  seed_user "$user"
done

echo ""
echo "=== Seed complete ==="
echo "Users: $USERS"
echo "Tag: $FIXTURE_TAG"
