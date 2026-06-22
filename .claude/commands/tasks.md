---
description: Decompose the plan into board cards, test-first (launches sdd-tasker)
argument-hint: [path to the feature folder]
---

Launch the **`sdd-tasker`** subagent (Agent tool) for the feature ($ARGUMENTS or the most recent in
`specs/`). It writes small, ordered, verifiable cards to `docs/board.md` (or the active tracker per
`docs/task-tracking.md`). Because this project is TDD, each requirement gets a **test card first**
then an **implementation card**, every card tagged `#spec/NNN-slug` and an `FR-XX`.

When it returns: show the cards added and recommend `/analyze`, then `/tests`.
