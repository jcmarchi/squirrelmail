# Observability Adapter — [Project Name]

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Purpose:** Map the universal Observability / Audit / Telemetry Foundation to this repository's actual stack, deployment profile, and tooling.

## Project Profile

| Field | Value |
|---|---|
| Application type | [SaaS / internal / open-source / shared-hosted / self-hosted / hybrid] |
| Runtime profile | [web / API / CLI / workers / queues / schedules / events] |
| Hosting profile | [shared hosting / VPS / on-prem / cloud / scalable SaaS / local-only] |
| Core language/framework | [e.g., PHP, Python, Go, Java, C#, etc.] |
| Logging mechanism | [file / database / syslog / JSON stdout / service / other] |
| Audit storage | [database table / append-only file / external system / none yet] |
| Metrics mechanism | [none / local counters / Prometheus-compatible / vendor / custom] |
| Tracing mechanism | [none / correlation IDs only / OpenTelemetry-compatible / vendor / custom] |
| Error reporting | [logs / email / issue tracker / service / other] |
| Dashboard location | [route / admin panel / external / none] |

## Context Propagation

| Context | Strategy |
|---|---|
| request_id | [How generated and returned] |
| correlation_id | [How accepted, generated, propagated] |
| trace_id/span_id | [If applicable] |
| actor context | [How attached safely] |
| tenant/scope context | [How attached safely] |
| job/event context | [How propagated across queues/events] |

## Sensitive Data Rules

| Data class | Logging policy | Redaction/masking approach |
|---|---|---|
| Secrets/tokens | Never log | Omit/redact at source |
| Personal identifiers | [Policy] | [Mask/hash/omit] |
| Financial/regulated data | [Policy] | [Mask/omit] |
| Request bodies | [Policy] | [Allowlist only] |
| Uploaded files | Never log raw content | Metadata only |

## Retention

| Signal type | Retention | Storage |
|---|---|---|
| Application logs | [duration] | [location] |
| Audit events | [duration] | [location] |
| Metrics | [duration] | [location] |
| Traces | [duration] | [location] |
| Error events | [duration] | [location] |

## Operational Surfaces

| Surface | Route/location | Access classification | Notes |
|---|---|---|---|
| Health | | | |
| Status | | | |
| Diagnostics | | | |
| Audit viewer | | | |
| Logs viewer | | | |
| Dashboard | | | |

## Deferred Decisions

| Decision | Risk | Owner | Target date |
|---|---|---|---|
| | | | |
