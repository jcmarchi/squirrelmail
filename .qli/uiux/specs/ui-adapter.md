# UI Adapter

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `/docs/ui-adapter.md`  
**Purpose:** Map the Universal UI Foundation to this repository's actual stack and conventions.

## 1. Project UI Stack

| Field | Decision |
|---|---|
| Application name | [Project Name] |
| Rendering mode | [SPA / MPA / server-rendered / hybrid / static / embedded widget] |
| UI stack | [React / Vue / Angular / Svelte / Twig / Blade / PHP / HTMX / Alpine.js / Tailwind / vanilla JS / other] |
| Build system | [Vite / Webpack / none / framework default / other] |
| Package manager | [npm / pnpm / yarn / composer / none / other] |

## 2. Foundation Paths

| Asset | Path |
|---|---|
| Design tokens | [path] |
| Base styles | [path] |
| Components | [path] |
| Primitives | [path] |
| Patterns/layouts | [path] |
| Icons | [path] |
| JavaScript behavior | [path] |
| UI tests | [path] |
| Demo/reference page | [path or route] |
| Component inventory | `/docs/ui-component-inventory.md` |

## 3. Naming and Prefixes

| Convention | Decision |
|---|---|
| CSS class prefix | [ui- / app- / project-specific] |
| Data attribute prefix | [data-ui-* / data-app-* / project-specific] |
| Component naming | [PascalCase / kebab-case / macros / partials] |
| JavaScript namespace/module style | [ES modules / global namespace / framework store / service] |

## 4. Theme Strategy

| Field | Decision |
|---|---|
| Root theme marker | [html[data-theme] / body class / provider / server-rendered] |
| Required themes | [Light / Dark / High Contrast / Custom / Tenant] |
| Persistence | [localStorage / profile / tenant setting / cookie / server session] |
| First-paint strategy | [script / server-rendered attr / framework provider] |

## 5. Internationalization and RTL

| Field | Decision |
|---|---|
| Translation mechanism | [JSON files / server helper / framework plugin / none yet] |
| Locale storage | [profile / cookie / localStorage / server session] |
| Date/time formatting | [Intl / server helper / library] |
| Number/currency formatting | [Intl / server helper / library] |
| RTL support status | [planned / partial / implemented] |

## 6. Overlay Strategy

| Overlay type | Strategy |
|---|---|
| Dropdowns | [portal / fixed overlay root / native popover / framework service] |
| Context menus | [strategy] |
| Tooltips | [strategy] |
| Popovers | [strategy] |
| Modals/dialogs | [strategy] |
| Drawers | [strategy] |
| Toasts | [strategy] |

## 7. Test and Demo Strategy

| Area | Tool/Process |
|---|---|
| Unit tests | [tool] |
| Browser/integration tests | [tool] |
| Accessibility checks | [tool/manual] |
| Visual regression | [tool/manual] |
| Demo/reference smoke test | [route/command] |

## 8. Current Implementation Notes

- [Document important repository-specific UI decisions here.]
- [Document known constraints and accepted deviations.]
- [Document migration notes if adopting this foundation into an existing UI.]
