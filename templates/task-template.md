---
title: "FR-XX (test|impl) — TASK_TITLE"
category: tracking
feature: NNN-slug
status: Backlog
last_updated: {{DATE}}
tags: [task]
related: ["../spec.md", "../plan.md"]
---

# FR-XX (test|impl) — TASK_TITLE

> One task = one note. The board card is a one-line link to this note (see [board rule](../../../.claude/rules/board.md)). Keep `status` in sync with the card's lane.

- **Spec:** [spec](../spec.md) · **Plan:** [plan](../plan.md)
- **Requirement:** FR-XX — _(restate the requirement this task serves)_
- **Kind:** `test` (write the failing test, TDD red) or `impl` (make it pass, green)
- **Board card:** under lane _(Backlog | In Progress | In Review | Done)_ in [board](../../../docs/board.md)

## Acceptance criterion

> The verifiable condition this task satisfies (copied from the spec's acceptance criteria).

- [ ] Given _(context)_, when _(action)_, then _(verifiable result)_.

## Definition of Done

- [ ] For a **test** task: the test exists, runs, and **fails for the right reason** (red).
- [ ] For an **impl** task: the test passes (green), no other test weakened, refactored while green.
- [ ] `status` here and the board card's lane agree; `last_updated` refreshed.

## Dependencies

- _(other FR-XX / task notes that must land first, or "none")_

## Notes

- _(design notes, edge cases, links — anything that would otherwise clutter the board)_
