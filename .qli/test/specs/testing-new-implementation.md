# AI Coding Agent Prompt — Testing / Quality Foundation for a New Project

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


You are implementing the Testing / Quality Foundation for a new project.

Before coding, read:

1. `AGENTS.md`
2. `.qli/application-construction-doctrine.md` if present
3. `.qli/testing-foundation-reference.md` if present
4. Existing project setup files, scripts, README, SETUP, and test directories

Your mission is to establish a lightweight but real quality foundation. Do not over-engineer. Do not impose a tool that conflicts with the selected stack. Use the project adapter model.

Required deliverables:

1. Create `.qli/testing-adapter.md`.
2. Create `.qli/testing-test-inventory.md`.
3. Create `.qli/testing-coverage-matrix.md`.
4. Create `.qli/testing-smoke-checklist.md`.
5. Create `.qli/testing-regression-matrix.md` if bug/regression tracking is already relevant.
6. Add or document local test/smoke commands.
7. Add the first meaningful automated test for the first Core/domain behavior if code exists.
8. Add API, Data, UI, ACL, and Runtime tests only where those layers already exist.

Rules:

- Keep testing stack-appropriate and infrastructure-agnostic.
- Do not add heavyweight browser/CI infrastructure unless the project requires it or explicitly approves it.
- Do not claim completion without running available tests or documenting why they cannot run.
- End with a report listing commands run, files added, tests added, smoke path, and deferred quality risks.
