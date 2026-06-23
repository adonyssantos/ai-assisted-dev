---
description: TDD green — implement until the tests pass (launches sdd-implementer)
argument-hint: [path to the feature folder]
---

Launch the **`sdd-implementer`** subagent (Agent tool) for the feature ($ARGUMENTS or the most recent in `specs/`). Failing tests must already exist (from `/tests`); if not, run `/tests` first.

It implements the minimum code under `projects/<name>/` to turn the tests green (one `FR-XX` at a time), refactors, and moves cards to Done. It never weakens a test to pass it; if a test/spec is wrong it stops and reports.

When it returns: relay per-card status, the full test + lint result, and any discrepancies found.
