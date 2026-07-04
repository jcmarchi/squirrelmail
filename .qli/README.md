# QLi Buildline — Existing Project Adoption

**QLi Buildline** is a foundation-driven system for predictable AI-assisted software construction.

This `.qli/` package has been applied to **SquirrelMail QLi**, an existing-project Buildline adoption and legacy modernization case. This is not a new-project skeleton. The Buildline overlay provides governance, discovery tooling, adoption workflow, and foundation reference controls for an already-existing PHP webmail application.

Project-specific binding and adoption files (`.qli/project/`, `.qli/binding/`) govern applicability. The Foundation reference layer (`.qli/acd/`, `.qli/devbox/`, etc.) provides doctrine but does not decide project applicability by itself.

## Layer Model

```text
QLi Buildline        = whole system
QLi Foundations      = generic doctrine/reference layer
QLi Binding          = deterministic project applicability layer
QLi Spine            = required upfront implementation baseline
QLi Workflows        = adoption/implementation procedures
QLi Gates            = completion controls
QLi Evidence         = proof trail
QLi Skills           = optional bounded execution modules
QLi Doctor           = audit/diagnostic tooling
```

## Canonical Folder Model

```text
project-root/
├── AGENTS.md                    # project-specific AI operating guide
├── QLI.md                       # Buildline governance contract
├── .qli/
│   ├── buildline.yml            # Buildline identity and layer map
│   ├── README.md                # this file
│   ├── foundation-map.yml       # canonical path and trigger map
│   ├── adoption/                # existing-project adoption workflow
│   ├── agents/                  # AGENTS.md integration blocks
│   ├── binding/                 # project classifier, profile schema, applicability rules
│   ├── project/                 # project-specific state, decisions, applicability, status
│   ├── spine/                   # upfront Foundation Spine doctrine
│   ├── workflows/               # adoption/implementation procedures
│   ├── gates/                   # acceptance gates and evidence requirements
│   ├── evidence/                # evidence templates
│   ├── skills/                  # optional bounded skills
│   ├── tools/                   # doctor/audit scripts
│   └── [foundation folders]     # ACD, UIUX, DATA, API, ACL, Security, Testing, Runtime, OAT, Delivery, DevBox
└── docs/                        # human-facing product docs, ADRs, runbooks
```

## Required Project State Files

Every existing-project adoption should maintain:

```text
.qli/project/manifest.yml
.qli/project/operating-profile.yml
.qli/project/foundation-target.yml
.qli/project/foundation-applicability.yml
.qli/project/foundation-status.yml
.qli/project/current-slice.yml
.qli/project/context-packet.yml
.qli/project/buildline-plan.md
.qli/project/adoption-intake.md
.qli/project/behavior-snapshot.md
.qli/project/risk-map.md
.qli/project/evidence-log.md
.qli/project/deferral-register.md
.qli/project/prompt-log.md
```

## Existing-Project Adoption

This repository is an existing-project adoption case. The Buildline overlay was applied after DevBox runtime integration (PR #1). Adoption proceeds through:

1. Read-only discovery and behavior snapshot
2. Risk mapping
3. Foundation applicability determination
4. Staged adoption plan with gates
5. Vertical slice execution governed by Buildline workflows

Project-specific binding files (`.qli/binding/`) and adoption workflow (`.qli/adoption/`) govern the process.
