# AGENTS.md — Monorepo & multi-language conventions

Read by Claude Code (and other agents) during `/plan` and `/implement`. This repo is a **language-agnostic monorepo**: it does not assume any single language.

## Monorepo model

- Every project lives under `projects/<name>/` and is **self-contained**: its own source, tests, dependency manifest and toolchain.
- A project may be written in **any language** (Go, Python, Rust, Java, TypeScript, C#, …).
- Each project SHOULD declare its own stack in `projects/<name>/AGENTS.md`. The agent reads the **nearest** AGENTS.md: this root file for monorepo-wide rules, the project one for its stack.
- No shared build tool is imposed. A polyglot task runner (e.g. `just`, `make`, `task`) at the repo root is optional; if present, document its targets here.
- New project under `projects/<name>/` → suggest adding `{ "path": "projects/<name>" }` to `ai-assisted-dev.code-workspace` (suggestion only; apply with user OK).

## Per-project manifest (`projects/<name>/AGENTS.md`)

Each project should answer:

| Field | Example |
|---|---|
| Language / runtime | Go 1.22 / Python 3.12 / Rust 1.78 / Node 20 |
| Package manager | go mod / uv / cargo / pnpm / maven |
| Build | `<command>` |
| Test | `<command>` |
| Lint / format | `<command>` |
| Run | `<command>` |

## Cross-language conventions

| Topic | Rule |
|---|---|
| Naming | Follow the **idiomatic** convention of each language (snake_case in Python/Rust, camelCase in JS, PascalCase exports in Go, …). Do not impose one style across languages. |
| Layout | Feature-first inside each project unless the language ecosystem dictates otherwise. |
| Tests | Live with the project they cover, using that language's standard test framework. |
| Style | Whatever the project's formatter enforces (gofmt, black/ruff, rustfmt, prettier, …). |
| Secrets | Never commit secrets. Use `.env` (git-ignored) or the project's secret mechanism. |
| Language idioms | Write new code like the surrounding code: same style, naming and idioms. |

## Choosing a language

The language is a **plan-time decision** (`/plan`), recorded in the feature's `plan.md` and, when a new project is created, in its `projects/<name>/AGENTS.md`. The spec (`spec.md`) stays tech-free.
