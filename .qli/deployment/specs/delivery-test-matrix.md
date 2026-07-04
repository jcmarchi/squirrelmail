# Delivery Test Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/delivery-test-matrix.md`

| Test Area | Required For | Test / Check | Command or Path | Status | Notes |
|---|---|---|---|---|---|
| Local setup | all projects | fresh setup succeeds | [command] | pending | |
| Config validation | all projects | missing required config fails safely | [command/test] | pending | |
| Build/package | build-based projects | build completes from clean checkout | [command] | pending | |
| Migrations | data changes | migrations apply cleanly | [command] | pending | |
| Rollback/forward fix | risky releases | plan exists and is tested if possible | [manual/test] | pending | |
| Smoke test | all deployments | homepage/login/API/demo route works | [path] | pending | |
| Worker/cron | runtime tasks | jobs can run in target environment | [command] | pending | |
| Backup/restore | production | restore process tested | [manual/test] | pending | |
| Dev route blocking | production | dev tools disabled | [test] | pending | |
