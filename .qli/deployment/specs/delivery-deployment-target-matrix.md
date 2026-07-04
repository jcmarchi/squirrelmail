# Delivery Deployment Target Matrix

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/delivery-deployment-target-matrix.md`

| Target | Supported Now? | Target Phase | Requirements | Constraints | Required Docs/Scripts | Notes |
|---|---|---|---|---|---|---|
| Shared Hosting | yes/no | MVP | PHP/static compatible, no root, cron optional | no daemons, limited env control | SETUP, upload/deploy steps | |
| VPS / Dedicated | yes/no | [phase] | SSH, reverse proxy, system services | operator skill required | service scripts, backup docs | |
| Docker Host | yes/no | [phase] | Dockerfile, compose, volumes, env | image build/rebuild | Dockerfile/compose | |
| Kubernetes | yes/no | [phase] | manifests/helm, probes, secrets | cluster ops | deployment manifests | |
| PaaS | yes/no | [phase] | platform config, env vars | platform limits | release command docs | |
| Static/Hybrid | yes/no | [phase] | static build, CDN | API separation | build docs | |
| Air-gapped/On-prem | yes/no | [phase] | offline dependencies, installer | no external calls | operator guide | |
