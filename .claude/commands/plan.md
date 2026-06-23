---
description: Design the technical plan and choose the language (launches sdd-planner)
argument-hint: [path to spec.md]
---

Launch the **`sdd-planner`** subagent (Agent tool) for the spec ($ARGUMENTS or the most recent in `specs/`). It chooses the language + target `projects/<name>/` and writes `plan.md`, plus `research.md` / `data-model.md` / `contracts/` and an ADR as applicable — all with frontmatter + wikilinks per the documentation rule.

If it reports leftover `[NEEDS CLARIFICATION]`, stop and run `/clarify` first.

When it returns: summarize the approach, chosen language and risks, and recommend `/tasks`.
