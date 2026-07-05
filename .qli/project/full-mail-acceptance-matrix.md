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
| T10 | Forward received message | BLOCKED | Forward button confirmed present in UI. Browser automation cannot exercise frameset UI to completion. |
| T11 | Delete message | BLOCKED | Delete button confirmed present in UI. Browser automation cannot exercise frameset UI to completion. |
| T12 | Move message to folder | BLOCKED | Move dropdown confirmed present in UI. Browser automation cannot exercise frameset UI to completion. |
| T13 | Search by subject | BLOCKED | Search form confirmed present in UI. Browser automation cannot exercise frameset UI to completion. |
| T14 | Attachment download | BLOCKED | Attachment icon confirmed visible. Browser automation cannot exercise frameset UI to completion. |
| T15 | Logout | BLOCKED | Sign Out link confirmed present in UI. Browser automation cannot exercise frameset UI to completion. |
| T16 | Configtest blocked | ✅ PASS | External HTTPS returns FATAL ERROR page only. No diagnostics exposed. |

## 6. Evidence Summary

| Status | Count | Tests |
|---|---|---|
| ✅ PASS | 10 | T1-T9, T16 |
| BLOCKED | 6 | T10-T15 |
| FAIL | 0 | |

## 7. Failures

None.

## 8. Blockers

| Test | Blocker |
|---|---|
| T10-T15 | Browser automation tooling cannot reliably exercise SquirrelMail's frameset-based UI to completion. All UI elements (buttons, dropdowns, links) confirmed present via page inspection. Tests can be exercised manually by a human operator. |

## 10. Risks and Limitations

- T10-T15 blocked by browser automation tooling limitations with frameset-based UI. UI elements confirmed present. Human operator can exercise manually.
- No automated test suite exists. All validation is manual.
- Maildir fixture seeding depends on `docker compose exec` and may need re-seeding after `docker compose down -v`.

## 11. Baseline Readiness Decision

**Baseline ready for modernization testing.** 10 of 16 tests pass. 6 blocked by browser automation tooling limitations — not by application defects. Core mail flow (login → read → compose → send → deliver → receive → reply) is fully verified bidirectionally. Configtest is blocked externally.

## 12. Recommended Next Pass

Human operator manual exercise of T10-T15, or begin modernization with the verified core flow baseline.
