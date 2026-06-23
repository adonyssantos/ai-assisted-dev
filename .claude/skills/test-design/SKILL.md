---
name: test-design
description: Craft good tests — AAA structure, one behavior per test, boundary/error/edge cases, mapped to FR-XX, testing public behavior not internals, deterministic and non-flaky. Use when deciding "what to test", covering edge cases, improving coverage, designing tests, or fixing flaky tests.
---

# Test Design

How to write tests worth having. Underpins TDD (Constitution: tdd) and verifiability (Constitution: verifiability). Knowledge that `sdd-test-author` and `sdd-implementer` can load.

## Structure

- **AAA**: Arrange (set up inputs/state) → Act (call the behavior once) → Assert (check the outcome). Keep the three visibly separated.
- **One behavior per test**: a single logical assertion target. If a failure can't tell you what broke, split the test.
- **Name for the behavior and the FR**: e.g. `refresh_rejects_expired_token__FR07`. The covered `FR-XX` should be obvious (traceability, Constitution: traceability).

## What to cover

| Category | Examples |
|---|---|
| Happy path | the normal expected input/outcome |
| Boundaries | empty, zero, one, max, off-by-one, just-inside / just-outside |
| Error cases | invalid input, missing fields, failures of dependencies — assert the right error/contract |
| Edge / special | null/empty, duplicates, ordering, concurrency, large input, unicode |

Map each acceptance criterion to at least one test; each `FR-XX` should have coverage.

## Quality rules

- Test **public behavior / contracts**, not private internals — so refactors don't break tests.
- **Deterministic**: no reliance on real time, randomness, network, ordering, or shared mutable state. Inject clocks/seeds; isolate fixtures. This prevents flakiness.
- Assert outcomes, not implementation calls, unless the interaction itself is the contract.
- Fast and independent: any test runs alone, in any order.

## Correct vs wrong

Correct: `withdraw_at_exact_balance_succeeds` and `withdraw_one_over_balance_is_rejected` — two boundary tests, deterministic, named to behavior.

Wrong: one `test_withdraw` that does five operations, sleeps for a timer, and asserts an internal counter field.

## Relationship to subagents

`sdd-test-author` (red step) and `sdd-implementer` load this when authoring tests. Pairs with `systematic-debugging` (regression tests) and `refactoring` (the green net).
