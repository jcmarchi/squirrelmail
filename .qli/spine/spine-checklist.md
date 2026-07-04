# QLi Spine Checklist

Use this checklist during new-project setup and Foundation Spine implementation.

## Project state

- [ ] `.qli/project/manifest.yml` created/updated.
- [ ] `.qli/project/operating-profile.yml` created/updated.
- [ ] `.qli/project/foundation-target.yml` selected.
- [ ] `.qli/project/foundation-applicability.yml` completed.
- [ ] `.qli/project/foundation-status.yml` initialized.
- [ ] `.qli/project/deferral-register.md` initialized.
- [ ] `.qli/project/current-slice.yml` identifies the active slice or setup phase.

## Product/application spine

- [ ] UI shell/navigation/demo route exists or UI is explicitly not applicable.
- [ ] API health endpoint/response/error pattern exists or API is explicitly not applicable.
- [ ] Data migration/schema/seed posture exists or data persistence is explicitly not applicable.
- [ ] ACL actor/capability/policy baseline exists or ACL is explicitly not applicable.
- [ ] Security posture/surface/secrets baseline exists.
- [ ] Test commands and human smoke path exist.
- [ ] Runtime/startup/delivery profile exists.
- [ ] Observability/health/error visibility exists where deployable runtime exists.
- [ ] DevBox registration/routing/port posture exists when DevBox is in scope.

## Gate

- [ ] Deferrals have reason, risk, trigger, review point, and owner.
- [ ] Implementation evidence is recorded.
- [ ] Human can review a real product path, not only source code.
