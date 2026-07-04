# Runtime Test Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/runtime-test-matrix.md`

| Test Area | Required? | Test / File | Positive Cases | Negative / Failure Cases | Status |
|---|---:|---|---|---|---|
| Job executes use case | yes | | job calls correct Core use case | invalid payload fails | planned |
| Idempotency | yes when retries/events exist | | duplicate ignored safely | duplicate does not duplicate side effects | planned |
| Retry policy | yes when retryable | | transient failure retries | permanent failure does not retry | planned |
| Dead-letter/manual review | yes when background work exists | | terminal failure recorded | invisible failure impossible | planned |
| Scheduler overlap | if scheduled | | normal run succeeds | overlapping run skipped/blocked | planned |
| Locking/concurrency | if shared mutable state | | lock acquired/released | stale lock expires | planned |
| Cache/session safety | if cache/session used | | scoped cache works | stale/unauthorized data not exposed | planned |
| Batch/import/export | if applicable | | progress + completion | partial failure report | planned |
| Outbox/inbox | if applicable | | event delivered | duplicate inbound ignored | planned |
| Audit/observability | if privileged | | log/audit emitted | sensitive data not logged | planned |
