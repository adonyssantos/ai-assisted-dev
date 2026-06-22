---
title: ai-assisted-dev — SDD + TDD template
category: overview
last_updated: 2026-06-22
tags: [sdd, tdd, monorepo, claude-code, obsidian]
related: ["[[workflow]]", "[[constitution]]", "[[task-tracking]]", "[[documentation]]"]
---

# ai-assisted-dev — Spec-Driven Development template (Claude Code)

A **language-agnostic, multi-language monorepo** template for building software with AI using
**Spec-Driven Development (SDD)** and **Test-Driven Development (TDD)**. Code is derived from an
explicit **specification**, and **tests are written before the code** that satisfies them. The spec
is the source of truth; expert subagents execute each step traceably.

Everything lives in one repo — the idea, the specs, the task board, the docs, and the code for every
project, in any language. The repository root is an **Obsidian vault**: open it in Obsidian to browse
all docs and the Kanban board with working wikilinks.

## Subagent-driven flow

Each SDD step is owned by an **expert subagent** in `.claude/agents/`. Slash commands are thin
launchers that delegate to them; the main agent may also auto-invoke a subagent by description.

```
docs/draft.md → /draft → /specify → /clarify → /plan → /tasks → /analyze → /tests → /implement
                                                                       (red)     (green)
```

| Step | Subagent | Command | Produces |
|---|---|---|---|
| Discover | `sdd-drafter` | `/draft` | candidate features from `docs/draft.md` |
| Specify | `sdd-specifier` | `/specify` | `specs/NNN-slug/spec.md` (WHAT + WHY, no tech) |
| Clarify | `sdd-clarifier` | `/clarify` | clarifying questions → updated spec |
| Plan | `sdd-planner` | `/plan` | `plan.md`, `research.md`, `data-model.md`, `contracts/` (language chosen) |
| Tasks | `sdd-tasker` | `/tasks` | test-first cards on `docs/board.md` |
| Analyze | `sdd-analyzer` | `/analyze` | coherence report |
| Test (red) | `sdd-test-author` | `/tests` | failing tests from acceptance criteria |
| Implement (green) | `sdd-implementer` | `/implement` | code in `projects/` until tests pass |
| Sync | `sdd-syncer` | `/sync` | reconcile `specs/` with an updated `docs/draft.md` |

## Modes of operation

The same artifacts and subagents serve three ways of working — only the entry point changes.

### Mode 1 — Greenfield: from an empty `docs/draft.md` to all specs
1. Fill `docs/draft.md` with the product idea.
2. `/draft` → candidate features + build order.
3. Per feature: `/specify` → `/clarify` → `/plan` → `/tasks` → `/analyze` → `/tests` → `/implement`.

### Mode 2 — Sync: from an updated `docs/draft.md`, reconcile existing specs
1. Edit `docs/draft.md`.
2. `/sync` → reconciliation report: **NEW** (create), **CHANGED** (update), **UNCHANGED** (skip),
   **REMOVED** (mark obsolete, or delete **only with explicit confirmation**).
3. `/clarify` updated specs → `/tasks` → `/tests` → `/implement` for the deltas.
   `FR-XX` ids stay stable so traceability and board cards survive.

### Mode 3 — Maintenance: a mature product
`docs/draft.md` is a stable north-star, not the daily driver.
- **New feature:** `/specify <feature>` → … → `/tests` → `/implement`.
- **Bug fix / support:** write a **failing regression test first**, fix under `projects/<name>/`,
  add an ADR in `docs/adr/` if architectural.
- **Keep records living:** update the affected `spec.md` when behavior changes.

## Layout

```
.
├── CLAUDE.md                 # Project instructions for Claude Code (always loaded)
├── AGENTS.md                 # Monorepo + multi-language conventions
├── memory/constitution.md    # Non-negotiable principles (incl. TDD)
├── specs/NNN-slug/           # One folder per feature: spec, plan, research, data-model, contracts
├── templates/                # Skeletons (carry frontmatter) used by the subagents
├── .claude/
│   ├── commands/             # Thin launchers: draft, specify, clarify, plan, tasks, analyze,
│   │                         #   tests, implement, sync
│   ├── agents/               # Expert subagents (sdd-*, incl. sdd-spec-reviewer)
│   ├── rules/documentation.md# Documentation rule (frontmatter + wikilinks)
│   └── settings.json         # Shared repo config (.env.example readable, real .env denied)
├── docs/                     # Vault content (Obsidian)
│   ├── draft.md              # ENTRY POINT — your raw app idea (brain dump)
│   ├── board.md              # Kanban board (all tasks)
│   ├── workflow.md           # SDD + TDD flow
│   ├── task-tracking.md      # Board / Jira / GitHub Projects
│   └── adr/                  # Architecture Decision Records
├── projects/                 # Multi-language code — one self-contained project per subfolder
└── scripts/new-feature.sh    # Scaffolds specs/NNN-slug/ from templates
```

## Task tracking

Default tracker: an **Obsidian Kanban board** at `docs/board.md` (see [[board]]). Install the
*Kanban* community plugin and open the repo as a vault. The tracker is swappable — see
[[task-tracking]] for **Jira** or **GitHub Projects** via MCP/CLI.

## Documentation

All documentation follows [[documentation]]: YAML frontmatter on every doc, wikilinks for
cross-references, one Obsidian vault at the repo root. Operational files (`CLAUDE.md`, `AGENTS.md`,
`.claude/**`) are exempt and keep their functional format.

## Getting started

```bash
$EDITOR docs/draft.md                 # capture the idea
$EDITOR memory/constitution.md   # set the principles
# then in Claude Code (Mode 1):
/draft → /specify → /clarify → /plan → /tasks → /analyze → /tests → /implement
# scaffold a feature folder by hand (optional):
./scripts/new-feature.sh my-feature
```

## Principles

1. **The spec rules.** Code contradicts spec → spec wins (or is updated explicitly).
2. **Tests first (TDD).** Failing test before code; never weaken a test to pass it.
3. **Separate WHAT from HOW.** `spec.md` never names technology; `plan.md` does.
4. **Technology-agnostic.** Any language; the language is a plan-time decision.
5. **Traceability.** Every task references a spec requirement (`FR-XX`).
