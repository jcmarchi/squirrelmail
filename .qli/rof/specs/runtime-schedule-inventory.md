# Runtime Schedule Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/runtime-schedule-inventory.md`

| Schedule Key | Purpose | Domain Module | Schedule | Timezone | Overlap Policy | Lock Key | Max Duration | Retry/Failure Behavior | Environment | Owner | Status |
|---|---|---|---|---|---|---|---:|---|---|---|---|
| example.cleanup_temp_files | Remove expired temp files | system | daily 02:00 | UTC | skip_if_running | cleanup_temp_files | 15m | log + alert after 3 failures | prod/staging/dev | core.system | planned |

## Rules

- Every cron/scheduled task must be documented here.
- Critical tasks need lock/overlap control.
- Destructive tasks should support dry-run where practical.
