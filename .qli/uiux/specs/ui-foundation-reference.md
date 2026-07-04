# Universal UI Foundation Reference

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Version:** 2.0-Generic-New-Project  
**Intended location:** `/docs/ui-foundation-reference.md`  
**Primary audience:** AI Coding Companions, human architects, reviewers, product owners  
**Scope:** Generic, stack-neutral UI foundation for new applications and continued feature development  

---

## 0. Mandatory Instruction to AI Coding Agents

Before creating, modifying, or refactoring any user interface, read this file and treat it as the repository's UI source of truth.

You must not create one-off buttons, cards, modals, drawers, tables, dropdowns, menus, sidebars, form controls, alerts, badges, icons, toolbars, navigation structures, or layout shells when an existing token, primitive, component, pattern, or documented variant can be reused or extended.

The UI Foundation is a contract, not a visual theme. It defines how UI is structured, reused, themed, made accessible, tested, documented, and extended. The project adapter defines how this contract maps into the actual stack.

### Mandatory execution sequence

For every UI-related task:

1. Read `AGENTS.md`.
2. Read this file: `/docs/ui-foundation-reference.md`.
3. Read `/docs/ui-adapter.md` if present.
4. Read `/docs/ui-component-inventory.md` if present.
5. Inspect existing components, templates, styles, routes, demo pages, story pages, tests, and UI utilities before creating anything new.
6. Reuse an existing component or pattern wherever possible.
7. Extend an existing component only through approved tokens, variants, states, slots, props, composition, or adapter-sanctioned mechanisms.
8. Create a new component only if the New Component Admission Rule in this document is satisfied.
9. Update the component inventory and demo/reference page whenever a component, state, token, or pattern changes.
10. Validate accessibility, keyboard behavior, responsive behavior, theme behavior, i18n/RTL readiness, overlay/focus behavior, and visual consistency.
11. End your implementation report by listing what was reused, extended, newly created, tested, and deferred.

### Prohibited behavior

AI Coding Agents must not:

- Bypass the foundation with feature-specific CSS when a reusable component exists.
- Add raw colors, unregistered shadows, arbitrary z-index values, or repeated spacing values inside component CSS.
- Invent duplicate components under different names.
- Introduce framework conventions that conflict with the current repository adapter.
- Force React, Vue, Angular, Tailwind, HTMX, Alpine.js, Twig, Blade, or any other stack into a repository that has not adopted it.
- Remove existing working UI behavior without a documented migration reason.
- Mark a UI task complete without updating documentation when the foundation changes.

---

## 1. What This Foundation Is

The Universal UI Foundation is a reusable interface operating model. It provides the rules, vocabulary, acceptance criteria, and extension process required to keep AI-assisted UI development consistent across many applications.

It is designed for SaaS applications, admin panels, publication systems, CRMs, dashboards, AI tools, marketplaces, media systems, finance tools, content platforms, public/private portals, mobile-first web apps, and hybrid server/client-rendered applications.

The foundation controls structure, behavior, accessibility, state, reuse, theme compatibility, and documentation. It does not force every product to share the same brand, color palette, layout density, component library, JavaScript framework, or visual personality.

---

## 2. Universal Foundation vs. Project Adapter

The foundation is universal. The adapter is repository-specific.

| Layer | Owner | Purpose |
|---|---|---|
| Universal UI Foundation | This document | Defines reusable rules, components, tokens, states, behavior, accessibility, and acceptance criteria. |
| Project Adapter | `/docs/ui-adapter.md` | Maps the foundation to the actual stack, file paths, naming prefix, rendering mode, theme mechanism, JS behavior, tests, and demo location. |
| Component Inventory | `/docs/ui-component-inventory.md` | Tracks what exists, what is partial, what is deprecated, and what must be reused. |
| Demo/Reference Page | Project-specific route or story system | Displays every component, variant, state, theme, responsive behavior, and edge case. |

The same foundation can support React, Vue, Angular, Svelte, Twig, Blade, plain PHP, Django/Jinja templates, HTMX, Alpine.js, Tailwind, vanilla JavaScript, or any hybrid architecture. Stack syntax changes; the contract does not.

---

## 3. Supported Implementation Models

### 3.1 Component-based frameworks

React, Vue, Angular, Svelte, Solid, Lit, and similar frameworks should implement the foundation as reusable components, primitives, hooks/composables/services, providers/stores, tests, and story/demo coverage.

Example conceptual mapping:

```tsx
<Button variant="primary" size="md" loading={saving}>Save</Button>
<Modal open={open} title="Create Item" onClose={close}>...</Modal>
<DataTable columns={columns} rows={rows} serverSide onSort={handleSort} />
```

### 3.2 Server-rendered stacks

Twig, Blade, plain PHP templates, Django/Jinja templates, Rails views, and similar stacks should implement the foundation through partials, macros, helpers, CSS classes, data attributes, and progressive JavaScript.

Example conceptual mapping:

```twig
{{ ui.button({ label: 'Save', variant: 'primary', size: 'md', loading: saving }) }}
{{ ui.modal({ id: 'create-item', title: 'Create Item' }) }}
```

### 3.3 Progressive enhancement stacks

HTMX and Alpine.js are compatible when they remain enhancement layers rather than uncontrolled behavior sprawl. Server-rendered components should remain canonical; HTMX handles swaps/requests; Alpine handles local state only when the behavior is small, documented, reusable, and consistent with foundation rules.

### 3.4 Tailwind-compatible implementation

Tailwind is compatible only if configured as an implementation accelerator. It must consume foundation tokens or project-approved theme values. It must not become arbitrary utility soup.

Approved Tailwind use:

- Token-mapped theme values.
- Reusable component classes or component wrappers.
- Predictable variant systems.
- Design-system-level utilities.

Rejected Tailwind use:

- One-off arbitrary colors and spacing across feature pages.
- Duplicated button/card/modal/table structures.
- Component behavior implemented only through scattered utility classes with no inventory or demo coverage.

---

## 4. Foundation Layers

A complete UI foundation has five layers.

| Layer | Purpose | Examples |
|---|---|---|
| Tokens | Visual and semantic constants | Colors, typography, spacing, radius, shadows, z-index, motion, shell dimensions. |
| Primitives | Low-level reusable blocks | Surface, Stack, Cluster, Grid, Text, Icon, Divider, ScrollArea, FocusRing, VisuallyHidden, OverlayRoot. |
| Components | Reusable UI objects | Button, Input, Card, Modal, Drawer, Dropdown, Table, Tabs, Badge, Toast, Tooltip, Sidebar. |
| Patterns | Composed application structures | App shell, list/detail, CRUD form, wizard, dashboard, settings page, inspector panel, command workflow. |
| Adapter | Repository-specific mapping | Stack, paths, naming, rendering, theme, i18n, icons, overlay system, tests, demo route. |

AI agents must determine whether a requested UI change belongs to an existing component, an existing variant, a reusable pattern, or a genuinely new foundation component. Do not jump directly to feature-specific markup and CSS.

---

## 5. Required Repository Documents

Every project using this foundation should include:

```text
/docs/
  ui-foundation-reference.md      # This document; universal operating reference.
  ui-adapter.md                   # Project-specific implementation mapping.
  ui-component-inventory.md       # Reusable UI inventory and status tracking.
  ui-demo-checklist.md            # Manual/AI smoke checklist for the demo/reference page.
```

When a project is brand new, the AI Coding Agent must create these companion files before or during the first UI foundation pass.

When a project already exists, the AI Coding Agent must inspect current UI assets and populate these files based on the actual codebase. Do not invent an adapter that contradicts the repository.

---

## 6. Project Adapter Contract

`/docs/ui-adapter.md` must answer these questions:

| Field | Required decision |
|---|---|
| Stack | React, Vue, Angular, Svelte, plain PHP, Laravel Blade, Twig, HTMX, Alpine.js, etc. |
| Rendering mode | SPA, MPA, server-rendered, static, hybrid, island architecture, embedded widget. |
| UI source paths | Where components, templates, styles, scripts, icons, and UI tests live. |
| Token paths | Where design tokens are defined and loaded. |
| Prefix/naming | Class prefix, data attribute prefix, component naming convention. |
| Theme mechanism | `data-theme`, root class, provider, server preference, tenant theme, CSS variables. |
| I18n mechanism | Translation files, server helper, runtime store, framework plugin, fallback policy. |
| Icon system | Inline SVG, SVG sprite, icon package, custom asset set. |
| Overlay strategy | Portal, teleport, fixed overlay root, top-layer, native dialog/popover, overlay service. |
| State management | Local state, server state, framework store, events, signals, request lifecycle. |
| Test strategy | Unit, integration, browser smoke, accessibility, visual regression, story/demo checks. |
| Demo/reference page | Route/path/story system used to show components. |
| Component inventory | Path and status convention. |

---

## 7. Naming, Isolation, and Prefix Rules

The examples in this document use `ui-*` and `data-ui-*` as neutral placeholders. A project may use another prefix, but the prefix must be consistent.

Preferred generic HTML pattern:

```html
<div class="ui-shell" data-ui-shell>
  <a class="ui-skip-link" href="#main-content">Skip to main content</a>
  <header class="ui-header">...</header>
  <main class="ui-main" id="main-content">...</main>
  <div class="ui-overlay-root" data-ui-overlay-root></div>
</div>
```

Rules:

1. Root component contracts must be stable.
2. Use classes for styling contracts and `data-ui-*` for behavior/test hooks when appropriate.
3. Do not mix unrelated prefixes except during documented migration.
4. Do not create page-specific classes for reusable components.
5. Scope global resets to the app root unless the project explicitly owns the full page.
6. Third-party widgets must be isolated so foundation styles do not corrupt them.

---

## 8. Design Tokens

Design tokens are the single source of truth for visual values. Components must consume tokens rather than raw values.

### 8.1 Required token categories

| Category | Required token examples |
|---|---|
| Background | `--color-bg-primary`, `--color-bg-secondary`, `--color-bg-elevated`, `--color-bg-sunken`, `--color-overlay` |
| Text | `--color-text-primary`, `--color-text-secondary`, `--color-text-muted`, `--color-text-disabled`, `--color-text-inverse` |
| Border/focus | `--color-border`, `--color-border-strong`, `--color-focus-ring` |
| Action/brand | `--color-accent`, `--color-accent-hover`, `--color-accent-active`, `--color-accent-subtle` |
| Semantic | `--color-success`, `--color-warning`, `--color-danger`, `--color-info`, plus subtle variants |
| List/table | `--color-row-hover`, `--color-row-selected`, `--color-row-stripe`, `--color-highlight` |
| Typography | `--font-family-base`, `--font-family-mono`, `--font-size-xs` through `--font-size-3xl`, weights, line heights |
| Spacing | `--space-0` through `--space-16` on a 4px base scale |
| Radius | `--radius-xs`, `--radius-sm`, `--radius-base`, `--radius-md`, `--radius-lg`, `--radius-xl`, `--radius-full` |
| Shadow | `--shadow-xs`, `--shadow-sm`, `--shadow-base`, `--shadow-md`, `--shadow-lg`, `--shadow-inset` |
| Z-index | `--z-base`, `--z-sticky`, `--z-sidebar`, `--z-dropdown`, `--z-popover`, `--z-overlay`, `--z-modal`, `--z-toast`, `--z-context-menu`, `--z-tooltip` |
| Motion | `--duration-instant`, `--duration-fast`, `--duration-normal`, `--duration-slow`, `--duration-slower`, easings |
| Layout | `--header-height`, `--footer-height`, `--icon-bar-width`, `--sidebar-left-width`, `--sidebar-right-width`, `--content-max-width` |

### 8.2 Token example

```css
:root {
  --font-family-base: system-ui, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
  --font-family-mono: "JetBrains Mono", "Fira Code", ui-monospace, monospace;

  --space-0: 0;
  --space-1: 0.25rem;
  --space-2: 0.5rem;
  --space-3: 0.75rem;
  --space-4: 1rem;
  --space-6: 1.5rem;
  --space-8: 2rem;
  --space-12: 3rem;
  --space-16: 4rem;

  --radius-base: 0.375rem;
  --radius-md: 0.5rem;
  --radius-lg: 0.75rem;
  --radius-full: 9999px;

  --duration-fast: 100ms;
  --duration-normal: 200ms;
  --duration-slow: 300ms;
  --easing-default: cubic-bezier(0.4, 0, 0.2, 1);
}

html[data-theme="light"] {
  --color-bg-primary: #ffffff;
  --color-bg-secondary: #f5f7fa;
  --color-bg-elevated: #ffffff;
  --color-bg-sunken: #ebedf0;
  --color-text-primary: #1a1d23;
  --color-text-secondary: #5a6478;
  --color-border: #dee2e8;
  --color-accent: #2563eb;
}
```

### 8.3 Raw value exceptions

Raw values are allowed only inside token definitions or for measured runtime values such as overlay coordinates, chart/canvas drawing, user-uploaded media dimensions, computed table column widths, and third-party integration boundaries. Exceptions must be local, intentional, and documented when persistent.

---

## 9. Theme System

The foundation must support theme-safe architecture from the beginning. Mature applications should support at least light and dark themes. High-contrast is required for professional, enterprise, public-sector, accessibility-sensitive, or long-session products. Custom themes are recommended for white-label or tenant-branded products.

Preferred root contract:

```html
<html lang="en" dir="ltr" data-theme="light">
```

Theme rules:

1. Themes override tokens, not component CSS.
2. SVG icons use `currentColor` unless intentionally semantic.
3. First paint must avoid wrong-theme flash.
4. Theme preference must persist in local storage, server profile, tenant settings, or equivalent.
5. Theme changes must not break focus rings, contrast, charts, icons, disabled states, or overlays.
6. Motion during theme switching must respect `prefers-reduced-motion`.

---

## 10. Internationalization, Localization, and RTL

Production strings should be externalized through the project i18n mechanism. Components must not embed production English sentences directly unless the repository has explicitly chosen server-only rendering with server-side translation.

Requirements:

1. Root element sets `lang` and `dir`.
2. UI must survive 30-50% longer translated strings.
3. RTL must mirror directional layout, chevrons, borders, active indicators, drawers, menus, and table alignment.
4. Dates use locale-aware formatting.
5. Numbers and currencies use locale-aware formatting.
6. Missing translation keys fall back safely and surface a development warning.
7. Prefer logical CSS properties: `padding-inline`, `margin-inline`, `border-inline-start`, `inset-inline-start`.

---

## 11. Accessibility and Keyboard Standards

Accessibility is a foundation-level responsibility.

Minimum rules:

1. Use native semantic elements before ARIA replacements.
2. Every interactive element must be keyboard reachable.
3. Every focusable element must have visible focus.
4. Icon-only controls require accessible names.
5. Form fields require programmatic labels.
6. Help text and errors must be connected through IDs and `aria-describedby`.
7. Modals and drawers require focus management and background interaction control.
8. Color cannot be the only signal for state.
9. Motion must respect `prefers-reduced-motion`.
10. Full application shells must include a skip link to main content.
11. Contrast must meet WCAG 2.1 AA minimum; high-contrast mode should target AAA.

---

## 12. Layout Foundation

The application shell is a slot system, not a visual mandate. Enable only the regions the product needs.

| Slot | Purpose | Required? |
|---|---|---|
| Header | Brand, app title, search, quick actions, notification, user menu, theme/locale controls | Usually yes |
| System menu | Desktop-style File/Edit/View/Tools/Help operations | Optional |
| Icon/activity bar | Top-level section switcher | Optional |
| Left sidebar | Navigation tree, filters, workspace/project context | Optional/common |
| Main content | Primary page content and skip-link target | Yes |
| Right sidebar | Inspector, properties, comments, details | Optional |
| Footer/status bar | Version, status, connection, legal links, hint line | Optional |
| Overlay root | Safe home for overlays | Required when overlays exist |

Responsive expectations:

| Breakpoint | Behavior |
|---|---|
| `xs < 480px` | Sidebars become drawers; header compacts; footer may hide; tables become scrollable or cards. |
| `sm 480-768px` | Left sidebar usually off-canvas; icon bar may collapse into menu. |
| `md 768-1280px` | Right sidebar commonly collapses into drawer; left navigation may remain visible. |
| `lg > 1280px` | Full enabled shell may render. |

---

## 13. Overlay and Floating UI Strategy

Floating UI is one of the most fragile areas in AI-generated interfaces. The foundation must define a single overlay policy.

Rules:

1. Render overlays through a portal, teleport, top-layer API, native dialog/popover, overlay service, or fixed overlay root.
2. Do not render floating menus as absolute-positioned children inside clipped or scrolling containers.
3. Clamp dropdowns, context menus, tooltips, popovers, and command palettes to the viewport.
4. Close or reposition overlays on resize, scroll of relevant container, Escape, outside click, and route change.
5. Interactive overlays must manage focus and return focus to the trigger on close.
6. Use z-index tokens only.
7. Nested overlays require explicit stack and focus rules.

---

## 14. Universal Component Contract

Every reusable component should expose or support the following concepts, mapped to the project stack:

| Contract | Meaning |
|---|---|
| `id` | Stable ID for ARIA relationships when needed. |
| `class` / `className` | Additional classes appended to root. |
| `style` | Inline overrides; use sparingly. |
| `data-ui-*` | Behavior hooks, state hooks, and integration metadata. |
| `data-testid` | Test selector when required by project convention. |
| `data-hint` | Optional hint text for footer/status/tooltip systems. |
| `aria-label` | Accessible label override. |
| `aria-describedby` | Accessible description reference. |
| `disabled` | Disabled state and interaction lock. |
| `readonly` | Non-editable but visible/focusable state where appropriate. |
| `loading` | Loading state with spinner/skeleton and unsafe-action blocking. |
| `size` | Approved size scale. |
| `variant` | Approved visual variant. |
| `state` | Active, selected, expanded, collapsed, invalid, valid, etc. |
| events | Native or framework events for focus, blur, change, open, close, submit, select. |

---

## 15. Required State Model

Every interactive component must define these states where relevant:

Default, hover, focus-visible, active/pressed, selected/current, disabled, readonly, loading, empty, error, success, warning, expanded, collapsed, open, closed, dragging, dropping, invalid, valid, indeterminate, and skeleton.

AI agents must not implement only the happy-path visual state.

---

## 16. Core Component Catalog

Projects may phase implementation, but they must not duplicate these concepts under feature-specific names.

### 16.1 Actions

Button, icon button, split button, button group, toolbar button, link action.

Button requirements:

- Variants: primary, secondary, ghost, danger, link; project may add success/warning/info.
- Sizes: small, medium, large; icon-only sizes must preserve touch targets.
- States: default, hover, focus-visible, active, disabled, loading.
- Icon-only buttons require accessible names.
- Primary action should be limited to the main action in a view or decision area.

### 16.2 Forms

Form field wrapper, text input, textarea, select, combobox, checkbox, radio group, switch, token/tag input, date/time input, number/currency input, file input.

Form requirements:

- Every field has a label.
- Required state is visual and semantic.
- Helper and error text are connected with described-by relationships.
- Validation messages are specific and non-destructive.
- Forms support server-rendered errors and client enhancement.
- Indeterminate checkboxes use the browser IDL properties correctly; do not `preventDefault()` checkbox/radio click handlers.

### 16.3 Display

Card, panel, surface, badge, pill, tag, avatar, avatar group, KPI/stat card, description list, empty state, skeleton, spinner, progress, divider, watermark, result/status page.

Display requirements:

- Cards support header/body/footer/media where relevant.
- Badges/pills/tags support semantic variants.
- Empty states include title, description, and optional action.
- Skeletons and spinners respect reduced motion.
- Progress components expose proper ARIA values.

### 16.4 Navigation

Header, footer/status bar, system menu, icon/activity bar, left sidebar, right sidebar, navigation tree, breadcrumb, tabs, pagination, steps/wizard, command palette.

Navigation requirements:

- Current location is programmatically identifiable.
- Keyboard behavior is defined.
- Navigation survives responsive collapse.
- Sidebars and panels persist size/collapse state when project scope requires it.
- Command palette supports shortcut, search, grouped results, empty state, and focus management.

### 16.5 Menus and overlays

Dropdown, context menu, popover, tooltip, modal/dialog, drawer, toast, announcement bar, popconfirm, floating window.

Menu requirements:

- Item types: standard, destructive, disabled, divider, section header, check/toggle, radio, submenu.
- Toggle/check menu items should remain open when the user is changing multiple settings.
- Context menus must support right-click, keyboard context key/Shift+F10, and touch fallback.
- Tooltips are not a substitute for accessible labels.
- Modals and drawers require focus management, Escape behavior, scroll lock, and backdrop policy.

### 16.6 Data table

The data table is a foundation component, not page-specific markup.

Required capabilities as project scope matures:

- Title/subtitle and toolbar.
- Column definitions with type, label, alignment, sortability, visibility, width, custom renderer.
- Sorting, filtering, pagination, search, and reset filters.
- Selection, select visible, select all matching when server-side logic supports it.
- Row actions and bulk actions.
- Loading, empty, error, filtered-no-results, partial-load states.
- Header associations, `aria-sort`, and keyboard access.
- Server-side and client-side operation modes.
- Performance strategy for large data sets: pagination, virtualization, or server delegation.

Sorting only the currently visible page without disclosure is a functional defect.

---

## 17. Patterns

Reusable patterns prevent each feature from inventing its own layout.

Recommended patterns:

| Pattern | Purpose |
|---|---|
| App shell | Persistent navigation and content frame. |
| List/detail | List or table plus detail panel or route. |
| CRUD form | Create/edit/view/delete flow with validation and confirmation. |
| Wizard | Multi-step workflow with status and validation. |
| Dashboard | KPI cards, charts, tables, alerts, recent activity. |
| Settings page | Grouped panels, forms, save/cancel/apply behavior. |
| Inspector panel | Right-side details/properties/history/comments. |
| Bulk action workflow | Selection plus toolbar, confirmation, progress, result. |
| Search/results page | Query, filters, sorting, result states, pagination. |
| Empty onboarding | First-run setup or no-data state. |

---

## 18. Component Inventory Rules

The component inventory is mandatory control documentation.

Each component entry must track:

- Component name.
- Purpose.
- Status: proposed, planned, partial, stable, deprecated.
- Files/paths.
- Variants.
- States.
- Accessibility notes.
- Demo coverage.
- Tests.
- Known gaps.
- Replacement/deprecation path if applicable.

AI agents must update the inventory when they create, extend, rename, deprecate, or materially change a component.

---

## 19. Demo/Reference Page Rules

Every project needs a UI demo/reference page, storybook, or equivalent route. It is not decorative documentation; it is a regression and reuse control surface.

The demo must render:

- Tokens and theme samples.
- Buttons and actions.
- Form controls and validation states.
- Cards and display components.
- Navigation components.
- Menus and overlays.
- Tables and table states.
- Modals/drawers/toasts/tooltips/popovers.
- Loading, empty, error, disabled, selected, and edge cases.
- Mobile, tablet, and desktop examples when feasible.
- RTL and dark/high-contrast theme examples when in scope.

---

## 20. CSS and Styling Rules

1. Component CSS must consume tokens.
2. Avoid `!important`; use it only for controlled utility escape hatches documented in the adapter.
3. Keep specificity low and predictable.
4. Prefer composition over descendant chains.
5. Prefer logical properties for direction-sensitive layout.
6. Separate structural layout from theme values.
7. Do not rely on color alone for state.
8. Do not use random z-index values.
9. Avoid page-specific visual forks of foundation components.
10. CSS reset and base rules must be scoped or intentionally global.

---

## 21. JavaScript Behavior Rules

1. Behavior must be reusable and centralized where possible.
2. Framework projects should use idiomatic framework patterns consistent with the adapter.
3. Server-rendered projects should use progressive enhancement and data attributes consistently.
4. Events must be documented when they are part of a reusable component API.
5. Overlay, focus, keyboard, scroll lock, and escape behavior must not be duplicated ad hoc.
6. Avoid fragile DOM queries that break when markup changes.
7. Do not store layout state in local storage without a stable, namespaced key.

---

## 22. Quality Gates

A UI task is not complete until these gates pass or documented exceptions are provided.

| Gate | Pass condition |
|---|---|
| Reuse gate | Existing components and patterns were checked first. |
| Token gate | No unapproved raw colors, z-index values, shadows, or repeated spacing. |
| Accessibility gate | Keyboard, focus, labels, ARIA, contrast, and reduced motion checked. |
| Responsive gate | xs/sm/md/lg behavior checked where applicable. |
| Theme gate | Light/dark/high-contrast/custom behavior checked according to project scope. |
| I18n/RTL gate | Strings and direction behavior checked where relevant. |
| Overlay gate | Floating elements are unclipped, positioned, dismissible, and focus-safe. |
| State gate | Loading, empty, error, disabled, selected/current states handled where relevant. |
| Demo gate | Demo/reference page updated for new/changed components. |
| Inventory gate | Component inventory updated. |
| Test gate | Project tests/smoke checks run or documented as unavailable. |

---

## 23. New Component Admission Rule

A new foundation component may be created only when all are true:

1. No existing component solves the need through composition.
2. No existing component solves the need through a reusable variant.
3. The component represents a reusable UI concept, not a one-page layout.
4. Anatomy, states, behavior, keyboard rules, ARIA rules, tokens, and acceptance criteria are defined.
5. Demo/reference coverage is added.
6. Inventory entry is added.
7. It can plausibly be reused by another feature.

---

## 24. Existing Application Refactor Rule

When adopting this foundation in an existing application:

1. Audit the current UI before changing it.
2. Identify reusable elements already present.
3. Preserve working product behavior.
4. Convert duplicated patterns into foundation components gradually.
5. Provide compatibility aliases where needed.
6. Do not perform broad visual redesign unless requested.
7. Migrate high-value, high-reuse components first: buttons, forms, cards, modals, tables, sidebars, menus.
8. Document what was preserved, replaced, deprecated, and deferred.

---

## 25. Human Review Checklist

Reviewers should reject AI-generated UI when:

1. It creates duplicate components.
2. It bypasses tokens.
3. It works visually but fails keyboard use.
4. It ignores loading/empty/error states.
5. It breaks dark theme or high contrast.
6. It creates clipped menus or popovers.
7. It uses random z-index values.
8. It hard-codes reusable business text inside components.
9. It implements a table as static markup when table behavior is required.
10. It fails to update demo or inventory after foundation changes.

---

## 26. Standard Prompt Fragment for AI Coding Companions

Use this block whenever UI work is requested:

```text
UI FOUNDATION REQUIREMENT:
Before implementing UI, read /docs/ui-foundation-reference.md, /docs/ui-adapter.md if present, and /docs/ui-component-inventory.md if present. Reuse existing UI foundation components, tokens, primitives, and patterns. Do not create duplicate buttons, cards, modals, tables, dropdowns, form controls, sidebars, navigation trees, toasts, or overlays. If a new component or reusable variant is necessary, add it to the component inventory and demo/reference page. Preserve accessibility, keyboard behavior, responsive behavior, theme support, RTL/i18n readiness, and overlay/focus management. End your response by listing which foundation components were reused, which were extended, which were newly added, and which tests/smoke checks were run.
```

---

## 27. Final Rule

The UI Foundation exists to prevent AI-generated software from drifting into inconsistent, redundant, fragile interface code. The correct output is not merely attractive UI. The correct output is reusable, accessible, theme-aware, responsive, documented, testable, and consistent UI that can survive repeated AI-assisted feature development.

---

## QLi v2 Addendum — Day-Zero UI Spine

For user-facing projects, the UI Foundation must be established early enough for human review. This does not require every final screen, but it does require a usable review surface.

Minimum day-zero UI evidence:

- Application shell or layout frame.
- Navigation model or placeholder navigation.
- Design token convention.
- Reusable primitive/component convention.
- Demo/reference route or equivalent review surface.
- Empty, loading, error, disabled, and permission-denied state policy.
- Accessibility baseline: labels, focus, keyboard, semantic structure, and contrast review method.
- Stable selectors or review hooks for smoke tests when applicable.

Placeholders are allowed only when they are visibly marked, reviewable, and tracked as remaining work.

## Buildline Implementation Control

This foundation is governed operationally by `.qli/uiux/specs/ui-implementation-control.md`.

Use the full reference for doctrine and vocabulary. Use the implementation-control file for the project-agnostic minimum spine, optional capability rules, deferral rules, evidence expectations, test/smoke expectations, common AI-agent failure modes, and definition of done.

Project-specific applicability is not decided inside this reference file. It is decided through `.qli/binding/` and recorded in `.qli/project/foundation-applicability.yml`.
