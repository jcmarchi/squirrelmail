# Delivery Backup and Restore Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/delivery-backup-restore-matrix.md`

| Asset | Backup Required? | Frequency | Retention | Backup Location | Restore Process | Last Restore Test | Owner | Notes |
|---|---|---|---|---|---|---|---|---|
| Database | yes | [daily/etc.] | [period] | [location] | [steps/command] | [date] | [owner] | |
| Uploaded Files | if applicable | [frequency] | [period] | [location] | [steps] | [date] | [owner] | |
| Config | yes | on change | current + previous | repo/env docs | recreate from docs | [date] | [owner] | no secrets in repo |
| Logs/Audit | if required | [frequency] | [period] | [location] | [steps] | [date] | [owner] | |
