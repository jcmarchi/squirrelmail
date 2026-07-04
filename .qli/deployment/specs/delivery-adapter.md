# Delivery Adapter

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/delivery-adapter.md`  
**Purpose:** Map the universal Delivery / DevOps / Deployment Foundation to this repository's actual stack, tooling, environment, and deployment process.

---

## 1. Repository Delivery Summary

| Field | Value |
|---|---|
| Application Stack | [PHP/Python/Go/etc.] |
| UI Build Stack | [none/Tailwind/Vite/etc.] |
| Database | [MySQL/PostgreSQL/SQLite/etc.] |
| Runtime Mode | [request-only/cron/workers/queues/etc.] |
| Primary Deployment Target | [shared hosting/VPS/Docker/Kubernetes/etc.] |
| Current Delivery Maturity | 0 / 1 / 2 / 3 / 4 / 5 |

---

## 2. Important Paths

| Path | Purpose |
|---|---|
| `.qli/project-operating-profile.md` | Operating profile |
| `.qli/delivery-foundation-reference.md` | Universal delivery doctrine |
| `.qli/delivery-adapter.md` | This project adapter |
| `README.md` | General project overview |
| `SETUP.md` | Local setup |
| `.env.example` | Environment variable template |
| `scripts/` | Developer and deployment scripts |
| `database/` | Migrations/seeds/schema helpers |
| `public/` | Web root or static public assets |
| `runtime/` | Runtime temp/cache/log/session roots if applicable |
| `storage/` | Persistent local storage roots/adapters |

---

## 3. Setup Commands

```bash
# install dependencies
[command]

# create config
cp .env.example .env

# run migrations
[command]

# seed demo data
[command]

# start local server
[command]

# run tests
[command]
```

---

## 4. Build Commands

| Command | Purpose | Required Environment |
|---|---|---|
| `[command]` | [description] | local/ci/staging/prod |

---

## 5. Deployment Commands / Steps

| Target | Steps |
|---|---|
| Local | [steps] |
| Demo | [steps] |
| Staging | [steps] |
| Production | [steps] |

---

## 6. Runtime Process Map

| Process | Command/Entry Point | Environment | Notes |
|---|---|---|---|
| Web request | [entrypoint] | all | |
| Cron | [entrypoint] | if applicable | |
| Worker | [entrypoint] | if applicable | |
| Queue consumer | [entrypoint] | if applicable | |
| Scheduler | [entrypoint] | if applicable | |

---

## 7. Delivery Constraints

- [ ] Preserve shared-hosting compatibility.
- [ ] Preserve no-build or low-build deployment.
- [ ] Preserve open-source distributability.
- [ ] Preserve self-hosting compatibility.
- [ ] Preserve Docker compatibility.
- [ ] Preserve Kubernetes compatibility.
- [ ] Other: [describe]

---

## 8. Known Delivery Risks

| Risk | Impact | Mitigation | Owner | Status |
|---|---|---|---|---|
| [risk] | [impact] | [mitigation] | [owner] | open |
