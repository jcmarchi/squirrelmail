# Vertical Slice Protocol

Every Buildline implementation task should be framed as a bounded slice.

## Before implementation

- Read project state and context-loading rules.
- Identify triggered foundations.
- Read only the relevant foundation references and implementation controls.
- Identify affected code/data/UI/API/ACL/security surfaces.
- Select test tier.

## During implementation

- Keep changes bounded.
- Build visible/reviewable behavior when UI applies.
- Keep API/data/ACL/security aligned.
- Update inventories and project state as durable facts change.

## After implementation

- Run targeted tests and smoke checks.
- Fill slice evidence.
- Update `.qli/project/foundation-status.yml`.
- Add/update deferrals.
- Report remaining gaps and next slice.
