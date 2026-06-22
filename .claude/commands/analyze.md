---
description: Audit spec ↔ plan ↔ board coherence before coding (launches sdd-analyzer)
---

Launch the **`sdd-analyzer`** subagent (Agent tool) on the most recent feature (or the one given).
It is READ-ONLY and reports coverage, traceability, coherence, constitution (incl. TDD),
verifiability and leftover ambiguities, with a verdict.

When it returns: relay the findings table and verdict. If CRITICAL/HIGH findings exist, recommend
fixing spec/plan/board before `/tests`.
