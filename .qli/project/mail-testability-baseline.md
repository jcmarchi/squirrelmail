# Mail Testability Baseline — SquirrelMail DevBox

## 1. Objective

Define how the SquirrelMail DevBox runtime will support predictable, repeatable modernization testing. This document establishes the decision standard, not the implementation.

## 2. Current Verified Mail Topology

```
                   ┌──────────────────────────────────────┐
                   │         Docker: devbox-net            │
                   │                                       │
  ┌────────────┐   │   ┌──────────────┐   ┌────────────┐  │
  │ SquirrelMail│──SMTP─▶│   Mailpit    │   │  Dovecot   │  │
  │  PHP 8.3   │   │   │  SMTP:1025   │   │  IMAP:143  │  │
  │  Apache     │◀─IMAP──│  (capture)   │   │  maildir:  │  │
  │             │   │   │  API:8025    │   │  /srv/mail │  │
  └────────────┘   │   └──────────────┘   └────────────┘  │
                   │                                       │
                   └──────────────────────────────────────┘
```

**Flow**: SquirrelMail → SMTP → Mailpit (capture sink). No path from Mailpit → Dovecot.

| Component | Config | Status |
|---|---|---|
| SMTP outbound | `smtp:1025`, no auth, no TLS | ✅ Verified (PR #8) |
| Mailpit capture | `axllent/mailpit:latest` | ✅ Verified |
| Dovecot IMAP | `imap:143`, maildir:/srv/mail/%u | ✅ Verified (PR #6) |
| IMAP auth | PLAIN/LOGIN, passwd-file | ✅ Verified |
| Special folders | INBOX/Trash, INBOX/Sent, INBOX/Drafts | ✅ Verified (PR #7) |
| Internal delivery | ❌ Not implemented | |

## 3. What Is Already Testable

| Test | How | Proven |
|---|---|---|
| Login (testuser/testpass) | Browser/curl HTTPS → IMAP auth | ✅ |
| Mailbox render | webmail.php frameset | ✅ |
| Compose form | compose.php loads | ✅ |
| SMTP send | Compose → Send → SMTP capture | ✅ (PR #8) |
| Mailpit capture verification | Internal API query | ✅ |
| Configtest block | External HTTPS → error page | ✅ |
| Special folder creation | Auto-created on login | ✅ |

## 4. What Is Not Yet Testable

| Test | Blocker |
|---|---|
| Read a received message | No messages in INBOX |
| User-to-user send/receive | No delivery harness |
| Reply to received message | No received messages |
| Forward received message | No received messages |
| Delete/move messages | No messages to operate on |
| Search messages | Empty mailbox |
| Attachment download | No messages with attachments |
| Multi-folder navigation with content | Folders exist but are empty |

## 5. Internal User-to-User Delivery Status

**Not implemented.** The SMTP path is:
```
SquirrelMail → Mailpit (capture only)
```

Mailpit is a capture sink. It stores SMTP traffic for inspection but does not deliver to Dovecot maildirs. When `testuser@devbox.local` sends to `devbox@devbox.local`, Mailpit captures the message — Dovecot never sees it. `devbox`'s INBOX remains empty.

## 6. Options Considered

### A. Fixture-Only Baseline
Place pre-authored `.eml` files into Dovecot maildirs via `docker compose cp` or volume mount.

**Pros**: Zero new infrastructure. Deterministic. Ideal for regression.
**Cons**: Cannot test compose/send/receive flow end-to-end.

### B. Local Delivery Harness Only
Add a small DevBox-only delivery service that relays Mailpit-captured messages to Dovecot maildirs.

**Pros**: Enables true user-to-user send/receive/reply testing.
**Cons**: New service adds complexity. Must handle delivery semantics.

### C. Hybrid Fixture + Local Delivery Baseline (Recommended)
Combine A + B:
- Fixtures for deterministic read/regression/attachment tests
- Lightweight local delivery harness for true end-to-end send/receive/reply

**Pros**: Full test coverage. Repeatable. Separation of concerns.
**Cons**: Two mechanisms to maintain.

## 7. Recommended Option

**C — Hybrid fixture + local delivery baseline.**

Rationale in section 8.

## 8. Rationale

1. **Fixture injection** gives deterministic, version-controlled test messages for regression. A small set of seed `.eml` files (plain text, HTML, multipart, with attachment) covers the MIME parsing surface.
2. **Local delivery harness** enables the core mailbox workflow (compose → send → receive → read → reply) without touching SquirrelMail source or adding external services.
3. The harness is DevBox-only. It does not need to be production-grade. It only needs to move messages from Mailpit's storage into the target user's Dovecot maildir.
4. This model supports the Buildline adoption acceptance test matrix without production IMAP/SMTP dependencies.

## 9. Required Future Passes

| Pass | Description |
|---|---|
| Pass 1 — Fixture and reset baseline | Deterministic fixture injection tooling with reset/reseed. Seed known `.eml` messages into Dovecot maildirs. Prove read/regression messages are repeatable. |
| Pass 2 — Local delivery harness | DevBox-only standalone script (not a long-running service, not production mail infrastructure, not publicly exposed). Relay Mailpit-captured messages into target Dovecot maildir. Prove testuser → devbox and devbox → testuser reply. |
| Pass 3 — Full mail acceptance matrix | Execute the full 16-test matrix from section 10. Update smoke/evidence. Declare baseline ready or blocked. |

**Total**: 3 implementation passes after this decision.

## 10. Acceptance Test Matrix

| # | Test | Mechanism | Pre-modernization baseline |
|---|---|---|---|
| T1 | Login | HTTPS → IMAP | ✅ Verified |
| T2 | Mailbox render (empty) | webmail.php | ✅ Verified |
| T3 | Read plain text message | Fixture injection | Pending |
| T4 | Read HTML message | Fixture injection | Pending |
| T5 | Read multipart message | Fixture injection | Pending |
| T6 | Read message with attachment | Fixture injection | Pending |
| T7 | Compose + Send | Delivery harness | SMTP capture only (PR #8) |
| T8 | Receive sent message in INBOX | Delivery harness | Pending |
| T9 | Reply to received message | Hybrid | Pending |
| T10 | Forward received message | Hybrid | Pending |
| T11 | Delete message | Fixture | Pending |
| T12 | Move message to folder | Fixture | Pending |
| T13 | Search by subject | Fixture | Pending |
| T14 | Attachment download | Fixture injection | Pending |
| T15 | Logout | HTTPS | ✅ Verified |
| T16 | Configtest blocked | External HTTPS | ✅ Verified |

## 11. Reset/Reseed Requirements

- `docker compose down -v` destroys all volumes and resets to clean state
- `devbox-setup.sh` creates fresh maildirs on startup
- Fixture seed script must be idempotent (safe to run multiple times)
- Delivery harness must not interfere with fixture-seeded messages

## 12. Risks and Constraints

| Risk | Mitigation |
|---|---|
| Fixture messages become stale after SquirrelMail changes | Version fixtures alongside code |
| Delivery harness adds complexity | Keep it as a standalone DevBox script, not a service |
| Mailpit storage format changes | Pin Mailpit version in docker-compose.yml |
| Dovecot UID validity conflicts | Fixture injection must update dovecot-uidvalidity |
| Special folder namespace mismatch | Already resolved (PR #7) |

## 13. Explicit Non-Goals

- Do not implement production mail delivery (MTA, MDA)
- Do not expose IMAP/SMTP/Mailpit publicly
- Do not connect to external mail servers
- Do not modify SquirrelMail source code
- Do not implement spam/virus filtering
- Do not add persistent queue or retry logic
- Do not implement DKIM/SPF/DMARC

## 14. Buildline Predictability Metrics

| Metric | Target | Current |
|---|---|---|
| Decision pass | PR #9 | ✅ |
| Estimated remaining passes | 3 | |
| Estimated remaining prompts | 6 normal, up to 8 with corrections | |
| Milestone readiness | planned, not implemented | |
| Repeatable login test | < 5s curl | ✅ |
| Repeatable compose/send test | < 30s manual | ✅ (capture only) |
| Repeatable receive test | < 10s | ❌ (no delivery) |
| Full regression matrix | < 5 min | ❌ (16 tests, 4 passing) |
| Fixture seed time | < 10s | ❌ (not implemented) |
| Reset to clean state | < 60s | ✅ (docker compose down -v) |
