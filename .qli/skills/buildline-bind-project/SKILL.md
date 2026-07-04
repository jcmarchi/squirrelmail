---
name: buildline-bind-project
description: Convert a project profile into deterministic QLi Buildline Foundation applicability, target requirements, deferrals, and starting spine scope.
---

# Buildline Bind Project Skill

Use this skill when a new project skeleton must be bound to a product concept or when an existing project lacks a reliable Buildline applicability model.

## Required Inputs

Read:

```text
QLI.md
.qli/binding/project-classifier.md
.qli/binding/project-profile.schema.yml
.qli/binding/foundation-applicability-algorithm.md
.qli/binding/foundation-applicability-rules.yml
.qli/binding/foundation-target-levels.yml
.qli/binding/implementation-priority-rules.md
.qli/binding/deferral-rules.md
.qli/binding/foundation-applicability-output-template.yml
.qli/project/manifest.yml
.qli/project/operating-profile.yml
.qli/project/foundation-target.yml
```

## Procedure

1. Classify the project type, stage, user surfaces, data sensitivity, authentication model, tenant model, deployment target, and approved stack.
2. Apply the binding algorithm; do not infer requirements from preference alone.
3. Produce or update `.qli/project/foundation-applicability.yml`.
4. Produce or update initial `.qli/project/deferral-register.md` entries for non-implemented but applicable items.
5. Update `.qli/project/foundation-status.yml` only with state that is evidenced.
6. Do not implement application code during binding.

## Required Output

```text
Binding Result:
- Project type:
- Target level:
- Required foundations:
- Partial foundations:
- Not applicable foundations:
- Explicit deferrals:
- Required Spine items:
- First recommended slice:
```

## Stop Conditions

Stop if the project profile lacks enough information to decide authentication, user surface, data sensitivity, deployment target, or tenant model.
