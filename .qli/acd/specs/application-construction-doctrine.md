# Application Construction Doctrine

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


**Intended location:** `.qli/application-construction-doctrine.md`  
**Audience:** AI Coding Agents, human architects, implementation reviewers  
**Purpose:** Define the mandatory way applications are planned, structured, kicked off, continued, and refactored.

---

## 1. Mandatory Principle

Every serious application must be built as an integrated product system, not as disconnected backend, database, API, and UI fragments.

At minimum, every application architecture must include:

1. **Application Core / Domain Logic** — the business behavior, use cases, workflows, commands, decisions, domain events, lifecycle rules, and invariants.
2. **Data Foundation** — entities, records of truth, datasets, schema contracts, storage decisions, migrations, lifecycle, tenancy, and persistence adapters.
3. **API / Interface Foundation** — OpenAPI, AsyncAPI, internal interfaces, event contracts, webhooks, request/response schemas, gateway behavior, and integration boundaries.
4. **UI Foundation** — complete UI foundation, reusable components, screens, workflows, accessibility, responsive behavior, and human-testable feature surfaces.

Access Control and Security join this minimum whenever the project has users, permissions, admin surfaces, public exposure, tenant boundaries, billing, files, integrations, API tokens, service accounts, or any externally reachable demo or deployment.

---

## 2. Product-to-Architecture-to-Code Sequence

AI Coding Agents must not jump directly from a vague product idea into implementation. The required sequence is:

1. **Brainstorm the product.** Clarify the problem, users, workflows, expected outcomes, and business model.
2. **Dissect the product into features.** Identify modules, workflows, screens, data entities, external interfaces, and operational behaviors.
3. **Research the market and competition when requested or required.** Capture competitor features, positioning, UX expectations, and gaps.
4. **Cross-reference differentiation and business value.** Define what the product can do better, faster, cheaper, safer, or more usefully than alternatives.
5. **Move from business proposition into product architecture.** Translate value into features, domain modules, user journeys, data needs, APIs, UI screens, and access rules.
6. **Discuss and select the tech stack.** Stack decisions must follow business/product/architecture needs, not agent preference.
7. **Review and adapt the codebase skeleton.** Adjust folders, docs, foundation files, tests, and project conventions before broad implementation.
8. **Set up the repository and working documents.** Load `AGENTS.md`, foundation references, adapters, inventories, roadmaps, ADRs, and setup instructions.
9. **Build the UI foundation early.** UI is not secondary; the human architect must be able to inspect real screens and workflows.
10. **Deliver vertical slices.** Features should move across Core + Data + API + Test + UI, with ACL/Security when applicable.

---

## 3. New Project Doctrine

For a new project, the AI Coding Agent must:

1. Establish product understanding before coding.
2. Identify the initial feature map and vertical-slice candidates.
3. Propose the minimum viable architecture across Core, Data, API, UI, and ACL/Security where applicable.
4. Create or adapt foundation references and project adapters under `.qli/`.
5. Create or adapt inventories for modules, entities, APIs, UI components, permissions, routes, tests, and workflows.
6. Establish the UI foundation early, including reusable components and demo/reference surfaces.
7. Implement the first feature as a reviewable vertical slice, not as invisible backend-only scaffolding.

---

## 4. Existing / Refactoring Project Doctrine

For an existing project, the AI Coding Agent must:

1. Inspect the current architecture before proposing changes.
2. Preserve valid working behavior unless the task explicitly authorizes replacement.
3. Map existing code to the foundation model before refactoring.
4. Identify scattered business logic in controllers, routes, templates, UI handlers, database models, jobs, and helpers.
5. Move logic toward the correct layer incrementally: Core for business behavior, Data for persistence, API for boundaries, UI for presentation, ACL for authorization.
6. Avoid “big bang” rewrites unless explicitly approved.
7. Add tests around existing behavior before material refactors where feasible.
8. Update inventories, adapters, review checklists, and technical debt notes.

---

## 5. Vertical Slice Completion Rule

A feature is not complete merely because code compiles or a route exists.

A feature should be considered architecturally complete only when the applicable parts are present:

| Layer | Expected completion evidence |
|---|---|
| Core | Use case, command/query, workflow, domain rule, or application service implemented in the correct layer. |
| Data | Entity/storage decision, migration/schema, repository/adapter, lifecycle and compatibility considered. |
| API | Contract, endpoint, event, webhook, or internal interface updated when applicable. |
| UI | Screen/component/workflow available for human review when the feature is user-facing. |
| ACL/Security | Permissions, policies, scopes, route classification, and security controls when applicable. |
| Test | Unit, integration, contract, UI smoke, data, and negative tests where relevant. |
| Observability | Logs/events/errors/request IDs or diagnostic signals when the feature affects runtime behavior. |

---

## 6. AI Coding Agent Non-Negotiables

AI Coding Agents must not:

- Treat UI as an afterthought.
- Build backend-only features when a user-facing workflow is required.
- Place business logic in controllers, templates, migrations, UI handlers, or database models when a domain/use-case layer exists or should exist.
- Invent one-off architecture that bypasses project foundations.
- Pick a stack before product, feature, and architecture needs are understood.
- Replace valid existing code without a migration/refactoring rationale.
- Create untestable scaffolding and call it complete.
- Ignore ACL/security when a feature is exposed, privileged, multi-user, tenant-aware, public, or admin-facing.

---

## 7. Required Delivery Report Addendum

Every substantial implementation pass should report:

```text
Application Construction:
- Product/Feature Context: [what feature/business value this supports]
- Vertical Slice Status: [Core/Data/API/UI/Test/ACL/Security complete or deferred]
- Human-Review Surface: [screen, endpoint, CLI, API call, demo, or test]
- Foundation Files Updated: [yes/no/list]
- Deferred Architectural Risks: [known gaps]
```

---

## QLi v2 Addendum — Foundation Spine and Slice Governance

The application construction doctrine is governed through `.qli/project/` state files. The agent must not treat the Foundation as a monolithic implementation project.

### Foundation Spine Rule

Before broad feature development, establish a minimum operational spine across the applicable foundations. The spine must make the project buildable, reviewable, testable, and extensible without creating one-off architecture.

Minimum spine evidence:

- Product profile and target level selected.
- UI shell or human-review surface when user-facing.
- Core/use-case boundary established.
- DATA classification and persistence convention established.
- API/interface pattern established when applicable.
- ACL policy/guard spine established when applicable.
- Security baseline established according to operating profile.
- Testing adapter and smoke path established.
- Runtime/delivery start and configuration model established.
- Observability baseline established where applicable.

### Product Slice Rule

After the spine, work must proceed by bounded product slices. A slice is not complete until `.qli/project/foundation-status.yml` and `.qli/project/evidence-log.md` are updated.

## Buildline Implementation Control

This foundation is governed operationally by `.qli/acd/specs/acd-implementation-control.md`.

Use the full reference for doctrine and vocabulary. Use the implementation-control file for the project-agnostic minimum spine, optional capability rules, deferral rules, evidence expectations, test/smoke expectations, common AI-agent failure modes, and definition of done.

Project-specific applicability is not decided inside this reference file. It is decided through `.qli/binding/` and recorded in `.qli/project/foundation-applicability.yml`.
