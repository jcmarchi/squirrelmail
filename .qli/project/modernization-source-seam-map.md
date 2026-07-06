# Modernization Source Seam Map — SquirrelMail DevBox

## 1. Objective

Map the legacy source seams for the verified core mail flow so the first modernization slice can be scoped without contaminating behavior. This is a read-only discovery artifact. No code is changed.

## 2. Baseline Evidence Used

- PR #3: Adoption intake, behavior snapshot, risk map
- PR #8: SMTP capture functional smoke
- PR #10: Fixture/reset baseline
- PR #11: Local delivery harness (bidirectional)
- PR #12: Full acceptance matrix (10/16 PASS)
- Verified core flow: login → mailbox render → read → compose → send → deliver → receive → reply

## 3. Verified Core Flow

```
T1  Login           → HTTPS → src/login.php → redirect.php → IMAP auth
T2  Mailbox render  → src/webmail.php (frameset)
T3  Read fixture    → src/read_body.php → MIME decode → template render
T7  Compose         → src/compose.php
T7  Send            → SMTP (Mailpit capture)
T8  Receive         → deliver-mailpit-to-maildir.sh → Dovecot INBOX
T9  Reply           → src/compose.php → SMTP → deliver → Dovecot → read
T16 Configtest      → src/configtest.php (blocked externally)
```

## 4. Legacy Entry Points

| Entry Point | File | Role |
|---|---|---|
| Root redirect | `index.php` | Redirects to `src/login.php` |
| Login page | `src/login.php` | Login form, IMAP capability check |
| Login POST | `src/redirect.php` | IMAP auth, session setup, password encryption |
| Main interface | `src/webmail.php` | Frameset layout (left/right frames) |
| Message list | `src/right_main.php` | INBOX message list with controls |
| Message read | `src/read_body.php` | Single message body display |
| Compose | `src/compose.php` | Message composition form |
| Compose send | `src/compose.php` (POST) | SMTP delivery |
| Reply | `src/compose.php?action=reply` | Reply form with quoted text |
| Sign out | `src/signout.php` | Session cleanup |
| Config test | `src/configtest.php` | Configuration diagnostics |

## 5. Source Seam Map

### 5.1 Login / Authentication Flow

| Seam | File | Function/Area | Risk |
|---|---|---|---|
| Bootstrap | `include/init.php` | SM_PATH, session, config loading | Critical |
| Constants | `include/constants.php` | SM_VERSION, pref constants | Low |
| Config | `config/config_default.php` | All defaults (~700 lines) | Critical |
| DevBox config | `docker/devbox.config.php` | Overrides for DevBox | Critical |
| Login form | `src/login.php` | HTML form, IMAP check | Medium |
| Auth flow | `src/redirect.php` | IMAP login, session regen | Critical |
| Auth check | `functions/auth.php` | `sqauth_is_logged_in()` | Critical |
| Password | `functions/auth.php` | `sqauth_read_password()` | Critical |
| Session | `functions/global.php` | `sqsession_*()` functions | Critical |
| Input | `functions/global.php` | `sqgetGlobalVar()` | Medium |
| Language | `functions/i18n.php` | `set_up_language()` | Low |

### 5.2 IMAP Access Layer

| Seam | File | Function/Area | Risk |
|---|---|---|---|
| IMAP connect | `functions/imap_general.php` | `sqimap_login()` | Critical |
| IMAP commands | `functions/imap_general.php` | `sqimap_run_command()` | Critical |
| IMAP stream | `functions/imap_general.php` | `sqimap_create_stream()` | Critical |
| IMAP messages | `functions/imap_messages.php` | Message fetching | High |
| IMAP folders | `functions/imap_mailbox.php` | Folder operations | High |
| IMAP search | `functions/imap_asearch.php` | Search operations | Medium |
| IMAP UTF-7 | `functions/imap_utf7_local.php` | Folder name encoding | Low |

### 5.3 Mailbox / Message List Flow

| Seam | File | Function/Area | Risk |
|---|---|---|---|
| Frameset | `src/webmail.php` | Left + right frame layout | Medium |
| Message list | `src/right_main.php` | INBOX listing, sort controls | High |
| Mailbox display | `functions/mailbox_display.php` | Message list generation | High |
| Folder list | `src/left_main.php` | Folder tree | Medium |
| Folder ops | `functions/folder_manip.php` | Create/rename/delete folders | Medium |
| Tree | `functions/tree.php` | Folder tree rendering | Low |

### 5.4 Message Read Flow

| Seam | File | Function/Area | Risk |
|---|---|---|---|
| Message read | `src/read_body.php` | Message display entry | High |
| Text view | `src/view_text.php` | Plain text rendering | Medium |
| HTML view | `src/view_html.php` | HTML iframe rendering | Medium |
| MIME parse | `class/mime.class.php` | MIME structure (~3100 lines) | Critical |
| MIME helpers | `functions/mime.php` | MIME type handling | High |
| Attachment | `functions/attachment_common.php` | Attachment type registry | Medium |
| Display | `functions/display_messages.php` | Error/info message display | Low |

### 5.5 Compose / Send Flow

| Seam | File | Function/Area | Risk |
|---|---|---|---|
| Compose form | `src/compose.php` | Message composition UI | High |
| Send action | `src/compose.php` (POST) | Message sending | Critical |
| Compose logic | `functions/compose.php` | Sendmail/SMTP delivery | Critical |
| SMTP connect | `functions/compose.php` | SMTP socket connection | Critical |
| Identity | `functions/identity.php` | From address management | Medium |
| RFC822 | `functions/rfc822address.php` | Address parsing | Medium |

### 5.6 Preferences / Config Dependencies

| Seam | File | Function/Area | Risk |
|---|---|---|---|
| Config defaults | `config/config_default.php` | All global config variables | Critical |
| DevBox config | `docker/devbox.config.php` | DevBox overrides | Critical |
| Pref storage | `functions/prefs.php` | `getHashedFile()`, `getHashedDir()` | High |
| Default prefs | `config/default_pref` | Default user preferences | Low |
| Prefs UI | `src/options.php` | User preferences page | Low |
| DB prefs | `functions/db_prefs.php` | Database preference backend | Low |

### 5.7 Template / UI Rendering

| Seam | File | Function/Area | Risk |
|---|---|---|---|
| Template class | `class/template/Template.class.php` | Abstract template API | Medium |
| Template util | `functions/template/general_util.php` | Template helpers | Low |
| Page header | `functions/page_header.php` | HTML header generation | Medium |
| HTML helpers | `functions/html.php` | HTML tag generation | Medium |
| Forms | `functions/forms.php` | Form element generation | Low |
| Strings | `functions/strings.php` | `get_location()`, encoding | Medium |
| Themes | `themes/*.php` | Color arrays, CSS | Low |

### 5.8 Plugin / Hook System

| Seam | File | Function/Area | Risk |
|---|---|---|---|
| Hook registry | `config/plugin_hooks.php` | Plugin hook registration | Medium |
| Hook execution | `functions/plugin.php` | `do_hook()`, `use_plugin()` | Medium |
| 18 plugins | `plugins/*/setup.php` | Individual plugin init | Low |

### 5.9 Localization

| Seam | File | Function/Area | Risk |
|---|---|---|---|
| i18n init | `functions/i18n.php` | `set_up_language()`, `_()` | Low |
| L10n class | `class/l10n.class.php` | Locale handling | Low |
| Gettext | `functions/gettext.php` | GNU gettext wrapper | Low |
| Locales | `locale/` | Translation files | Low |

## 6. Core Dependency Map

```
index.php
  └─ include/init.php
       ├─ include/constants.php
       ├─ functions/global.php       (session, input)
       ├─ config/config_default.php  (all defaults)
       ├─ config/config.php          (DevBox overrides)
       └─ config/config_local.php    (local overrides)

src/login.php
  ├─ include/init.php
  ├─ functions/imap_general.php
  └─ functions/forms.php

src/redirect.php
  ├─ include/init.php
  └─ functions/imap_general.php     (sqimap_login)

src/right_main.php
  ├─ functions/mailbox_display.php
  ├─ functions/imap_messages.php
  └─ functions/imap_mailbox.php

src/read_body.php
  ├─ class/mime.class.php           (MIME structure parse)
  └─ functions/mime.php

src/compose.php
  ├─ functions/compose.php          (SMTP send)
  ├─ functions/identity.php
  └─ functions/attachment_common.php
```

## 7. High-Risk Behavior Boundaries

| Boundary | Why Critical | Preservation Strategy |
|---|---|---|
| `sqimap_login()` in `imap_general.php` | Custom IMAP auth, no PHP extension | Freeze, wrap behind adapter |
| `get_location()` in `strings.php` | URL generation, relies on `$config_location_base` | Already handled (PR #7) |
| `do_hook()` in `plugin.php` | Plugin hook dispatch, 18 plugins depend on it | Preserve API surface |
| `sqimap_run_command()` in `imap_general.php` | Raw IMAP command/response | Freeze, do not refactor |
| MIME parsing in `class/mime.class.php` | ~3100 lines, 20 years of edge cases | Freeze, add characterization tests |
| Password handling in `auth.php` | One-time pad encryption, cookie storage | Document completely before changes |
| `getHashedFile()` in `prefs.php` | File-based preference storage with hash dirs | Introduce abstraction before migration |
| `$config_location_base` | Canonical URL, set in DevBox config | Already correct |
| Global config variables | Hundreds of globals from `config_default.php` | Introduce config container gradually |

## 8. Files Safe to Observe Only

These files should be read but not modified in early modernization:

- `class/mime.class.php` — frozen MIME parser
- `functions/imap_general.php` — frozen IMAP client
- `functions/imap_messages.php` — frozen IMAP message ops
- `functions/imap_mailbox.php` — frozen IMAP folder ops
- `functions/auth.php` — frozen auth/password handling
- `functions/plugin.php` — frozen hook system
- `config/config_default.php` — frozen defaults (overridden by DevBox config)

## 9. Files Likely Involved in First Modernization Slice

| File | Modernization Target | Approach |
|---|---|---|
| `src/login.php` | Login page presentation | Extract HTML structure from PHP logic |

## 10. Files Explicitly Excluded from First Modernization Slice

| File | Reason |
|---|---|
| `include/init.php` | Bootstrap — deferred (config container, session setup) |
| `src/redirect.php` | Auth flow — deferred (critical IMAP login path) |
| `src/right_main.php` | Message list — deferred (data/presentation separation) |
| `src/compose.php` | Compose/send — deferred |
| `functions/mailbox_display.php` | Mailbox display — deferred |
| `functions/page_header.php` | HTML header — deferred |
| `functions/html.php` | HTML helpers — deferred |
| `functions/global.php` | Session/input — deferred |
| `class/mime.class.php` | Critical MIME parser — frozen |
| `functions/imap_general.php` | Critical IMAP client — frozen |
| `functions/compose.php` | SMTP send logic — frozen |
| `functions/imap_*.php` | IMAP protocol layer — frozen |
| `functions/auth.php` | Password handling — frozen |
| `functions/plugin.php` | Hook system — frozen |
| `functions/prefs.php` | File-based preferences — frozen |
| `config/config_default.php` | Frozen defaults |
| `plugins/**` | All 18 plugins excluded |
| `themes/**` | Theme files excluded |
| `locale/**` | Translation files excluded |

## 11. Recommended First Modernization Slice

**Title**: Login Page Presentation Seam Extraction

**Scope**:
- Observe `src/login.php` only.
- Extract or isolate only login-page presentation structure in the smallest safe way that preserves all behavior.
- Preserve: form field names (`login_username`, `secretkey`), POST target (`src/redirect.php`), JavaScript onload focus logic, language detection, theme loading, hook calls (`do_hook('login_cookie')`, etc.), IMAP LOGINDISABLED check, error box display, template footer output, localization (`set_up_language()`, `_()` calls), CSRF/session cookie behavior.
- Do not change authentication behavior.
- Do not change `src/redirect.php`.
- Do not change IMAP login.
- Do not change session handling.
- Do not change password handling.
- Do not change mailbox rendering.
- Do not change compose/send.
- Do not change config loading.
- Do not introduce a config container.
- Do not introduce new dependencies.

**Why this slice**:
- It is a visible, user-facing page.
- It is small — changes are contained to one file's presentation structure.
- It is testable with a single acceptance test: T1 Login.
- It creates the first modernization seam (UI/presentation separation) without touching IMAP, authentication, session, or core mail behavior.
- It proves the Buildline modernization model on the smallest safe surface.

## 12. Acceptance Criteria for First Modernization Slice

1. T1 Login: must pass (login page renders, form works, redirect behaves identically)
2. T2 Mailbox render: must still pass after login
3. T3-T6 fixture reads: should still pass if login enters mailbox normally
4. T7-T9: should remain pass if core flow is smoke-checked
5. T16 Configtest blocked: must remain pass
6. No new dependencies introduced
7. No behavior change in excluded files
8. DevBox runtime starts and smoke-checks pass
9. Do not use T10-T15 as acceptance criteria (blocked by browser automation per PR #12)

## 13. Validation Path Using Existing Baseline

```bash
docker compose up -d
./docker/tools/reset-mail-fixtures.sh
./docker/tools/seed-mail-fixtures.sh

# Pre-slice: verify T1-T6, T16 pass
# Post-slice: verify identical behavior

# T1: Login page renders and form submits correctly
# T2: Mailbox renders after login
# T3-T6: Fixture messages readable
# T16: Configtest blocked externally
```

## 14. Deferrals

| Deferral | Reason |
|---|---|
| Config container extraction | Deferred. Keep `include/init.php` as-is for first slice. |
| Auth interface extraction | Deferred. `src/redirect.php` and `auth.php` frozen. |
| Message list separation | Deferred. `src/right_main.php` and `mailbox_display.php` frozen. |
| Header/footer centralization | Deferred. `functions/page_header.php` frozen. |
| HTML helper replacement | Deferred. `functions/html.php` frozen. |
| Session/input wrapper | Deferred. `functions/global.php` frozen. |
| IMAP client refactoring | Deferred. Critical protocol layer, frozen. |
| MIME parser refactoring | Deferred. ~3100 lines with 20 years of edge case handling. |
| Filesystem pref migration | Deferred. Requires abstraction layer and data migration tooling. |
| UI modernization (frameset → responsive) | Deferred. Separate pass, requires full UI redesign. |
| Plugin API changes | Deferred. 18 plugins depend on current hook signatures. |
| SMTP layer refactoring | Deferred. Depends on IMAP auth flow for password reuse. |
| Theme system overhaul | Deferred. Separate UI pass. |
| i18n system replacement | Deferred. Current gettext wrappers are functional. |
| Database backend migration | Deferred. Zero-production-change, separate pass. |
