---
title: SDD + TDD Workflow
category: guide
difficulty: beginner
last_updated: 2026-06-22
tags: [workflow, sdd, tdd, subagents]
related: ["[[constitution]]", "[[task-tracking]]", "[[board]]", "[[documentation]]"]
---

# Spec-Driven + Test-Driven workflow

Detailed guide to this repo's cycle. Work is **spec-driven** (code derives from specs) and **test-driven** (tests are written before the code that satisfies them).

## How it runs: expert subagents

Each step is owned by an expert subagent in `.claude/agents/`; the slash commands are thin launchers that delegate to them. The main agent can also auto-invoke a subagent by matching its description.

| Step | Subagent | Command |
|---|---|---|
| Discover | `sdd-drafter` | `/draft` |
| Specify | `sdd-specifier` | `/specify` |
| Clarify | `sdd-clarifier` | `/clarify` |
| Plan | `sdd-planner` | `/plan` |
| Tasks | `sdd-tasker` | `/tasks` |
| Analyze | `sdd-analyzer` | `/analyze` |
| Test (red) | `sdd-test-author` | `/tests` |
| Implement (green) | `sdd-implementer` | `/implement` |
| Sync | `sdd-syncer` | `/sync` |

```
docs/draft.md → /draft → /specify → /clarify → /plan → /tasks → /analyze → /tests → /implement
                                                                       (red)     (green)
```

## Three modes of operation

### Mode 1 — Greenfield (empty → all specs)
Idea in `docs/draft.md`, `specs/` empty. `/draft` → per feature: `/specify` → `/clarify` → `/plan` → `/tasks` → `/analyze` → `/tests` → `/implement`.

### Mode 2 — Sync (updated draft → reconcile specs)
`docs/draft.md` edited, specs exist. `/sync` diffs draft vs specs → **NEW** (create), **CHANGED** (update), **UNCHANGED** (skip), **REMOVED** (mark obsolete or, with explicit confirmation, delete). Then `/clarify` → `/tasks` → `/tests` → `/implement` for the deltas. `FR-XX` ids stay stable so board cards survive.

### Mode 3 — Maintenance (mature product)
`docs/draft.md` is a stable north-star. New feature → `/specify <feature>` → … . Bug/support → write a **failing regression test first**, fix under `projects/`, ADR if architectural. Keep [[board]] and specs living.

## TDD loop (per requirement)

1. `sdd-test-author` writes a failing test for the acceptance criterion and proves it is **red**.
2. `sdd-implementer` writes the minimum code to make it **green**.
3. Refactor while green. Move the card to Done on [[board]].

Never weaken a test to pass it (see [[constitution]] Article II).

## Golden rules

| Rule | Why |
|---|---|
| Spec before code | Avoids "let's code and see". |
| Tests before code | Behavior is pinned by an executable contract. |
| WHAT separate from HOW | Keeps the spec stable when technology changes. |
| Language-agnostic | The right language per feature, not a default habit. |
| Traceability FR-XX ↔ card | Nothing built more or less than the spec. |
| Flag, don't assume | The agent must not invent business rules. |
| Constitution wins | Hard limit on any decision. |
| Never delete without confirmation | Mode 2 REMOVED requires explicit user approval. |
