# UI Component Inventory

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `/docs/ui-component-inventory.md`  
**Purpose:** Track reusable UI components so AI Coding Companions do not create duplicates.

## Status Values

| Status | Meaning |
|---|---|
| Proposed | Needed, not yet implemented. |
| Planned | Approved for implementation. |
| Partial | Exists but missing states, tests, demo, or accessibility coverage. |
| Stable | Approved reusable component. |
| Deprecated | Should not be used for new work; replacement identified. |

## Component Inventory

| Component | Category | Status | Files/Paths | Variants | States Covered | Demo Coverage | Tests | Notes |
|---|---|---|---|---|---|---|---|---|
| Button | Actions | Proposed | [path] | primary, secondary, ghost, danger, link | default, hover, focus, active, disabled, loading | No | No | First component usually implemented. |
| Form Field | Forms | Proposed | [path] | text, helper, error, required | default, focus, error, disabled, readonly | No | No | Should wrap labels/help/errors consistently. |
| Modal/Dialog | Feedback | Proposed | [path] | sm, md, lg, blocking | open, closing, loading, nested | No | No | Must include focus trap and scroll lock. |
| Data Table | Data | Proposed | [path] | client, server, selectable | loading, empty, error, filtered | No | No | Avoid one-off tables. |

## Admission Log

Record every newly added foundation component here.

| Date | Component | Reason Admitted | Reused/Extended Alternatives Considered | Reviewer |
|---|---|---|---|---|
| YYYY-MM-DD | [Component] | [Reason] | [Alternatives] | [Name] |

## Deprecated UI

| Deprecated item | Replacement | Migration status | Notes |
|---|---|---|---|
| [Old class/component] | [New component] | [planned/partial/done] | [notes] |
