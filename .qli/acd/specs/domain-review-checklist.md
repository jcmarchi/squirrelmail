# Domain Review Checklist

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/domain-review-checklist.md`

Use this checklist before accepting Application Core / Domain work.

## Architecture

- [ ] Business logic is in domain/use-case/application-service layer, not scattered across controllers/UI/models/templates.
- [ ] Module boundaries are clear and documented.
- [ ] Dependencies point inward toward the core.
- [ ] Infrastructure dependencies are behind ports/adapters.
- [ ] Data records, DTOs, projections, events, and domain entities are not conflated.

## Feature / Use Case

- [ ] Use case name expresses business intent.
- [ ] Input, output, preconditions, postconditions, errors, and side effects are explicit.
- [ ] Commands and queries are separated where meaningful.
- [ ] Workflow/lifecycle states and transitions are enforced in core.
- [ ] Error/result mapping is structured and adapter-safe.

## Integration

- [ ] Data Foundation decisions are respected.
- [ ] API Foundation contracts are updated if interface behavior changed.
- [ ] UI Foundation includes a reviewable screen/workflow when user-facing.
- [ ] ACL Foundation is applied when the use case is protected or scoped.
- [ ] Domain events align with event/API/data contracts.

## Refactoring

- [ ] Existing behavior was inspected and preserved.
- [ ] Tests exist for behavior before significant extraction where feasible.
- [ ] Migration is incremental and documented.
- [ ] No unrelated rewrite was introduced.

## Documentation

- [ ] Domain adapter updated.
- [ ] Module inventory updated.
- [ ] Use case inventory updated.
- [ ] Workflow inventory updated.
- [ ] Event/rule inventories updated when applicable.
- [ ] Test matrix updated.
- [ ] ADR created for major architectural changes.
