# QLi Buildline Binding Layer

The Binding Layer is the deterministic translator between generic QLi Foundations and a specific project.

The Foundations are intentionally generic. They must remain usable for SaaS products, APIs, internal tools, content applications, DevBox-hosted demos, desktop tools, libraries, and other project types. The Binding Layer prevents the AI coding agent from improvising how those generic rules apply.

## Binding Principle

```text
Foundation reference = project-agnostic doctrine.
Project binding = project-specific applicability.
Implementation workflow = controlled execution.
```

A coding agent must not decide applicability by reading foundation files alone. It must read the project profile, apply the binding rules, produce or update `.qli/project/foundation-applicability.yml`, then execute only the applicable workflow.

## Binding Outputs

The primary binding output is:

```text
.qli/project/foundation-applicability.yml
```

Secondary outputs include updates to:

```text
.qli/project/foundation-status.yml
.qli/project/deferral-register.md
.qli/project/current-slice.yml
.qli/project/evidence-log.md
```

## Binding Files

```text
project-classifier.md                 # how to classify the project before applying doctrine
project-profile.schema.yml            # required/allowed profile fields
foundation-target-levels.yml          # spine, mvp, production, enterprise target levels
foundation-applicability-rules.yml    # deterministic applicability rules by profile/surface/risk
implementation-priority-rules.md      # what gets built first and why
deferral-rules.md                     # when non-implementation is valid
agent-context-loading-rules.md        # which references an agent reads for a task
```

## Validation support

The binding layer is the deterministic translation layer for QLi Buildline. Generic Foundation doctrine does not decide what applies to a project by itself. The project profile is classified, the applicability rules are applied in order, and the result is written as `.qli/project/foundation-applicability.yml`.

The controlling sequence is:

```text
project profile -> classifier -> target level -> applicability rules -> spine requirements -> deferrals -> status/evidence
```

Use `.qli/binding/foundation-applicability-algorithm.md` as the canonical execution rule for this sequence.
