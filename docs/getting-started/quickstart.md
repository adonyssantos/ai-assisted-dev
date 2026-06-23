---
title: Quickstart — from fresh clone to first green feature
category: guide
difficulty: beginner
last_updated: 2026-06-22
tags: [quickstart, getting-started, sdd, tdd, tutorial]
related: ["README.md", "../framework/workflow.md", "../framework/task-tracking.md", "../board.md", "../../memory/constitution.md"]
---

# Quickstart — from fresh clone to first green feature

End-to-end walkthrough for a brand-new clone of this template: configure the repo for your project, then drive one feature through the full Spec-Driven + Test-Driven cycle until its tests go green. For the concepts behind each step, read [the SDD + TDD workflow](../framework/workflow.md).

## Prerequisites

- A fresh clone of this template, opened in Claude Code at the repo root.
- The repo root opened as an Obsidian vault if you want the visual board (see [task tracking](../framework/task-tracking.md)); plain Markdown works without it.
- `git` available, plus whatever toolchain the feature's chosen language needs (decided later, at plan time).

## Part 1 — Configure the template for your project

Do this once, before drafting any feature. Each file below is linked relative to this page (`docs/getting-started/`).

1. **State the idea.** Edit [the draft](../draft.md) — brain-dump WHAT you want to build, who it is for and why. This is the entry point the flow reads from.
2. **Set the principles.** Edit [the constitution](../../memory/constitution.md) — adapt, remove or add articles, then bump its **version**. The subagents cite principles by **stable slug** (e.g. `Constitution: tdd`), not by article number, so reordering or renumbering articles never breaks a citation; only renaming a slug does.
3. **Tune the harness.** Edit [the Claude settings](../../.claude/settings.json) — permissions, hooks and harness options for this repo.
4. **Add project rules.** Drop new agent rules under [the rules folder](../../.claude/rules/) (one concern per file). They are `@import`-ed and steer every agent.
5. **Set agent conventions.** Edit the root [AGENTS.md](../../AGENTS.md) for repo-wide stack/conventions, and add a **per-project** `AGENTS.md` under each `projects/<name>/` with that project's language, package manager and build/test/lint/run commands.

## Part 2 — Run the flow for ONE feature

Each command is a thin launcher for an expert subagent (see the table in [the workflow](../framework/workflow.md)). Run them in order for a single feature; the artifact each one produces is noted.

| # | Command | Subagent | Produces / updates |
|---|---|---|---|
| 1 | `/draft` | `sdd-drafter` | Turns [the draft](../draft.md) into candidate features (the WHAT, still tech-free). |
| 2 | `/specify` | `sdd-specifier` | Scaffolds `specs/NNN-slug/spec.md` with `FR-NN` functional requirements and acceptance criteria. |
| 3 | `/clarify` | `sdd-clarifier` | Resolves every `[NEEDS CLARIFICATION]` in the spec by asking you; no assumed business rules. |
| 4 | `/plan` | `sdd-planner` | Writes `specs/NNN-slug/plan.md` — the HOW: chosen language, design, contracts. WHAT stays in the spec. |
| 5 | `/tasks` | `sdd-tasker` | Writes one task note per task under `specs/NNN-slug/tasks/` and a one-line linking card on [the board](../board.md), tagged `#spec/NNN-slug`, as TDD pairs `FR-NN (test)` then `FR-NN (impl)`. |
| 6 | `/analyze` | `sdd-analyzer` | Cross-checks spec ↔ plan ↔ board for gaps, conflicts and untraceable items before any code. |
| 7 | `/tests` | `sdd-test-author` | Writes the failing test for each acceptance criterion under `projects/<name>/` and proves it is **red**. |
| 8 | `/implement` | `sdd-implementer` | Writes the minimum code to turn the tests **green**, then refactors while green and moves cards to Done. |

The path through the flow:

```
docs/draft.md → /draft → /specify → /clarify → /plan → /tasks → /analyze → /tests → /implement
                                                                            (red)     (green)
```

What lands where:

- **`specs/NNN-slug/`** — `spec.md` (WHAT/WHY, `FR-NN`) and `plan.md` (HOW). Scaffold a feature folder with `scripts/new-feature.sh <slug>` if you want it pre-created from the templates.
- **[the board](../board.md)** — one card per `FR-NN`, tagged `#spec/NNN-slug`, moving Backlog → In Progress → In Review → Done.
- **`projects/<name>/`** — the actual code and its tests, in the language the plan chose. Each project is self-contained with its own `AGENTS.md`.

Never weaken a test to make it pass (see [the constitution](../../memory/constitution.md), Article II). If a requirement is ambiguous, the agent flags it instead of inventing a rule.

## Where to look

- [The board](../board.md) — live task state and `FR-NN ↔ card` traceability.
- [The workflow](../framework/workflow.md) — the full cycle and the three modes (greenfield, sync, maintenance).
- [Task tracking](../framework/task-tracking.md) — card format, and swapping the board for Jira or GitHub Projects.

## Verify

- Enable the git hooks once: `git config core.hooksPath .githooks`.
- Run `scripts/validate.sh` to check the repo (frontmatter, links, structure) before you commit.
- Confirm every `FR-NN` in your spec has a matching card on the board: `bash scripts/check-traceability.sh`.
- Confirm the feature's tests run green from its project folder using the commands in that project's `AGENTS.md`.

## Related

- [Getting started index](README.md)
- [SDD + TDD workflow](../framework/workflow.md)
- [Task tracking](../framework/task-tracking.md)
