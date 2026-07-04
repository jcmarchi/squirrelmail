# Case Study A — PHP/MySQL Web Application

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


## Scenario

A project is a conventional PHP application using Composer, a relational database, and a public web root such as `public/`.

The project should run on DEVBOX without changing its product architecture.

## Generic profile

```text
PROJECT_DOMAIN=<PROJECT_DOMAIN>
SLUG=<SLUG>
PUBLIC_HOST=<SLUG>.<DOMAIN>
PORT_BLOCK=<PORT_BLOCK>
APP_PORT=<APP_PORT>
PUBLIC_SERVICE=app
PUBLIC_INTERNAL_PORT=80
DATABASE_SERVICE=mysql
DATABASE_INTERNAL_PORT=3306
HEALTH_PATH=/health
```

## Required adaptations

1. Create a PHP Apache or PHP-FPM runtime wrapper.
2. Configure the web server document root to the project’s public web root.
3. Bind the app service to `127.0.0.1:<APP_PORT>`.
4. Keep the database internal.
5. Use service hostname `mysql` or equivalent for database connection.
6. Keep `.env` out of Git.
7. Run dependency installation inside the container without creating root-owned files.
8. Run health checks.

## Key lesson

Standard internal database ports are acceptable inside Docker. Host-exposed ports must be assigned and explicit.
