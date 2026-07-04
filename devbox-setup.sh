#!/bin/bash
# DevBox setup script for SquirrelMail
# Initializes test mail infrastructure (Dovecot IMAP maildirs, Mailpit)
# Run: bash devbox-setup.sh

set -e

echo "=== SquirrelMail DevBox Setup ==="

# Create docker directory structure if needed
mkdir -p docker/dovecot

# Generate local users.passwd from the committed example file.
# docker/dovecot/users.passwd contains public DevBox-only fixture
# credentials (not secrets). It is generated locally and gitignored.
if [ ! -f docker/dovecot/users.passwd ]; then
    echo "Generating docker/dovecot/users.passwd from example..."
    cp docker/dovecot/users.passwd.example docker/dovecot/users.passwd
fi

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
echo "SquirrelMail: http://127.0.0.1:20110/"
echo "Mailpit web UI: http://127.0.0.1:20110/mailpit (not routed; use docker compose exec smtp ... to inspect)"
echo ""
echo "Test IMAP credentials:"
echo "  Username: testuser  Password: testpass"
echo "  Username: devbox    Password: devbox"
echo ""
echo "SMTP is captured by Mailpit (no auth required, internal only)"
echo "All outbound mail is captured; nothing leaves the DevBox environment."
