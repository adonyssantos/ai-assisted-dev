---
name: code-review
description: Pre-merge CODE review checklist — correctness, tests, simplicity, naming, error handling, security smells, traceability. Use when reviewing code, a PR or a change, or running a quality gate before merge. Distinct from the SPEC reviewer (sdd-spec-reviewer).
---

# Code Review

Reviews implementation diffs before merge. This is NOT spec review — `sdd-spec-reviewer` checks specifications; this skill checks CODE.

## Checklist

| Area | Check |
|---|---|
| Correctness | Does it do what the spec/FR says? Edge cases, off-by-one, null/empty, concurrency, boundaries handled? |
| Tests (TDD) | Tests exist, are meaningful, assert real behavior, and would fail without the change. No tests weakened/skipped to pass (Art. II). |
| Simplicity / YAGNI | Simplest solution that meets the requirement; no speculative abstraction or config (Art. V). |
| Naming & idioms | Clear names; matches the existing style/idioms of that project. |
| Error handling | Failures surface with context; no silent swallow; no internals leaked to users (see `error-handling`). |
| Security smells | No secrets/credentials; no injection/taint; safe deserialization; safe deps (see `security-review`). |
| Traceability | Diff maps to a spec id and `FR-XX`; commits/PR reference them (Art. VII). |
| Dead code | No unused code, commented-out blocks, leftover debug logs, or unreachable branches. |

## Severity levels

| Level | Meaning | Action |
|---|---|---|
| Blocker | Correctness/security bug, missing tests for new behavior, breaks the spec | Must fix before merge |
| Major | Significant smell — poor error handling, needless complexity, weak test | Fix before merge or file a tracked follow-up with rationale |
| Minor | Naming, style, small clarity nit | Fix or note; not merge-blocking |
| Nit | Optional preference | Author's discretion |

## How to deliver

- State findings as `severity — file:line — issue — suggested fix`. Be specific and actionable.
- Confirm the suite is green and the PR-body checklist (see `git-workflow`) is complete before approving.

## Correct vs wrong

Correct: "Blocker — auth.x:42 — refresh skips expiry check (FR-07); add test for expired token and check before reissue."

Wrong: "looks good 👍" with no checks performed.

## Relationship to subagents

Complements `sdd-spec-reviewer` (specs) and `sdd-implementer` (which writes the code). Pairs with `security-review`, `test-design`, `error-handling`.
