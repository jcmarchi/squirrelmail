# QLi Foundation Spine Implementation

The Foundation Spine is the upfront implementation that prevents early technical debt while keeping product development moving.

## What the Spine Is

A minimal but real product-construction skeleton across the applicable foundations:

- UI shell or human-review surface.
- Core/use-case boundary.
- DATA classification and persistence convention.
- API/interface pattern where applicable.
- ACL policy/guard spine where applicable.
- Security baseline from operating profile.
- Testing adapter and smoke path.
- Runtime/delivery start model.
- Observability baseline.

## What the Spine Is Not

- It is not a complete enterprise system.
- It is not a demand to implement SSO, billing, queues, multi-region deployment, advanced audit, or enterprise role management unless the operating profile triggers them.
- It is not documentation-only.
- It is not backend-only scaffolding.

## Spine Definition of Done

The spine is complete when:

1. The project can be started or meaningfully inspected.
2. At least one human-review surface exists when the project is user-facing.
3. The first feature can be implemented without inventing one-off architecture.
4. API/data/ACL/security/testing patterns are ready for real feature work where applicable.
5. Deferrals are explicit and tracked.
6. `.qli/project/foundation-status.yml` has evidence for each applicable foundation.
