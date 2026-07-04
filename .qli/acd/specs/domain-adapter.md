# Domain Adapter — [Project Name]

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/domain-adapter.md`  
**Purpose:** Map the Universal Application Core / Domain Foundation to this repository's actual stack, folder structure, naming conventions, and implementation style.

---

## 1. Project Context

| Field | Value |
|---|---|
| Product | [Project Name] |
| Primary domain | [Business/problem domain] |
| Current lifecycle | New / Existing / Refactor / Migration |
| Core stack | [PHP / Go / Python / Java / C# / etc.] |
| UI stack | [plain HTML / Twig / React / Vue / etc.] |
| API style | [REST / events / hybrid / internal only] |
| Data style | [SQL / document / file-based / hybrid / TBD] |
| ACL maturity | [none/basic/scoped/full] |

---

## 2. Domain Folder Mapping

| Foundation concept | Repository location | Notes |
|---|---|---|
| Domain modules | `[path]` | |
| Use cases/application services | `[path]` | |
| Commands | `[path]` | |
| Queries | `[path]` | |
| Domain entities/value objects | `[path]` | |
| Domain policies/specifications | `[path]` | |
| Domain events | `[path]` | |
| Ports/interfaces | `[path]` | |
| Adapters | `[path]` | |
| Tests | `[path]` | |

---

## 3. Naming Conventions

| Object | Convention | Example |
|---|---|---|
| Module | `[convention]` | `Billing`, `Content`, `Projects` |
| Use case | Verb + noun | `CreateProject`, `ApproveInvoice` |
| Command | UseCase + `Command` | `CreateProjectCommand` |
| Query | UseCase + `Query` | `GetProjectDashboardQuery` |
| Result | UseCase + `Result` | `CreateProjectResult` |
| Event | Past tense fact | `ProjectCreated` |
| Policy | Decision phrase | `CanApproveInvoice` |
| Port | Capability + `Port` | `ProjectRepositoryPort` |
| Adapter | Technology + capability | `SqlProjectRepository` |

---

## 4. Dependency Rules for This Repository

- [Document acceptable dependencies inside core]
- [Document forbidden dependencies inside core]
- [Document any intentional compromises, such as Active Record usage]
- [Document how compromises are contained]

---

## 5. Vertical Slice Standard

For each feature, implement or update the applicable pieces:

| Layer | Required path/evidence |
|---|---|
| Core | [Use case/module path] |
| Data | [Entity/migration/repository path] |
| API | [OpenAPI/AsyncAPI/route path] |
| UI | [screen/component/demo path] |
| ACL | [permissions/policy path] |
| Test | [test path] |

---

## 6. Refactoring Notes

| Existing pattern | Target pattern | Migration approach |
|---|---|---|
| [controller logic] | [use case] | [incremental extraction] |
| [model logic] | [domain policy] | [test first] |

---

## 7. Open Decisions

| Decision | Options | Owner | Status |
|---|---|---|---|
| [Decision] | [Options] | [Owner] | Open |
