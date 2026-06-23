---
description: TDD red — write the failing tests first (launches sdd-test-author)
argument-hint: [path to the feature folder]
---

Launch the **`sdd-test-author`** subagent (Agent tool) for the feature ($ARGUMENTS or the most recent in `specs/`). It writes tests from the acceptance criteria using the project's test framework, scaffolds the minimal harness if needed, and **confirms the tests fail (red) for the right reason** — without implementing the feature.

When it returns: relay the tests written (mapped to `FR-XX`), the run command and the proof they fail, and recommend `/implement`.
