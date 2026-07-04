# Observability Trace Map

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Use this document to define where traces/spans or correlation boundaries exist. If the project does not use distributed tracing, still document correlation ID boundaries.

| Flow | Entry Point | Required Correlation | Span/Segment | Downstream Boundary | Async Link? | Notes |
|---|---|---|---|---|---|---|
| User action -> API -> Use Case -> DB | HTTP request | request_id, correlation_id | API handler, use case, repository | DB adapter | no | |
| API -> Queue -> Worker | HTTP request | correlation_id propagated to message | publish, consume, use case | queue broker | yes | |
| Webhook -> Event -> Job | webhook endpoint | external_event_id + correlation_id | webhook validation, event publish, job run | queue/event broker | yes | |
