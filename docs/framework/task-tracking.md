---
title: Task Tracking
category: guide
difficulty: intermediate
last_updated: 2026-06-22
tags: [tasks, kanban, jira, github-projects]
related: ["../board.md", "workflow.md"]
---

# Task tracking

Tasks are decoupled from the rest of the flow so the tracker is **swappable**. `sdd-tasker` and `sdd-implementer` write to whichever tracker is active.

## Default — Obsidian Kanban ([board](../board.md))

The board holds **thin cards**; the full detail of each task lives in a **task note**. This keeps the board renderable and the detail version-controlled with its feature. The exact, never-break rules are in [board rule](../../.claude/rules/board.md).

- **Board file:** a single markdown file in the Obsidian *Kanban* plugin format (`docs/board.md`).
- **Lanes:** `Backlog → In Progress → In Review → Done` (the four defaults are fixed; add extra lanes after `Done`).
- **Task note:** one note per task at `specs/NNN-slug/tasks/FR-XX-(test|impl).md`, created from [task-template](../../templates/task-template.md) — requirement, acceptance criterion, Definition of Done, dependencies, `status`.
- **Card format (one line, links to the note):** `- [ ] [FR-XX (test|impl) — <short title>](../specs/NNN-slug/tasks/FR-XX-(test|impl).md) #spec/NNN-slug`. TDD pairs: the `(test)` card before the `(impl)` card.
- **Tags** (`#spec/NNN-slug`) and the `FR-XX` id sit on the card line so [check-traceability](../../scripts/check-traceability.sh) can verify every requirement has a card.
- **Moving a task:** cut the whole card line and paste it under the target lane; flip `[ ]`↔`[x]` only for `Done`; sync the note's `status`. Never edit the `%% kanban:settings %%` block.

Enable the board view: open the **repo root** as an Obsidian vault. The *Kanban* plugin is already **pre-enabled** in `.obsidian/community-plugins.json`, but its binary is not bundled (third-party code), so the first time Obsidian will prompt you to install it — Settings → Community plugins → Browse → **Kanban** → Install. After that one-time install, [board](../board.md) renders as a board everywhere.

### Don't want the board?

It ships enabled, but it is optional. To drop it: delete `docs/board.md` and the `.obsidian/` folder, then pick **Jira** or **GitHub Projects** below. The task notes under `specs/NNN-slug/tasks/` are tracker-independent and stay useful either way.

## Alternative — Jira

- **CLI:** `acli jira workitem create ...` (Atlassian CLI).
- **MCP:** an Atlassian/Jira MCP server exposing issue-creation tools.
- Map: lane → status, card → issue, `#spec/NNN-slug` → label or epic link, FR-XX → summary/label.

## Alternative — GitHub Projects

- **CLI:** `gh project item-create ...` / `gh issue create ...`.
- **MCP:** a GitHub MCP server.
- Map: lane → project column/status, card → issue/draft, `#spec/NNN-slug` → label, FR-XX → title.

## Switching trackers

1. Pick the tracker and ensure its CLI/MCP is configured.
2. Tell the agent which tracker is active (the subagents honor this file).
3. Keep the `FR-XX` + `NNN-slug` references regardless of tracker — that preserves traceability.
