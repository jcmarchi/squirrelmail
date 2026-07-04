# AI Coding Agent Prompt — Testing / Quality Foundation for Existing / Refactoring Projects

> **QLi v2 path notice:** Canonical Foundation source files live under `.qli/`. Any older legacy docs/specs path in this file is a legacy reference and should be resolved through `.qli/foundation-map.yml`. Do not create duplicate `.qli` Foundation files unless explicitly requested.


You are applying the Testing / Quality Foundation to an existing project.

Before changing implementation, inspect the current repository:

1. Read `AGENTS.md`.
2. Read `.qli/application-construction-doctrine.md` if present.
3. Read `.qli/testing-foundation-reference.md` if present.
4. Inspect existing tests, scripts, CI files, fixtures, docs, smoke paths, and known defects.
5. Inspect the feature or module being refactored before proposing changes.

Your mission is to improve quality without breaking valid existing behavior.

Required procedure:

1. Create or update `.qli/testing-adapter.md`.
2. Create or update the test inventory and coverage matrix.
3. Identify untested critical paths.
4. Add characterization tests before refactoring fragile or poorly understood behavior.
5. Add regression tests for fixed bugs when feasible.
6. Preserve behavior unless an intentional migration is documented.
7. Convert repeated manual checks into automated tests where practical.
8. Update smoke checklist and manual QA steps.

Rules:

- Do not replace a working test strategy merely because you prefer another tool.
- Do not introduce a new testing framework unless the reason and impact are documented.
- Do not delete tests unless they are obsolete and replacement coverage exists.
- Do not claim refactoring is safe without either automated or documented manual validation.
- End with a report listing tests run, tests added, characterization coverage, behavior preserved, and deferred risks.
