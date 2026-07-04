# Security Data Protection Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


| Data Category | Examples | Sensitivity | Storage Controls | Access Controls | Logging Rules | Retention / Deletion | Notes |
|---|---|---|---|---|---|---|---|
| Public content | public pages | public | normal | public/read policy | may log identifiers | normal lifecycle | |
| Account identity | email, username | PII | protected DB | self/admin scoped | redact where possible | privacy policy | |
| Business records | customer/project data | confidential | tenant-aware storage | tenant/scoped ACL | do not log full payload | product lifecycle | |
| Financial/billing | invoices, payment metadata | financial | restricted | billing permissions | never log secrets/full payment data | compliance-driven | |
| Secrets/credentials | tokens, keys | secret | hash/encrypt/secret store | privileged only | never log | rotate/revoke | |
| Audit records | security/admin events | audit | append-only where practical | auditor/admin | log metadata only | retention policy | |
| Uploaded files | attachments/media | varies | storage isolation | download authorization | path/id only | lifecycle policy | |

## Required Rule

If data sensitivity changes, update DATA foundation documents and security inventories together.
