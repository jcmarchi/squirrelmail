# Agent Context Loading Rules

## Purpose

Prevent AI agents from rereading the entire Buildline package on every prompt while still loading the right controls.

## Startup Baseline

Always read:

```text
AGENTS.md
QLI.md
.qli/buildline.yml
.qli/project/manifest.yml
.qli/project/operating-profile.yml
.qli/project/foundation-target.yml
.qli/project/foundation-applicability.yml
.qli/project/foundation-status.yml
.qli/project/current-slice.yml when implementation is requested
```

## Triggered Reads

| Task type | Additional reads |
|---|---|
| Project binding | `.qli/binding/project-classifier.md`, schema, applicability rules, target levels, deferral rules |
| Foundation Spine | `.qli/spine/README.md`, `.qli/spine/spine-checklist.md`, triggered implementation controls |
| UI work | UI implementation control, UI reference, relevant UI inventory/demo checklist |
| API work | API implementation control, API reference, endpoint/contract inventory |
| DATA work | DATA implementation control, DATA reference, entity/storage/lifecycle files |
| ACL work | ACL implementation control, access-control reference, route/permission/test matrix |
| Security work | Security implementation control, posture/trigger files |
| Testing work | Testing implementation control, smoke/regression/testing adapter files |
| Runtime work | Runtime implementation control and runtime adapter |
| Observability work | Observability implementation control and relevant inventory files |
| Delivery/DevBox work | Delivery/DevBox implementation controls and runtime profile files |
| Gate review | relevant gates and evidence templates |

## Do Not Read By Default

```text
manual DOCX files
all foundation references
unrelated foundation folders
historical reports
```

## Stop Rule

If the project docs or `.qli/project/` files still contain placeholders that block implementation, stop and return to AI Co-Architect skeleton customization.
