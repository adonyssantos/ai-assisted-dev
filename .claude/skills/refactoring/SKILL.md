---
name: refactoring
description: Refactor safely under a green test suite — small reversible behavior-preserving steps, staying green between each, with a stop-and-revert rule and YAGNI discipline. Use when asked to refactor, clean up, simplify, or restructure code.
---

# Refactoring

Refactoring changes structure, never behavior. Tests are the safety net. Honors Constitution: tdd (never weaken tests) and Constitution: simplicity (simplicity / YAGNI).

## Preconditions

- The relevant test suite is GREEN before you start. No green safety net → write/borrow tests first (or use `systematic-debugging` if chasing a bug), then refactor.
- You have a clear, behavior-preserving goal (e.g. extract function, rename, remove duplication, simplify a branch).

## Procedure

1. Confirm green.
2. Make ONE small, reversible step (extract, inline, rename, move, dedupe).
3. Run the tests. Still green → keep the step. Red → revert the step immediately and try smaller.
4. Commit the small green step (see `conventional-commits`, type `refactor`).
5. Repeat. Do NOT mix a behavior change into a refactor commit — split them.

## Rules

- Behavior-preserving only: same inputs → same outputs/effects. If behavior must change, that is a `feat`/`fix` with its own failing test first, not a refactor.
- Small steps that keep the suite green throughout. Never let it go red and "fix it later".
- Stop-and-revert: if a step breaks green and isn't trivially fixed, revert and decompose further.
- YAGNI: refactor toward the simplest shape that serves current requirements. Do not add abstraction or configurability "for the future".

## Correct vs wrong

Correct: extract a duplicated block into one function in a single step → suite green → commit → next step.

Wrong: rewrite the module and "improve" the API in one big diff with the suite red until the end.

## Relationship to subagents

A general engineering practice; complements `sdd-implementer` (refactor-while-green after tests pass). Pairs with `test-design` and `code-review`.
