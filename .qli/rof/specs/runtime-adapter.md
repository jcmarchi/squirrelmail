# Runtime Adapter

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/runtime-adapter.md`  
**Purpose:** Map the universal Runtime / Operations Foundation to this repository's actual runtime implementation.

## Runtime Profile

| Field | Decision |
|---|---|
| Primary profile | shared-hosting / open-source / VPS-self-hosted / on-prem / scalable-SaaS / cloud-native / hybrid |
| Core application stack | |
| Forbidden core technologies | Node.js and Laravel are not allowed as core application technologies unless explicitly approved. Tooling or non-core modules may be used when documented. |
| Runtime portability requirement | |

## Execution Modes

| Mode | Supported? | Implementation | Notes |
|---|---:|---|---|
| Web request | yes/no | | |
| API request | yes/no | | |
| CLI command | yes/no | | |
| Scheduled job | yes/no | | |
| Background job | yes/no | | |
| Event consumer | yes/no | | |
| Webhook processor | yes/no | | |
| Worker daemon | yes/no | | |
| Batch/import/export | yes/no | | |

## Runtime Infrastructure

| Concern | Adapter / implementation | Fallback | Notes |
|---|---|---|---|
| Queue | | | |
| Scheduler | | | |
| Worker process | | | |
| Lock provider | | | |
| Cache | | | |
| Session store | | | |
| Temporary files | | | |
| Job state store | | | |
| Dead-letter/manual review | | | |
| Observability hooks | | | |

## Default Policies

| Policy | Decision |
|---|---|
| Max synchronous request duration | |
| Default job timeout | |
| Default retry count | |
| Default retry backoff | |
| Default dead-letter behavior | |
| Default lock timeout | |
| Default cache TTL | |
| Default temp-file retention | |

## Local Development Behavior

Describe how jobs, queues, schedules, cache, sessions, and workers run locally.

## Production Behavior

Describe how jobs, queues, schedules, cache, sessions, and workers run in production.

## Known Runtime Constraints

List limitations that AI Coding Agents must respect.
