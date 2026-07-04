# Testing Smoke Checklist — [Project Name]

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Purpose:** Define fast checks that prove the application is usable after each meaningful change.

## Local Smoke

- [ ] Dependencies install or are already available.
- [ ] Environment/config sample is valid.
- [ ] Application boots without fatal error.
- [ ] Database/schema migration or initialization works if applicable.
- [ ] Seed/demo data loads if applicable.
- [ ] Home/dashboard or primary screen opens.
- [ ] Login/logout works if authentication exists.
- [ ] One critical create/read/update flow works.
- [ ] One API endpoint or contract check passes if API exists.
- [ ] One background job/schedule/event path works if runtime exists.
- [ ] No obvious console/server errors appear during smoke.

## Human Architect Smoke Path

| Step | Action | Expected Result | Notes |
|---|---|---|---|
| 1 | | | |
| 2 | | | |
| 3 | | | |

## Release/Delivery Smoke

- [ ] Full test command executed or documented as not available.
- [ ] Manual smoke path executed or explicitly deferred.
- [ ] Known defects and deferred risks recorded.
