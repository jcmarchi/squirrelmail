# Access Control Test Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `/docs/access-control-test-matrix.md`  
**Purpose:** Ensure access-control implementation includes both allowed and denied tests.

| Test area | Required case | Status | Test file | Notes |
|---|---|---|---|---|
| Authentication | unauthenticated protected route is denied/redirected | missing | | |
| Permission allow | actor with permission can perform action in scope | missing | | |
| Permission deny | actor without permission cannot perform action | missing | | |
| Scope allow | permission works inside assigned scope | missing | | |
| Scope deny | same permission denied outside assigned scope | missing | | |
| Cross-tenant | guessed ID in another tenant denied | missing | | |
| UI gating | hidden UI action is also denied server-side | missing | | |
| Role assignment | actor cannot assign role above authority | missing | | |
| Platform role | tenant admin cannot assign platform role | missing | | |
| API token | token cannot exceed granted scope | missing | | |
| Impersonation | original actor preserved in audit | missing | | if supported |
| Dev-only | dev route disabled in production | missing | | |
| Audit | privileged success and denial logged | missing | | |
| Field access | sensitive fields redacted when required | missing | | if required |
| File/export | protected file/export requires permission | missing | | |
| Background job | job carries tenant/scope context | missing | | if applicable |

## Test Rules

- Every high-risk permission needs positive and negative tests.
- Every privileged route needs denial tests.
- Every cross-scope resource operation needs containment tests.
- Every access-control refactor must preserve existing valid behavior or document intentional migration.
