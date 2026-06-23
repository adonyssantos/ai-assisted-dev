---
name: changelog-release
description: Maintain a Keep a Changelog and cut releases with semantic versioning, deriving entries from conventional commits and linking specs/ADRs. Use when updating the changelog, cutting a release, bumping a version, writing release notes, or applying semver.
---

# Changelog & Release

A human-readable changelog plus disciplined versioning. Entries derive from conventional commits, so a clean commit history is the input (see `conventional-commits`).

## Changelog (Keep a Changelog)

- One `CHANGELOG.md`. Newest first. Keep an `## [Unreleased]` section at the top and move it under a version on release.
- Group entries under these headings: **Added**, **Changed**, **Deprecated**, **Removed**, **Fixed**, **Security**.
- Write for users, not as a raw commit dump: one line per change, with the spec id / ADR linked for traceability (Constitution: traceability).

| Commit type | Changelog heading |
|---|---|
| feat | Added |
| fix | Fixed |
| refactor/perf/build/ci/chore | usually omit, or Changed if user-visible |
| anything with BREAKING CHANGE | Changed/Removed, flagged as breaking |
| security fix | Security |

## Semantic Versioning (`MAJOR.MINOR.PATCH`)

| Bump | When |
|---|---|
| MAJOR | a breaking change (any commit with `BREAKING CHANGE` / `!`) |
| MINOR | a new backward-compatible `feat` |
| PATCH | backward-compatible `fix`/`perf` only |

Pre-1.0: breaking changes may bump MINOR; state the policy in the README.

## Release procedure

1. Collect commits since the last tag; classify by type.
2. Move `Unreleased` items under `## [X.Y.Z] - YYYY-MM-DD`; add any missing.
3. Choose the version per semver from the highest-impact change.
4. Link relevant specs/ADRs from the entries.
5. Tag the release; publish release notes from the new section.

## Correct vs wrong

Correct: `### Added — Session refresh now rejects expired tokens ([FR-07](specs/014-session-refresh/spec.md)).` then bump 1.3.0 → 1.4.0.

Wrong: PATCH bump for a breaking API change; changelog = pasted `git log`.

## Relationship to subagents

Not subagent-owned. Pairs with `conventional-commits` (the source) and `documentation-sync` (refresh docs at release time).
