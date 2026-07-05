# Local Delivery Harness — SquirrelMail DevBox

## 1. Objective

Pass 2 of 3 after the Mail Testability Baseline decision (PR #9). Create a DevBox-only standalone local delivery harness that relays Mailpit-captured messages into target Dovecot Maildir inboxes. Enables testuser ↔ devbox send/receive/reply testing within the controlled DevBox runtime.

## 2. Runtime Topology

```
testuser compose → SMTP → Mailpit (capture) → deliver-mailpit-to-maildir.sh → Dovecot INBOX/devbox
devbox compose    → SMTP → Mailpit (capture) → deliver-mailpit-to-maildir.sh → Dovecot INBOX/testuser
```

The harness is a manual-on-demand script, not a long-running service. Run after sending messages to deliver them.

## 3. Script Files

| File | Purpose |
|---|---|
| `docker/tools/deliver-mailpit-to-maildir.sh` | Main delivery harness |
| `docker/tools/.local-delivery-state` | Delivery state file (gitignored, generated) |

## 4. Local Recipient Map

| Email | Dovecot User | Maildir |
|---|---|---|
| `testuser@devbox.local` | testuser | `/srv/mail/testuser/` |
| `devbox@devbox.local` | devbox | `/srv/mail/devbox/` |

Non-local recipients are skipped. No external delivery.

## 5. Mailpit Inspection Method

Mailpit internal API (within Docker network, never exposed publicly):

- `GET /api/v1/messages` — list all captured messages (JSON)
- `GET /api/v1/message/{ID}` — get message detail (includes To/From)
- `GET /api/v1/message/{ID}/raw` — get raw RFC822 content for delivery

Used via `wget` inside the smtp container. No external access.

## 6. Delivery Method

1. Query message list from Mailpit API
2. For each message, check if any recipient matches local map
3. Skip non-local recipients
4. Skip already-delivered messages (state file)
5. Download raw RFC822 via `/message/{ID}/raw`
6. Write to Dovecot `new/` for the target user
7. Set `dovecot:dovecot` ownership
8. Record message ID in state file

## 7. Idempotency Model

Delivery state tracked in `docker/tools/.local-delivery-state` (line-separated Mailpit message IDs). Repeated runs skip previously delivered messages. State file is gitignored and regenerated per-DevBox-instance.

## 8. Validation Performed

| Check | Result |
|---|---|
| Mailpit API reachable | ✅ `GET /api/v1/messages` returns JSON |
| Raw message retrieval | ✅ `GET /api/v1/message/{ID}/raw` returns RFC822 |
| testuser → devbox send | ✅ SquirrelMail compose/send succeeds |
| Delivery to devbox INBOX | ✅ Message appears in devbox mailbox |
| devbox → testuser reply | ✅ SquirrelMail compose/send succeeds |
| Delivery to testuser INBOX | ✅ Reply appears in testuser mailbox |
| Idempotent second run | ✅ Skipped all duplicates, 0 delivered |
| Third run (all dup) | ✅ 2 inspected, 2 skipped, 0 delivered |
| Non-local recipient skipped | ✅ Only local recipients delivered |
| Ownership preserved | ✅ dovecot:dovecot |
| Recipient matching | ✅ Proper To: field JSON parsing (not grep) |
| Python3 dependency | ✅ Python 3.12.3 available (DevBox system dependency) |
| No public exposure | ✅ Mailpit API internal only |

## 9. Risks and Limitations

- Delivery is manual/on-demand, not automatic
- State file is local to DevBox instance, not versioned
- If Mailpit is restarted with `docker compose down`, state may need reset
- Does not handle CC/BCC multi-recipient delivery (first local match wins)
- Reply validation: testable but not yet browser-validated in this pass

## 10. Tests Now Enabled

| Test | Status |
|---|---|
| T7 Compose + Send | ✅ (was SMTP capture only, now full delivery) |
| T8 Receive sent message in INBOX | ✅ (delivery harness places in INBOX) |
| T9 Reply to received message | Testable — pending browser validation |
| T10 Forward received message | Testable — pending browser validation |

## 11. Explicit Non-Goals

- Not a daemon/service (manual script)
- Not production mail infrastructure
- Not automatic delivery
- Not publicly exposed
- Does not delete Mailpit messages
- Does not modify fixture messages
- Does not implement DKIM/SPF/DMARC
- Does not modify SquirrelMail source code

## 12. Next Pass

Pass 3 — Full mail acceptance matrix execution (all 16 tests).
