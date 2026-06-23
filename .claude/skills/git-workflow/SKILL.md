---
name: git-workflow
description: Branch and pull-request conventions tied to the spec id — naming, small PRs, a PR-body checklist, CI green before merge, no self-merge. Use when creating a branch, opening a PR, asking to "open a PR", merge, or do a pull request.
---

# Git Workflow

Branches and PRs are tied to a spec. Keeps work traceable (Constitution: traceability) and reviewable.

## Branch naming

`type/NNN-slug` where `type` is `feat` or `fix` and `NNN-slug` is the spec id.

| Correct | Wrong |
|---|---|
| `feat/014-session-refresh` | `my-changes` |
| `fix/014-token-expiry` | `feature_branch_2` |

- One branch per feature/fix. Branch off the integration branch (e.g. `main`/`dev` per project convention).
- Never commit directly to the integration/default branch.

## Pull requests

- Keep PRs small and single-purpose — one spec/feature, reviewable in one sitting. Split large work into stacked PRs.
- Rebase or update the branch so it merges cleanly before requesting review.
- CI must be fully green before merge. Never merge red.
- No self-merge by default: another person approves and merges. Do not use admin overrides to bypass review.

## PR-body checklist

```
## Summary
What changed and why.

## Spec & tasks
- Spec: NNN-slug
- FR covered: FR-07, FR-08
- Board cards: <links>

## Checklist
- [ ] Tests added/updated and green (TDD — tests came first)
- [ ] Docs updated (see documentation-sync)
- [ ] No secrets / no dead code
- [ ] Linked to the spec and the board card(s)
```

## Relationship to subagents

Independent of the SDD subagents. Pairs with `conventional-commits` (message format) and `code-review` (what reviewers check before approving).
