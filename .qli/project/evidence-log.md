# QLi Buildline Evidence Log

Each meaningful implementation pass must add one entry. Evidence must identify product-visible behavior, validation, and foundation status updates.

---

### `2026-07-04` — `adoption-intake-001` — `SquirrelMail QLi Buildline Adoption Intake`

**Objective:**
Perform read-only discovery of the existing SquirrelMail codebase and populate project-specific Buildline adoption files with architecture findings, behavior documentation, and risk assessment.

**Product behavior changed:**
No. Read-only discovery pass. Zero application source files modified.

**Foundation coverage:**

| Foundation | Status | Evidence |
|---|---|---|
| Core/ACD | not_started | Architecture documented in adoption-intake.md |
| UI/UX | deferred | Frameset-based UI. Behavior snapshot created. |
| DATA | not_started | File-based storage model documented. Mapping required. Database migration deferred. |
| API | not_applicable | No API surface. Internal PHP application. |
| ACL | not_started | Access boundaries documented. Mapping required. New ACL implementation deferred. |
| Runtime | partial | DevBox baseline (PR #1). Runtime documented. |
| Testing | not_started | No test suite. Risk mapped (R10). |
| Observability | deferred | Baseline. Deferred until Spine. |
| Delivery | partial | Docker Compose via DevBox. Documented. |
| Security | not_started | Security surfaces documented. Review pending. |

**Validation:**

- Static/read-only checks: git diff confirms zero application file changes
- Focused automated tests: n/a (read-only pass)
- Human smoke path: n/a
- Full regression: n/a
- Tests not run and why: No test suite exists (risk R10)

**Files changed:**

- `.qli/project/adoption-intake.md` — architecture discovery and project identity
- `.qli/project/behavior-snapshot.md` — runtime behavior documentation
- `.qli/project/risk-map.md` — modernization risk assessment (14 risks)
- `.qli/project/foundation-applicability.yml` — refined based on discovery
- `.qli/project/foundation-status.yml` — updated with discovery progress
- `.qli/project/current-slice.yml` — adoption intake slice definition
- `.qli/project/context-packet.yml` — session mode and objective updated
- `.qli/project/evidence-log.md` — this file

**Files inspected (read-only):**

- `index.php`, `include/init.php`, `include/constants.php`
- `functions/global.php`, `functions/auth.php`, `functions/imap_general.php`
- `functions/imap_messages.php`, `functions/imap_mailbox.php`, `functions/imap.php`
- `functions/mime.php`, `functions/compose.php`, `functions/prefs.php`
- `functions/plugin.php`, `functions/addressbook.php`, `functions/attachment_common.php`
- `functions/i18n.php`, `functions/strings.php`, `functions/html.php`
- `class/mime.class.php`, `class/error.class.php`, `class/l10n.class.php`
- `class/template/Template.class.php`
- `src/login.php`, `src/redirect.php`, `src/configtest.php`
- `config/config_default.php`, `config/default_pref`
- `plugins/` directory listing (18 plugins identified)
- `doc/INSTALL`, `doc/ChangeLog`, `doc/COPYING`
- `docker-compose.yml`, `docker/devbox.config.php`, `DEVBOX.md`

**Deferred items:**

- UI/UX modernization (frameset → responsive)
- Data storage migration (file-based → database)
- Application ACL implementation
- Observability instrumentation
- Automated test suite

**Next approved slice:**
`spine-planning` — Foundation Spine planning based on adoption intake and risk map.

---

### `2026-07-04` — `modernization-login-seam-001` — `Login Page Presentation Seam Extraction`

**Objective:**
Extract the inline JavaScript onload construction from `src/login.php` into an isolated function `sqm_login_build_onload_script()`. First modernization slice per source seam map (Section 1: Login Page Presentation).

**Product behavior changed:**
No. Behavior-preserving refactor. Login page renders identical HTML/JS. All CSS and template rendering untouched.

**Foundation coverage:**

| Foundation | Status | Evidence |
|---|---|---|
| Core/ACD | started | First seam extracted. Function isolation proven. |
| UI/UX | deferred | Frameset UI preserved. |
| DATA | not_started | No data changes. |
| API | not_applicable | No API surface. |
| ACL | not_started | No ACL changes. |
| Runtime | partial | DevBox validated. Apache PHP 8.3 passes syntax check. |
| Testing | not_started | Manual browser validation only. |
| Observability | deferred | No changes. |
| Delivery | partial | Unchanged. |
| Security | not_started | No auth/session/password/IMAP changes. |

**Validation:**

- Static/read-only checks: PHP lint clean (`php -l` on src/login.php)
- Focused automated tests: n/a (no test suite)
- Human smoke path:
  - T1 (Login page render): ✅ HTTP 200, login form renders at https://squirrelmail.qlidemo.com/
  - T2 (Login + mailbox): ✅ testuser/testpass authenticates, webmail.php loads, frameset renders
  - T16 (Configtest blocked): ✅ Configtest is blocked externally (`$allow_remote_configtest=false`) and exposes no diagnostics. Returns generic error page only.
- Full regression: n/a
- Tests not run and why: No test suite exists (risk R10)

**Files changed:**

- `src/login.php` — Inline JS extracted to `sqm_login_build_onload_script()` function

**Forbidden files NOT changed:**
- `src/redirect.php`, `src/webmail.php`, `src/right_main.php`, `src/read_body.php`, `src/compose.php` — untouched
- `include/`, `functions/`, `class/`, `plugins/`, `themes/`, `config/`, `docker/` — untouched

**Next approved slice:**
TBD — review source seam map for next lowest-risk extraction.

