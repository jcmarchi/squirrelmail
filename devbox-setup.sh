#!/bin/bash
# DevBox setup script for SquirrelMail
# Initializes test mail infrastructure (Dovecot IMAP maildirs, Mailpit)
# Run: bash devbox-setup.sh

set -e

echo "=== SquirrelMail DevBox Setup ==="

# Create docker directory structure if needed
mkdir -p docker/dovecot

# Start the services
echo "Starting DevBox services..."
docker compose up -d

# Wait for services to be ready
echo "Waiting for services to start..."
sleep 5

# Create maildirs for test users in the imap container
echo "Creating test IMAP maildirs..."
for USER in testuser devbox; do
    docker compose exec -T imap mkdir -p "/srv/mail/${USER}/cur" "/srv/mail/${USER}/new" "/srv/mail/${USER}/tmp" 2>/dev/null || true
done

# Set ownership (dovecot container uses dovecot:dovecot by default)
docker compose exec -T imap chown -R 5000:5000 /srv/mail/ 2>/dev/null || true

# Reload Dovecot to pick up users
docker compose restart imap 2>/dev/null || true

echo ""
echo "=== Setup complete ==="
echo "SquirrelMail: http://127.0.0.1:20100/"
echo "Mailpit web UI: http://127.0.0.1:20100/mailpit (not routed; use docker compose exec smtp ... to inspect)"
echo ""
echo "Test IMAP credentials:"
echo "  Username: testuser  Password: testpass"
echo "  Username: devbox    Password: devbox"
echo ""
echo "SMTP is captured by Mailpit (no auth required, internal only)"
echo "All outbound mail is captured; nothing leaves the DevBox environment."
