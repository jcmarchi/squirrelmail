# Slice Definition of Done

A Buildline slice is done only when the applicable product path works across the foundations required by `.qli/project/foundation-applicability.yml`.

## Required completion evidence

- The slice has a clear user/business/technical purpose.
- The affected foundations are named.
- The implementation touches the required layers or records valid non-applicability.
- UI is human-reviewable when UI applies.
- API contract/endpoint behavior is stable when API applies.
- Data model/storage/seed behavior is controlled when data applies.
- ACL and security deny paths are tested where applicable.
- Runtime/observability/delivery impacts are handled or deferred with triggers.
- Tests and smoke checks are recorded.
- Foundation status is updated.

## Not done

The slice is not done if:

- It is backend-only while UI/API review is applicable.
- It changes protected behavior without ACL/security evidence.
- It changes data without migration/classification evidence.
- It cannot be reviewed by a human through the intended surface.
- It contains silent deferrals.
- The agent reports tests that were not actually run.
