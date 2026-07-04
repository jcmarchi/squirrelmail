# Runtime Failure Policy Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/runtime-failure-policy-matrix.md`

| Operation / Job / Consumer | Failure Type | Retry? | Max Attempts | Backoff | Timeout | Terminal State | Alert? | Manual Review? | Notes |
|---|---|---:|---:|---|---|---|---:|---:|---|
| example.external_sync | network timeout | yes | 5 | exponential+jitter | 30s | dead_letter | yes | yes | Do not duplicate external records. |
| example.validation_import | invalid row | no | 0 | n/a | n/a | failed | no | no | Return validation report. |

## Standard Failure Types

- validation_failure
- authorization_failure
- transient_network_failure
- provider_rate_limit
- lock_contention
- data_conflict
- poison_message
- unknown_exception
- timeout
- partial_success
