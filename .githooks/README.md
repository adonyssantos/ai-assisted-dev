---
title: Git Hooks
category: guide
last_updated: 2026-06-22
tags: [git, hooks, guardrails, conventions]
related: ["../scripts/validate.sh", "../.claude/rules/documentation.md"]
---

# Git Hooks

Version-controlled git hooks that turn this repo's conventions into enforcement. They live in `.githooks/` so they are shared with everyone (the default `.git/hooks/` is not committed).

## Enable

These hooks are opt-in per clone. Point git at this folder once:

```bash
git config core.hooksPath .githooks
```

That is all — every hook below activates immediately. To disable, run `git config --unset core.hooksPath`.

## Hooks

| Hook | When it runs | What it does | Blocks on failure |
|---|---|---|---|
| `pre-commit` | Before a commit is recorded | Runs `scripts/validate.sh` (frontmatter, no wikilinks, board integrity, secret scan) | Yes |
| `commit-msg` | After you write the commit message | Validates the message is a Conventional Commit (`type(scope?): subject`) | Yes |
| `pre-push` | Before pushing to a remote | Runs `scripts/validate.sh`, then `just test` or `make test` if a task runner exists | Yes |

### pre-commit

Runs the repo-convention validator and aborts the commit if any check fails. The validator is dependency-free (grep/sed/awk only) and reports exactly which file failed which rule.

### commit-msg

Enforces [Conventional Commits](https://www.conventionalcommits.org/). The subject must match `type(scope?): subject`, where `type` is one of `feat`, `fix`, `docs`, `chore`, `refactor`, `test`, `perf`, `build`, `ci`, `style`, `revert`. An optional `!` (breaking change) is allowed before the colon. Auto-generated `Merge`, `Revert`, `fixup!`, and `squash!` messages pass through untouched.

Example of a valid message: `feat(validate): add frontmatter check`.

### pre-push

Runs the validator again as a last gate, then runs the project's test task: `just test` when a `justfile`/`Justfile` is present, or `make test` when a `Makefile` is present. If neither exists, it prints a reminder to wire up a `test` target instead of silently passing.

## Bypass

Every hook honors git's standard skip flag. Use it sparingly, for emergencies:

```bash
git commit --no-verify   # skips pre-commit and commit-msg
git push --no-verify     # skips pre-push
```
