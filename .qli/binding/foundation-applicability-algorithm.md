# Foundation Applicability Algorithm

This algorithm is the deterministic bridge between the generic QLi Foundations and a specific project. The AI coding agent must not invent the applicability model from the foundation references alone.

## Required inputs

The agent must start from the project profile and operating files:

- `.qli/project/manifest.yml`
- `.qli/project/operating-profile.yml`
- `.qli/project/foundation-target.yml`
- `.qli/binding/project-profile.schema.yml`
- `.qli/binding/foundation-applicability-rules.yml`
- `.qli/binding/foundation-target-levels.yml`

If required fields are missing, the agent may draft assumptions, but implementation must mark those assumptions as unapproved risks.

## Applicability states

Use only these states:

- `spine_required`: applies now and its minimum upfront spine must exist before broad feature work.
- `required`: applies now and must be represented in implementation for relevant slices.
- `minimum_required`: a baseline is required now; advanced capabilities activate only by trigger.
- `partial`: named controls apply now; the rest must be deferred or marked not applicable.
- `deferred`: applicable later; must include trigger, risk, owner, and review point.
- `not_applicable`: does not apply to this project or slice; must include reason.
- `blocked`: should apply but cannot yet be implemented; must include blocker, owner, and next action.

## Precedence

When multiple rules produce different states, use the strictest applicable state:

```text
spine_required > required > minimum_required > partial > deferred > not_applicable
```

`blocked` is not a lower state. It is a failure/exception state for a required item that cannot be completed.

## Algorithm

1. Validate the project profile against `.qli/binding/project-profile.schema.yml`.
2. Initialize all known foundations as `not_applicable` with reason `no rule applied yet`.
3. Apply universal defaults from `foundation-applicability-rules.yml`.
4. Apply `project_type_defaults`.
5. Apply `stage_scaling` minimum expectations.
6. Apply explicit product surfaces from the project profile and operating profile.
7. Apply construction flags: `ui_required`, `api_required`, `acl_required`, `human_review_required`, `devbox_integration`.
8. Apply hard rules. Hard rules override convenience, preference, and low target-level selection.
9. Record every non-implemented required item as `partial`, `deferred`, or `blocked` with the required deferral fields.
10. Write the result to `.qli/project/foundation-applicability.yml`.
11. Update `.qli/project/foundation-status.yml` and `.qli/project/deferral-register.md`.

## Hard blocking conditions

The agent must stop and report a binding defect when:

- A protected route/action exists but ACL is `not_applicable` or silently deferred.
- Public or authenticated software exists but Security is `not_applicable` or silently deferred.
- A UI slice exists without a human smoke path.
- An endpoint consumed by UI/integrations exists without API response/error discipline.
- Persistent or sensitive data exists without data classification.
- DevBox exposure exists without delivery/security/test spine.

## Output standard

The generated applicability matrix must include, for each foundation:

- state
- reason
- upfront spine requirement
- implementation evidence expected
- allowed deferrals
- non-deferrable items
- context files to read

This makes Foundation application project-specific without making it subjective.
