# Observability Privacy and Safety Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Use this matrix to define what must never be logged, what may be redacted, and what is safe for telemetry.

| Data Class | Examples | Log Policy | Audit Policy | Metric Policy | Trace Policy | Test Required | Notes |
|---|---|---|---|---|---|---|---|
| Secrets/tokens | passwords, API keys, OAuth tokens | never log | reference only, no value | never label | never attribute | yes | |
| PII | email, phone, address | mask/hash/omit | allowed only when necessary | no raw labels | avoid raw values | yes | |
| Tenant data | customer records, private content | omit raw content | resource refs only | aggregated labels only | metadata only | yes | |
| Financial/regulated data | payments, health, legal docs | omit/redact | policy-controlled | no raw labels | metadata only | yes | |
