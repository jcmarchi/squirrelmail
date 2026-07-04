# Buildline Foundation Gate

The Foundation Gate decides whether a project, spine, or slice satisfies QLi Buildline expectations.

## Required inputs

- `.qli/project/manifest.yml`
- `.qli/project/operating-profile.yml`
- `.qli/project/foundation-target.yml`
- `.qli/project/foundation-applicability.yml`
- `.qli/project/foundation-status.yml`
- `.qli/project/deferral-register.md`
- `.qli/project/current-slice.yml`
- Applicable foundation implementation-control files
- Slice evidence report

## Gate checks

1. The active slice is named and bounded.
2. Applicable foundations were selected by binding rules, not agent improvisation.
3. Required spine items exist or are explicitly deferred/not applicable.
4. Deferrals include reason, risk, activation trigger, review point, and owner.
5. Product behavior is reviewable through UI/API/human smoke path where applicable.
6. Server-side ACL exists for protected actions.
7. Security baseline exists for public/authenticated/sensitive surfaces.
8. Data classification/migration/seed posture exists for stored data.
9. Test tier was selected and results are honestly reported.
10. Foundation status and evidence log were updated.

## Result values

- `pass`: all applicable controls satisfied.
- `pass_with_deferrals`: controls satisfied and valid deferrals recorded.
- `fail`: required controls missing or evidence insufficient.
- `blocked`: work cannot proceed without external decision/input.

A gate may not pass on documentation alone. Applicable product code, tests/smoke paths, and evidence must exist.
