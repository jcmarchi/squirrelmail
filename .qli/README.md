# QLi Buildline — New-Project Universal Skeleton

**QLi Buildline** is a foundation-driven system for predictable AI-assisted software construction.

This `.qli/` package is embedded in the Universal Project Skeleton for **new projects only**.

The intended process is not a runtime questionnaire. The project owner and AI Co-Architect first complete product discovery, architecture, documentation, and scope. Then the AI Co-Architect customizes this skeleton into a project-specific Buildline-ready repository package.

## Layer Model

```text
QLi Buildline        = whole system
QLi Foundations      = generic doctrine/reference layer
QLi Binding          = deterministic project applicability layer
QLi Spine            = required upfront implementation baseline
QLi Workflows        = new-project implementation procedures
QLi Gates            = completion controls
QLi Evidence         = proof trail
QLi Skills           = optional bounded execution modules
QLi Doctor           = audit/diagnostic tooling
```

## Canonical Folder Model

```text
project-root/
├── AGENTS.md                    # project-specific AI operating guide; protected, not blindly replaced
├── QLI.md                       # Buildline governance contract
├── SKILLS.md                    # optional skills index pointer
├── .qli/
│   ├── buildline.yml            # Buildline identity and layer map
│   ├── README.md                # this file
│   ├── foundation-map.yml       # canonical path and trigger map
│   ├── agents/                  # AGENTS.md integration blocks and generation rules
│   ├── binding/                 # project classifier, profile schema, applicability and deferral rules
│   ├── project/                 # project-specific state, decisions, applicability, status, evidence
│   ├── spine/                   # upfront Foundation Spine doctrine/checklist
│   ├── workflows/               # new-project implementation workflows
│   ├── gates/                   # acceptance gates and evidence requirements
│   ├── evidence/                # evidence templates
│   ├── skills/                  # optional bounded skills
│   ├── tools/                   # doctor/audit scripts
│   ├── handoff/                 # AI Co-Architect handoff guidance
│   └── [foundation folders]     # ACD, UIUX, DATA, API, ACL, Runtime, Testing, Observability, Delivery, Security, DevBox
└── docs/                        # human-facing product docs, ADRs, runbooks, roadmap notes
```

## Required Project State Files

Every generated project should maintain:

```text
.qli/project/manifest.yml
.qli/project/operating-profile.yml
.qli/project/foundation-target.yml
.qli/project/foundation-applicability.yml
.qli/project/foundation-status.yml
.qli/project/current-slice.yml
.qli/project/context-packet.yml
.qli/project/buildline-plan.md
.qli/project/evidence-log.md
.qli/project/deferral-register.md
.qli/project/prompt-log.md
```

## Existing-Project Adoption

Existing-project adoption is deliberately not part of this active skeleton. That process requires separate intake, behavior snapshots, risk mapping, and migration controls. Use a dedicated adoption package/workflow for that case.
