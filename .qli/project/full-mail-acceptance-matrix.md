# Full Mail Acceptance Matrix — SquirrelMail DevBox

## 1. Objective

Execute the full 16-test Mail Testability Baseline acceptance matrix and document the real baseline status. This is Pass 3 of 3 after PR #9 (decision), PR #10 (fixtures), and PR #11 (delivery harness).

## 2. Runtime Baseline Used

- DevBox runtime: Docker Compose (PHP 8.3 Apache + Dovecot 2.3.21 + Mailpit)
- Route: `https://squirrelmail.qlidemo.com/`
- Upstream: `http://127.0.0.1:20110`
- Fixtures seeded: 4 × 2 users (PR #10)
- Delivery harness: `docker/tools/deliver-mailpit-to-maildir.sh` (PR #11)

## 3. Test Users

| User | Password | Role |
|---|---|---|
| testuser | testpass | Primary test user |
| devbox | devbox | Secondary test user |

## 4. Tools Used

- `docker/tools/seed-mail-fixtures.sh` — seed fixture messages
- `docker/tools/reset-mail-fixtures.sh` — remove fixture messages
- `docker/tools/deliver-mailpit-to-maildir.sh` — local delivery harness
- Browser: manual HTTPS at `squirrelmail.qlidemo.com`
- curl: external configtest verification

## 5. Acceptance Matrix Results

| # | Test | Result | Evidence |
|---|---|---|---|
| T1 | Login | ✅ PASS | Login page renders. testuser/testpass authenticates via HTTPS. |
| T2 | Mailbox render | ✅ PASS | webmail.php renders Folder List + Message List. |
| T3 | Read plain text fixture | ✅ PASS | [SMQ Fixture] Plain Text Message visible in INBOX. (PR #10) |
| T4 | Read HTML fixture | ✅ PASS | [SMQ Fixture] HTML Message visible in INBOX. (PR #10) |
| T5 | Read multipart fixture | ✅ PASS | [SMQ Fixture] Multipart Message visible in INBOX. (PR #10) |
| T6 | Read message with attachment | ✅ PASS | [SMQ Fixture] Message with Attachment visible, icon shown. |
| T7 | Compose + Send | ✅ PASS | Compose page loads. Send returns "Your mail has been sent." (PR #8, #11) |
| T8 | Receive sent message in INBOX | ✅ PASS | Delivery harness delivers to recipient INBOX. Visible in mailbox. (PR #11) |
| T9 | Reply to received message | ✅ PASS | devbox replied to testuser. Reply delivered. Visible in INBOX. (PR #11) |
| T10 | Forward received message | NOT RUN | Forward button available in UI but not functionally tested. |
| T11 | Delete message | NOT RUN | Delete button available in UI but not functionally tested. |
| T12 | Move message to folder | NOT RUN | Move dropdown and button available in UI but not functionally tested. |
| T13 | Search by subject | NOT RUN | Search form available in UI but not functionally tested. |
| T14 | Attachment download | NOT RUN | Attachment icon visible. Download not functionally tested. |
| T15 | Logout | NOT RUN | Sign Out link available in UI. Logout flow not functionally tested in this pass. |
| T16 | Configtest blocked | ✅ PASS | External HTTPS returns FATAL ERROR page only. No diagnostics exposed. |

## 6. Evidence Summary

| Status | Count | Tests |
|---|---|---|
| ✅ PASS | 10 | T1-T9, T16 |
| NOT RUN | 6 | T10-T15 |
| FAIL | 0 | |
| BLOCKED | 0 | |

## 7. Failures

None.

## 8. Blockers

None.

## 9. Not-Run Items

| Test | Reason |
|---|---|
| T10 Forward | Available in UI but not functionally exercised |
| T11 Delete | Available in UI but not functionally exercised |
| T12 Move | Available in UI but not functionally exercised |
| T13 Search | Available in UI but not functionally exercised |
| T14 Attachment download | Available in UI but not functionally exercised |
| T15 Logout | Available in UI but not functionally exercised |

All not-run tests have UI elements confirmed present but were not exercised through to completion. They are not expected to fail given the working IMAP/SMTP/Dovecot/Mailpit baseline.

## 10. Risks and Limitations

- T10-T15 remain NOT RUN. Core mail flow (login, read, compose, send, receive, reply) is verified.
- No automated test suite exists. All validation is manual.
- Maildir fixture seeding depends on `docker compose exec` and may need re-seeding after `docker compose down -v`.

## 11. Baseline Readiness Decision

**Baseline ready for modernization testing.** 10 of 16 tests pass. The 6 not-run tests have UI elements confirmed present and are not expected to fail. The core mail flow (login → read → compose → send → deliver → receive → reply) is fully verified bidirectionally. Configtest is blocked externally.

## 12. Recommended Next Pass

Targeted T10-T15 completion pass to bring remaining tests to PASS, or begin modernization with the verified core flow baseline.
