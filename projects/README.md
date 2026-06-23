---
title: projects/ — Multi-language monorepo
category: project
last_updated: 2026-06-22
tags: [monorepo, projects, polyglot]
related: ["[[workflow]]"]
---

# projects/

Code lives here. This is the **multi-language monorepo** root: each subfolder is an independent project in **any language**, fully self-contained.

## Adding a project

```
projects/
└── <name>/
    ├── AGENTS.md        # language, package manager, build/test/lint/run commands
    ├── <source>         # idiomatic layout for the chosen language
    └── <tests>          # tests using the language's standard framework (TDD: written first)
```

Rules:
- One language per project (mixing is allowed across projects, not usually within one).
- Declare the stack in `projects/<name>/AGENTS.md` — the agent reads the nearest AGENTS.md.
- Keep dependency manifests and lockfiles inside the project.
- The language is chosen during `/plan` for the feature that creates the project.
- Tests come first (TDD): `sdd-test-author` writes failing tests before `sdd-implementer` codes.
- After creating `projects/<name>/`, the AI suggests adding it to `ai-assisted-dev.code-workspace` so it becomes its own root folder in the workspace — adding `{ "path": "projects/<name>" }` to the `folders` array (suggestion only; applied with the user's OK, never edited silently).

## Examples

```
projects/api-go/        # Go service
projects/cli-rust/      # Rust CLI
projects/web/           # TypeScript frontend
projects/etl-python/    # Python data pipeline
```
