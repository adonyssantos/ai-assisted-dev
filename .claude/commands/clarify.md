---
description: Resolve spec ambiguities (launches sdd-clarifier, then you ask the user)
argument-hint: [path to spec.md]
---

Launch the **`sdd-clarifier`** subagent (Agent tool) on the spec ($ARGUMENTS or the most recent in `specs/`). It returns the clarifying questions + suggested resolutions (READ-ONLY).

Then, in the main thread:
1. Ask the user the blocking questions (use options where helpful).
2. Apply the answers to `spec.md`: remove resolved `[NEEDS CLARIFICATION]`, make requirements verifiable, refresh `last_updated`, keep relative links (per the documentation rule).
3. Confirm no markers remain and recommend `/plan`.
