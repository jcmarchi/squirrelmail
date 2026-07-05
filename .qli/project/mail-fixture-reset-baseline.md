# Mail Fixture Reset Baseline — SquirrelMail DevBox

## 1. Objective

Pass 1 of 3 after the Mail Testability Baseline decision (PR #9). Create deterministic DevBox-only mailbox fixtures and reset/reseed tooling so test users can log in and read known messages before any SquirrelMail modernization begins. This enables deterministic read/regression testing.

## 2. Fixture Files

| File | Type | Subject | Tag |
|---|---|---|---|
| `docker/mail-fixtures/plain-text.eml` | text/plain | [SMQ Fixture] Plain Text Message | smq-fixture |
| `docker/mail-fixtures/html-message.eml` | text/html | [SMQ Fixture] HTML Message | smq-fixture |
| `docker/mail-fixtures/multipart-message.eml` | multipart/alternative | [SMQ Fixture] Multipart Message | smq-fixture |
| `docker/mail-fixtures/attachment-message.eml` | multipart/mixed + text attachment | [SMQ Fixture] Message with Attachment | smq-fixture |

All fixtures use `sender@devbox.local` as From address and `testuser@devbox.local` as To address. Stable Message-ID values. No sensitive content.

## 3. Target Users

- `testuser` — primary test user (4 fixtures seeded)
- `devbox` — secondary test user (4 fixtures seeded)

## 4. Maildir Layout Observed

```
/srv/mail/<user>/
  cur/           # INBOX (Dovecot moves new→cur on access)
  new/           # INBOX staging
  tmp/           # INBOX temp
  .INBOX.Sent/   # Sent folder
  .INBOX.Trash/  # Trash folder
  .INBOX.Drafts/ # Drafts folder
```

Dovecot settings: `mail_location = maildir:/srv/mail/%u`, `separator = /`, `first_valid_uid = 101`.

## 5. Seed Command

```bash
./docker/tools/seed-mail-fixtures.sh
```

Seeds 4 fixtures per user into Dovecot `INBOX/new`. Dovecot indexes and moves to `cur` on first mailbox access. Requires imap container running.

## 6. Reset Command

```bash
./docker/tools/reset-mail-fixtures.sh           # Remove fixtures only
./docker/tools/reset-mail-fixtures.sh --all-devbox-mail  # Remove ALL mail
```

Default mode is safe: removes only `smq-fixture`-tagged files. `--all-devbox-mail` removes all non-Dovecot-index files after a 5-second confirmation delay.

## 7. Idempotency Model

- **Seed**: Removes previous fixture-tagged files before seeding. Repeated runs produce exactly 8 files (4 per user × 2 users).
- **Reset**: Tag-based removal. Safe by default. Only removes fixture messages.
- **Reseed after reset**: Reset → Seed cycle is deterministic (8→0→8).

## 8. Validation Performed

| Check | Result |
|---|---|
| Seed produces 8 fixture files | ✅ |
| Reset removes all 8 fixtures | ✅ |
| Reseed restores exactly 8 | ✅ |
| Idempotent seed (run twice) | ✅ Still 8 |
| Browser: 4 fixtures visible in INBOX | ✅ "Viewing Messages: 1 to 4 (4 total)" |
| Browser: plain text fixture subject | ✅ |
| Browser: HTML fixture subject | ✅ |
| Browser: multipart fixture subject | ✅ |
| Browser: attachment fixture subject + icon | ✅ Attachment icon visible |
| Browser: attachment download | Pending |
| Browser: search by fixture subject | Pending |
| Browser: delete fixture message | Pending |
| Browser: move fixture message | Pending |

## 9. Risks and Limitations

- Attachment icon visibility is not equivalent to attachment download validation
- Search/delete/move operations not yet browser-validated
- Fixtures are seeded into `new/` and require Dovecot mailbox access to move to `cur/` and appear in the UI
- Fixtures do not survive `docker compose down -v` (expected — volumes are ephemeral)

## 10. Tests Now Enabled

| Test | Status |
|---|---|
| T3 Read plain text message | ✅ Read enabled (fixture seeded, UI visible) |
| T4 Read HTML message | ✅ Read enabled (fixture seeded, UI visible) |
| T5 Read multipart message | ✅ Read enabled (fixture seeded, UI visible) |
| T6 Read message with attachment | ✅ Read enabled (fixture seeded, icon visible) |
| T11 Delete message | Testable — pending validation |
| T12 Move message to folder | Testable — pending validation |
| T13 Search by subject | Testable — pending validation |
| T14 Attachment download | Testable — pending validation |

## 11. Explicit Non-Goals

- Does not implement user-to-user delivery (Pass 2)
- Does not implement Mailpit-to-Dovecot relay (Pass 2)
- Does not execute the full acceptance matrix (Pass 3)
- Does not modify SquirrelMail source code
- Does not expose IMAP/SMTP/Mailpit publicly
- Does not add long-running services
- Does not connect to external mail servers

## 12. Next Pass

Pass 2 — Local delivery harness (Mailpit-to-Dovecot relay script).
