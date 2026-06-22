---
description: Reconcile specs against an updated docs/draft.md (launches sdd-syncer)
---

Launch the **`sdd-syncer`** subagent (Agent tool) to reconcile `specs/` with the edited `docs/draft.md`
(Mode 2). It classifies each capability NEW / CHANGED / UNCHANGED / REMOVED, applies NEW + CHANGED,
and **proposes** removals.

When it returns:
1. Relay the reconciliation report.
2. For each REMOVED item, ask the user to confirm before deleting the spec folder and its board
   cards; otherwise mark the spec `status: Obsolete`.
3. Recommend `/clarify` on updated specs, then `/tasks` / `/analyze` / `/tests` for the deltas.
