# Testing / Quality Review Checklist

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


Use this checklist before accepting AI Coding Agent work.

## General

- [ ] The agent read the testing foundation and testing adapter.
- [ ] The change includes appropriate validation for its risk level.
- [ ] Tests were actually run, or the reason they were not run is documented.
- [ ] Manual smoke steps are provided for the human architect.
- [ ] Deferred risks are clearly stated.

## Vertical Slice

- [ ] Core/domain behavior is tested if business rules changed.
- [ ] Data behavior is tested if schemas, repositories, migrations, imports, exports, or lifecycle changed.
- [ ] API/event behavior is tested if contracts, endpoints, webhooks, or events changed.
- [ ] UI behavior is smoke-tested if screens, forms, components, or workflows changed.
- [ ] ACL positive and negative cases are tested if authorization is affected.
- [ ] Runtime behavior is tested if jobs, schedules, queues, locks, cache, or retries changed.

## Refactoring

- [ ] Existing behavior was inspected before refactoring.
- [ ] Characterization tests were added for fragile or poorly understood behavior.
- [ ] Backward compatibility impact is documented.
- [ ] Regression matrix was updated if a defect was fixed.

## Documentation

- [ ] Testing adapter is current.
- [ ] Test inventory is current.
- [ ] Coverage matrix is current.
- [ ] Smoke checklist is current.
- [ ] Defect/regression logs are updated where applicable.
