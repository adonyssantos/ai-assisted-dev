---
name: systematic-debugging
description: Evidence-first debugging method that writes a failing regression test BEFORE the fix (TDD red→green). Use when debugging, chasing a bug, a failing test, a crash, an error, a regression, when something "doesn't work", or you need to reproduce an issue.
---

# Systematic Debugging

The backbone of maintenance work. Fix root causes, not symptoms, and prove the fix with a test. Reinforces TDD (Constitution: tdd): the regression test is written and fails before any code changes.

## Procedure

1. **Reproduce** — get a deterministic, minimal repro. Capture the evidence: exact error/stack, input/payload, logs, the command that triggers it. No repro → keep gathering; do not guess-fix.
2. **Isolate** — narrow to the smallest code path. Bisect (git history, inputs, toggles) until the failing surface is small.
3. **Hypothesize** — state ONE concrete cause-and-effect hypothesis explaining the evidence (the root cause, not the symptom).
4. **Write a failing regression test FIRST (red)** — encode the expected correct behavior as a test using the project's runner. Run it; confirm it FAILS for the right reason (a real assertion, not a setup error). This locks the bug so it can't silently return.
5. **Minimal fix** — change the least code needed to make that test pass. No drive-by refactors in the same step.
6. **Green** — run the new test plus the full suite; all pass. Then refactor while green if needed (see `refactoring`).

## Iteration limits

| Limit | Value | When hit |
|---|---|---|
| Iterations per hypothesis | 2 | Discard it, form the next |
| Hypotheses per session | 3 | Report findings, ask the user for direction |

If you edit the same place 3+ times for the same bug → stop, revert, rethink the approach.

## Correct vs wrong

Correct: error reproduced → failing test added → one-line guard fixes the null deref → suite green.

Wrong: wrap the crashing call in a broad try/catch so the symptom disappears, no test, root cause unknown.

## Relationship to subagents

This is the human/agent method behind Mode 3 maintenance; the failing-test-first step mirrors what `sdd-test-author` does for new features. Pairs with `test-design` and `error-handling`.
