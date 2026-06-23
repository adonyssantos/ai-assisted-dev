---
title: Task Tracking
category: guide
difficulty: intermediate
last_updated: 2026-06-22
tags: [tasks, kanban, jira, github-projects]
related: ["[[board]]", "[[workflow]]"]
---

# Task tracking

Tasks are decoupled from the rest of the flow so the tracker is **swappable**. `sdd-tasker` and `sdd-implementer` write to whichever tracker is active.

## Default — Obsidian Kanban ([[board]])

- Single markdown file in the Obsidian *Kanban* plugin format (`docs/board.md`).
- Lanes: `Backlog → In Progress → In Review → Done` (rename/add as you like).
- Card format: `- [ ] FR-XX — <task> #spec/NNN-slug`. TDD pairs: `FR-01 (test)` then `FR-01 (impl)`.
- Tags (`#spec/NNN-slug`) tie each card to its spec for traceability.
- Editable as plain markdown by the agent **and** as a visual board in Obsidian.

Enable the board view: open the **repo root** as an Obsidian vault. The *Kanban* plugin is already **pre-enabled** in `.obsidian/community-plugins.json`, but its binary is not bundled (third-party code), so the first time Obsidian will prompt you to install it — Settings → Community plugins → Browse → **Kanban** → Install. After that one-time install, [[board]] renders as a board everywhere.

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
