# SquirrelMail QLi — Risk Map

## Purpose

This document identifies modernization risks specific to SquirrelMail as an existing legacy PHP codebase. Risks are categorized by severity, likelihood, and mitigation strategy. This map guides the staged adoption plan and must be updated as discovery deepens.

## Risk Severity Scale

- **Critical**: Would break core login/mailbox/compose functionality if mishandled
- **High**: Would break significant user-facing features
- **Medium**: Would degrade experience or break non-critical features
- **Low**: Cosmetic, edge-case, or easily remediated

## Architecture-Level Risks

### R1: Direct IMAP Socket Communication
- **Severity**: Critical
- **Likelihood**: High (any IMAP refactoring impacts this)
- **Description**: SquirrelMail implements its own IMAP client via raw socket communication (`fsockopen`). No PHP IMAP extension used. The IMAP code spans `imap_general.php`, `imap_messages.php`, `imap_mailbox.php`, and `imap.php`. Any change to authentication, connection handling, or protocol parsing risks breaking all mail operations.
- **Mitigation**: Freeze IMAP layer during initial modernization. Wrap behind an adapter before refactoring. Maintain test IMAP server for validation.
- **Preservation Required**: IMAP command/response protocol, auth mechanisms, TLS handling, NAMESPACE support, UID operations.

### R2: One-Time Pad Password Storage
- **Severity**: Critical
- **Likelihood**: Medium
- **Description**: User password is encrypted with a one-time pad stored in the PHP session and transmitted as a cookie. The password must remain recoverable (plain text) because it is re-used for SMTP AUTH during message sending. Any change to session or cookie handling risks breaking authentication.
- **Mitigation**: Document password flow completely before any auth changes. Preserve current behavior.
- **Preservation Required**: Password encryption/decryption in `auth.php`, session key handling in `redirect.php`.

### R3: File-Based Preference Storage
- **Severity**: High
- **Likelihood**: Medium
- **Description**: User preferences stored as serialized PHP files in hashed directories under `$data_dir`. Hash level (0-4) determines directory depth. Migration to database would require data migration tooling and changes to all preference read/write paths.
- **Mitigation**: Keep file-based storage during initial phases. Introduce abstraction layer before changing backend.
- **Preservation Required**: `getHashedFile()`, `getHashedDir()`, preference file format, hash directory structure.

### R4: Frameset-Based UI
- **Severity**: Medium
- **Likelihood**: High (any UI modernization impacts this)
- **Description**: Main interface uses HTML frameset (`src/webmail.php`). Left frame for folders, right frame for messages. Modern browsers still support framesets but they are deprecated. Single-page or AJAX UI would require fundamental restructuring.
- **Mitigation**: Defer UI modernization to later slice. When ready, replace frameset with responsive single-page layout while preserving all mailbox operations.
- **Preservation Required**: Folder tree behavior, message list pagination, frame communication.

### R5: Global Variable Dependency
- **Severity**: High
- **Likelihood**: High (pervasive throughout codebase)
- **Description**: Configuration and state are stored in PHP global variables (`$imapServerAddress`, `$smtpPort`, `$data_dir`, `$color`, `$username`, etc.). Hundreds of globals defined in `config_default.php` and used throughout functions/. Refactoring to dependency injection or configuration objects would touch nearly every file.
- **Mitigation**: Introduce configuration container gradually. Wrap global access behind getter functions before refactoring consumers.
- **Preservation Required**: All config variable names, default values, override precedence.

### R6: Plugin Hook System
- **Severity**: Medium
- **Likelihood**: Medium
- **Description**: 18 bundled plugins use `do_hook()` system. Hook registry is statically defined in `config/plugin_hooks.php`. Changing the hook interface would break all plugins. Plugins may rely on global variables and legacy APIs.
- **Mitigation**: Preserve hook API surface. Audit plugins for active use before any hook changes.
- **Preservation Required**: `do_hook()` signature, `$squirrelmail_plugin_hooks` array structure.

### R7: MIME Parsing Complexity
- **Severity**: Medium
- **Likelihood**: Medium
- **Description**: `class/mime.class.php` is ~3100 lines of complex MIME structure parsing. Handles multipart, nested messages, character set decoding, attachment extraction. Edge cases in malformed messages are handled by accumulated bug fixes over 20+ years.
- **Mitigation**: Freeze MIME class during initial phases. Add characterization tests before any refactoring.
- **Preservation Required**: All MIME structure parsing logic, attachment handling, character set conversion.

### R8: PHP 8.x Compatibility
- **Severity**: Low
- **Likelihood**: Low (already addressed in 1.5.2 fork)
- **Description**: The 1.5.2 fork has been updated for PHP 7.0+ and 8.0 compatibility. Optional parameters corrected, legacy constructs replaced (`each` → `foreach`, `create_function` → closures, `mt_rand` → `random_int`). Remaining risk is undiscovered deprecation warnings.
- **Mitigation**: Run with `E_ALL` in DevBox. Address warnings as discovered.

### R9: Template Engine Abstraction Gap
- **Severity**: Low
- **Likelihood**: Low
- **Description**: `Template` class provides abstraction but much HTML is still generated inline in PHP functions (e.g., `error_box()`, mailbox display). Complete template separation would require significant refactoring.
- **Mitigation**: Expand template coverage incrementally. Start with highest-traffic pages.

### R10: No Automated Tests
- **Severity**: High
- **Likelihood**: Certain (no test suite exists)
- **Description**: No PHPUnit, no integration tests, no behavior tests. All validation is manual via configtest.php and browser testing. Modernization without test coverage is high risk.
- **Mitigation**: Add smoke tests and characterization tests before any behavioral changes. Use DevBox for consistent test environment.
- **Preservation Required**: Manual test paths documented in DEVBOX.md.

## Dependency Risks

### D11: No Package Manager
- **Severity**: Low
- **Likelihood**: Certain
- **Description**: No composer.json, no package.json. All code is custom or bundled. Introducing Composer would add a dependency management layer not present today.
- **Mitigation**: Keep zero-dependency model. If dependencies are needed later, introduce Composer in a controlled slice with operator approval.

### D12: PHP Extension Dependencies
- **Severity**: Low
- **Likelihood**: Low
- **Description**: Core requires only standard PHP extensions (session, mbstring, openssl optional). LDAP extension optional for LDAP address books. No PDO required for core operation.
- **Mitigation**: Document extension requirements. Keep optional.

## DevBox-Specific Risks

### D13: Dovecot Test User Management
- **Severity**: Low
- **Likelihood**: Low
- **Description**: Test users are static in `users.passwd.example`. Adding users requires editing file and restarting container. Not scalable for multi-user testing.
- **Mitigation**: Accept for DevBox. Document in DEVBOX.md.

### D14: Ephemeral Data Volumes
- **Severity**: Low
- **Likelihood**: Medium (operator `docker compose down -v` deletes all data)
- **Description**: Docker volumes are ephemeral. User preferences, mail, and attachments are lost on volume removal.
- **Mitigation**: Document in DEVBOX.md. Operator responsibility.

## Risk Prioritization for Adoption

| Priority | Risk | Action |
|---|---|---|
| 1 | R1: IMAP layer | Freeze, wrap behind adapter |
| 2 | R2: Password handling | Document completely before changes |
| 3 | R3: File preferences | Add abstraction before migration |
| 4 | R10: No tests | Add smoke + characterization tests |
| 5 | R5: Global variables | Introduce config container |
| 6 | R6: Plugin hooks | Audit, preserve API |
| 7 | R4: Frameset UI | Defer to later slice |
| 8 | R7: MIME parsing | Freeze, add tests |
| 9 | R8-R14: Lower risk | Address incrementally |
