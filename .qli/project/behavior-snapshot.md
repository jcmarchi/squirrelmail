# SquirrelMail QLi — Behavior Snapshot

## Purpose

This document captures the observable runtime behavior of SquirrelMail as it exists today. It describes what the application does, not how it is internally structured. This snapshot is the baseline against which any modernization changes must be validated.

## Core User Flows

### 1. Login Flow
1. User navigates to `/` → redirected to `src/login.php`
2. Login form: username + password fields
3. JavaScript auto-focuses the password field (or username if not pre-filled)
4. On submit: `src/redirect.php` processes credentials
5. IMAP authentication via `sqimap_login()` against configured IMAP server
6. Password encrypted with one-time pad, stored in cookie (`key`)
7. Session regenerated (`session_regenerate_id()`)
8. `user_is_logged_in` flag set in session
9. Redirect to `src/webmail.php` (main interface)
10. If IMAP LOGINDISABLED detected, shows warning suggesting CRAM-MD5/DIGEST-MD5 or TLS

### 2. Mailbox View
- Frameset layout (traditional SquirrelMail UI)
- Left frame: folder list (collapsible tree)
- Right frame: message list or message view
- Folder operations: create, rename, delete, subscribe, unsubscribe
- Message list: sortable columns (date, subject, from, size)
- Pagination controls
- Unread message counts per folder

### 3. Message Reading
- Plain text view (`src/view_text.php`)
- HTML view with iframe sandbox (`src/view_html.php`)
- MIME structure parsed by `class/mime.class.php`
- Attachments listed with download links
- Inline images displayed when supported
- Character set conversion for international messages
- Quoted text colorization (1-level and 2+-level)

### 4. Message Composition
- `src/compose.php` — composition form
- To/CC/BCC/Subject/Body fields
- Attachments: file upload to `$attachment_dir`
- Address book integration for recipient selection
- Draft saving to IMAP Drafts folder
- Reply/Forward: quoted original message
- Send: SMTP or sendmail delivery
- Sent message saved to IMAP Sent folder (configurable)

### 5. Message Sending
- SMTP mode: direct socket connection to `$smtpServerAddress:$smtpPort`
- Sendmail mode: pipes to `$sendmail_path`
- SMTP AUTH: LOGIN, PLAIN, CRAM-MD5, DIGEST-MD5, SCRAM-*
- TLS support: ssmtp and STARTTLS
- POP-before-SMTP supported
- Message priority flags (configurable)
- SquirrelMail X-Squirrel-* headers (encrypted with `$encode_header_key`)
- Delivery receipts (MDN) support

### 6. Preferences
- Personal preferences page (`src/options.php`)
- Categories: Personal, Display, Message Highlighting, Folder Preferences, Index Order
- Stored per-user in `$data_dir/<hashed>/<username>.pref`
- Default preferences from `config/default_pref`
- Identity management: display name, email address, reply-to
- Signature support

### 7. Address Book
- Personal address book per user
- Global shared address book (optional)
- Backends: local file, database, LDAP
- Import/export support
- Search within address books
- Integration with compose form

### 8. Session Management
- PHP native sessions with custom name (`$session_name`, default `SQMSESSID`)
- HttpOnly cookies
- SameSite=Strict where supported
- Session expiration detection
- POST data preservation on session expiry
- Logout: `src/signout.php`, clears session

### 9. Search
- Basic search: subject, from, body
- Advanced search: multiple criteria, date ranges
- IMAP SEARCH CHARSET support (configurable)
- Server-side threading (THREAD extension)
- Server-side sorting (SORT extension)

### 10. Diagnostics
- `src/configtest.php` — comprehensive configuration validation
- Checks: PHP version, extensions, paths, permissions, SMTP, IMAP
- Remote access blocked by default
- Verbose error display for debugging

## Non-Functional Behaviors

### Performance Characteristics
- Stateless request-response model (no persistent daemon)
- File-based preferences: synchronous I/O per request
- IMAP connections: one per page request (not persistent across requests)
- No opcode caching required but beneficial
- Session locking: PHP default (blocking)

### Error Handling
- `class/error.class.php` for structured error handling
- `error_box()` function for user-facing errors
- `$sm_debug_mode` controls error reporting level
- `@` suppression used in legacy code
- `sqimap_run_command()` returns false on IMAP errors

### Security Posture
- Password: one-time pad encrypted in cookie, never plain on disk
- Session: PHP sessions, HttpOnly, SameSite, regeneration on login
- XSS: CSP frame-ancestors, htmlspecialchars
- CSRF: optional referrer checking
- File uploads: hashed attachment dir, atomic file creation
- Config: sensitive values in config.php (file permissions important)

### Browser Compatibility
- HTML 4.01 Transitional
- JavaScript optional (graceful degradation)
- Frameset-based layout (legacy)
- CSS themes for visual customization
- RTL language support

## Plugin Behaviors (Bundled)

| Plugin | Behavior |
|---|---|
| administrator | Server administration interface |
| bug_report | Bug report submission form |
| calendar | Personal calendar with reminders |
| change_password | Password change for IMAP accounts |
| demo | Demo mode restrictions |
| filters | Server-side message filtering |
| fortune | Random fortune at top of page |
| info | PHP/server information display |
| listcommands | Mailing list command detection |
| mail_fetch | Fetch mail from external POP3/IMAP |
| message_details | Detailed message header view |
| newmail | New mail notification (sound/popup) |
| preview_pane | Three-pane preview layout |
| sent_subfolders | Monthly sent-mail subfolders |
| spamcop | SpamCop reporting integration |
| squirrelspell | Spell-checking (personal dictionaries) |
| test | Plugin development test harness |
| translate | Translation helper tool |

## DevBox Runtime Behaviors

| Behavior | DevBox Implementation |
|---|---|
| Web server | PHP 8.3 Apache, 127.0.0.1:20110 |
| IMAP | Dovecot 2.3.21, internal:143, plain auth |
| SMTP | Mailpit capture, internal:1025, no auth |
| Data storage | Docker volumes, /var/local/squirrelmail/ |
| Config | docker/devbox.config.php mounted as config.php |
| Test users | testuser/testpass, devbox/devbox |
| Plugins | Disabled by default in DevBox config |
