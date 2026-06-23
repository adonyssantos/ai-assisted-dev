# CLAUDE.md

Project instructions for Claude Code. Loaded every session.

## What this repo is

A **language-agnostic, multi-language monorepo** built with **Spec-Driven Development (SDD)** and **Test-Driven Development (TDD)**. Code is derived from specs in `specs/`; tests are written before the code that satisfies them. The spec is the source of truth. Every project — in any language — lives under `projects/`.

@memory/constitution.md
@AGENTS.md
@.claude/rules/documentation.md

## How we work: subagents, not monolithic commands

Each SDD step is owned by an **expert subagent** in `.claude/agents/`. The slash commands are thin launchers that delegate to them; the main agent may also auto-invoke a subagent directly by matching its description. Prefer delegating each step to its expert.

| Step | Subagent | Command | Role |
|---|---|---|---|
| Discover | `sdd-drafter` | `/draft` | Break `docs/draft.md` into candidate features (READ-ONLY). |
| Specify | `sdd-specifier` | `/specify` | Write the spec — WHAT + WHY, no tech. |
| Clarify | `sdd-clarifier` | `/clarify` | Surface clarifying questions (main agent asks the user). |
| Plan | `sdd-planner` | `/plan` | Technical design; **choose the language**. |
| Tasks | `sdd-tasker` | `/tasks` | Test-first cards onto `docs/board.md`. |
| Analyze | `sdd-analyzer` | `/analyze` | Coherence audit (READ-ONLY). |
| Test (red) | `sdd-test-author` | `/tests` | Write FAILING tests from acceptance criteria. |
| Implement (green) | `sdd-implementer` | `/implement` | Make tests pass, then refactor. |
| Sync | `sdd-syncer` | `/sync` | Reconcile `specs/` with an updated `docs/draft.md`. |
| Review | `sdd-spec-reviewer` | — | Critical spec review (READ-ONLY). |

## Flow

```
docs/draft.md → /draft → /specify → /clarify → /plan → /tasks → /analyze → /tests → /implement
                                                                       (red)     (green)
```

## Three modes of operation

| Mode | When | Path |
|---|---|---|
| 1 — Greenfield | Empty `specs/`, idea in `docs/draft.md` | `/draft` → per feature: `/specify` → `/clarify` → `/plan` → `/tasks` → `/analyze` → `/tests` → `/implement` |
| 2 — Sync | `docs/draft.md` edited, specs exist | `/sync` (NEW/CHANGED/REMOVED) → `/clarify` → `/tasks` → `/tests` → `/implement` |
| 3 — Maintenance | Mature product | New feature: `/specify <feature>` → … ; bug/support: failing regression test first → fix → ADR |

In Mode 3, `docs/draft.md` is a stable north-star, not the daily driver. Never delete a spec without explicit confirmation (Mode 2 REMOVED).

## Rules

| Rule | Detail |
|---|---|
| Spec first | NEVER write code without an approved `specs/NNN-slug/spec.md`. |
| Tests first (TDD) | Write failing tests before implementation. Implement only to make them pass. Never weaken a test to pass it. |
| WHAT/HOW split | `spec.md` is technology-free. `plan.md` names the stack. Do not mix. |
| Language-agnostic | Do not assume JS/TS. Language is decided per feature in `/plan` and per project in `projects/<name>/AGENTS.md`. |
| Traceability | Every board card references a requirement (`FR-XX`) and its spec id. |
| Flag, don't assume | Mark every ambiguity `[NEEDS CLARIFICATION: ...]`; never invent business rules. |
| Constitution wins | If a decision contradicts `memory/constitution.md`, stop and ask. |
| Documentation rule | Every documentation `.md` follows `.claude/rules/documentation.md` (frontmatter + wikilinks). |
| Tasks → board | All tasks live in `docs/board.md` (Obsidian Kanban). See `docs/task-tracking.md` for Jira / GitHub Projects alternatives. |

## File conventions

- Features: `specs/NNN-slug/` (NNN = 3-digit sequential).
- Code: `projects/<name>/` — self-contained, any language, own toolchain + optional `AGENTS.md`.
- New `projects/<name>/` → the AI suggests adding it (`{ "path": "projects/<name>" }`) to `ai-assisted-dev.code-workspace` (suggestion only; applied with the user's OK).
- Base skeletons live in `templates/`.
- The repository root is an **Obsidian vault**; documentation uses YAML frontmatter and wikilinks.
