# DevBox Runtime — SquirrelMail

## Quick start

```bash
# Start all services
bash devbox-setup.sh

# Or manually:
docker compose up -d
```

SquirrelMail will be available at: **http://127.0.0.1:20100/**

## Architecture

```
┌─────────────────────────────────────────────┐
│  Docker Network: devbox-net                  │
│                                              │
│  ┌──────────┐  ┌──────────┐  ┌───────────┐ │
│  │ PHP 8.3  │  │ Dovecot  │  │ Mailpit   │ │
│  │ Apache   │  │ IMAP     │  │ SMTP      │ │
│  │   :80    │  │   :143   │  │   :1025   │ │
│  └────┬─────┘  └──────────┘  └───────────┘ │
│       │                                      │
└───────┼──────────────────────────────────────┘
        │ 127.0.0.1:20100
        ▼
   [Browser]
```

## Services

| Service | Container | Internal Port | Host Port | Purpose |
|---|---|---|---|---|
| web | squirrelmail-web | 80 | 127.0.0.1:20100 | SquirrelMail application |
| imap | squirrelmail-imap | 143 | (none) | Test IMAP server |
| smtp | squirrelmail-smtp | 1025 | (none) | SMTP capture (Mailpit) |

## Test credentials

| Username | Password | Purpose |
|---|---|---|
| testuser | testpass | General testing |
| devbox | devbox | DevBox operator testing |

These are static accounts defined in `docker/dovecot/users.passwd`.

## SMTP behavior

All outbound mail is captured by Mailpit. No mail leaves the DevBox
Docker network. To inspect captured mail:

```bash
docker compose exec smtp mailpit
```

## Configuration

SquirrelMail reads its runtime config from `docker/devbox.config.php`,
which is mounted into the container as `config/config.php`.

Default settings (from `config/config_default.php`) are loaded first,
then overridden by the DevBox config.

## Data persistence

- User preferences: Docker named volume `squirrelmail_data`
- Attachments: Docker named volume `squirrelmail_attach`
- IMAP mail storage: Docker named volume `squirrelmail_mail`

All data is outside the web root and private to the Docker network.

## Accessing configtest

The configuration test page is available at:
http://127.0.0.1:20100/src/configtest.php

Remote access is enabled for the DevBox Docker network (`$allow_remote_configtest = true`).
In production, this should be disabled.

## Login flow

1. Navigate to http://127.0.0.1:20100/ (redirects to src/login.php)
2. Enter test credentials (e.g., `testuser` / `testpass`)
3. SquirrelMail authenticates against the internal Dovecot IMAP server
4. On successful login, the mailbox interface renders

## Known limitations

1. **No TLS**: All connections between containers are plain text.
   This is acceptable for local DevBox testing only.
2. **Static test users**: IMAP users are defined in `docker/dovecot/users.passwd`.
   To add users, edit the file and restart the imap container.
3. **No persistent mail**: Docker volumes are ephemeral. Destroying volumes
   deletes all user data and mail.
4. **configtest remote access**: Enabled for DevBox convenience.
5. **No plugins**: Plugins are disabled in the DevBox config for minimal runtime.

## Stopping

```bash
docker compose down
```

To also remove volumes (destroys all test data):
```bash
docker compose down -v
```
