---
description: Write a feature's specification (launches sdd-specifier)
argument-hint: <feature description, or empty to read docs/draft.md>
---

Launch the **`sdd-specifier`** subagent (Agent tool) to write the spec.
- Pass it $ARGUMENTS; if empty, tell it to take the feature from `docs/draft.md`.
- It must follow `memory/constitution.md` and `.claude/rules/documentation.md` (frontmatter + relative links).

When it returns: summarize the key FRs and the open `[NEEDS CLARIFICATION]`, and recommend `/clarify`.
