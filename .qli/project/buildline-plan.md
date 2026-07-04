# QLi Buildline Implementation Plan

## Purpose

This file translates the project-specific Buildline profile into the concrete implementation sequence for a new project. It is completed by the AI Co-Architect when the Universal Skeleton is customized for a specific product.

## Project Mode

- Mode: `new_project`
- Target level: `[spine | mvp | production | enterprise]`
- Current slice: `[slice id]`

## Foundation Spine

| Area | Required upfront? | Current status | Evidence | Deferrals |
|---|---:|---|---|---|
| ACD/Core | yes | not-started |  |  |
| UI/UX | profile-triggered | not-started |  |  |
| DATA | yes | not-started |  |  |
| API | profile-triggered | not-started |  |  |
| ACL | profile-triggered | not-started |  |  |
| Runtime | profile-triggered | not-started |  |  |
| Testing | yes | not-started |  |  |
| Observability | baseline | not-started |  |  |
| Delivery | yes | not-started |  |  |
| Security | baseline | not-started |  |  |
| DevBox | optional/profile-triggered | not-started |  |  |

## New-Project Sequence

1. `[Slice 001]` — Foundation profile and applicability.
2. `[Slice 002]` — Foundation Spine implementation.
3. `[Slice 003]` — First real vertical product slice.
4. `[Slice 004]` — Hardening and gate cleanup.

## Risk Controls

- Do not allow the coding agent to infer product architecture from placeholders.
- Defer only through `.qli/project/deferral-register.md`.
- Every implementation slice must update `.qli/project/evidence-log.md` and `.qli/project/foundation-status.yml`.
