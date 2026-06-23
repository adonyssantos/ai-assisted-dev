---
name: conventional-commits
description: Standardize commit messages using the Conventional Commits format, with a footer linking the spec id / FR-XX for traceability. Use when writing a commit, crafting a commit message, or anyone says "conventional commit", "commit", "commit message".
---

# Conventional Commits

Every commit message follows `type(scope): subject`, an optional body, and an optional footer. Keeps history machine-readable and feeds the changelog (see `changelog-release`).

## Format

```
type(scope): imperative subject (<= 72 chars, no trailing period)

Body — WHY the change is needed and WHAT it does at a high level.
Wrap context here, not in the subject.

Refs: NNN-slug FR-12          # traceability footer (Constitution Art. VII)
BREAKING CHANGE: describe the incompatible change and the migration path.
```

## Allowed types

| type | use for |
|---|---|
| feat | a new capability for the user |
| fix | a bug fix |
| docs | documentation only |
| test | adding or fixing tests |
| refactor | behavior-preserving code change |
| perf | performance improvement |
| build | build system, dependencies, lockfile |
| ci | CI/pipeline config |
| chore | maintenance with no src/test change |
| revert | reverts a previous commit |

## Rules

- Subject in the imperative mood: "add", not "added" / "adds".
- One logical change per commit; do not bundle unrelated edits.
- `scope` is optional but encouraged — the module/area touched.
- The body explains WHY, not a restatement of the diff.
- Add a `Refs:` footer naming the spec id and the `FR-XX` the commit advances — this is the traceability link the constitution requires.
- Breaking changes: add a `BREAKING CHANGE:` footer (and prefer `feat!`/`fix!` in the type). This drives the major version bump.

## Examples

Correct:
```
feat(auth): reject expired session tokens on refresh

Refresh accepted any token whose signature was valid, ignoring expiry.
Now expiry is checked before issuing a new pair.

Refs: 014-session-refresh FR-07
```

Wrong:
```
fixed stuff and updated some files
```
(no type, past tense, vague, no traceability footer.)

## Relationship to subagents

Not owned by any subagent — load this when committing. Pairs with `git-workflow` (branch/PR) and `changelog-release` (entries derived from these commits).
