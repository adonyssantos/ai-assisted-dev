---
name: documentation-sync
description: Keep docs in step with code after any change — enumerate affected docs, refresh last_updated, fix relative links, obey the documentation rule. Use after a feature/fix, when asked to "update docs", when docs are out of date, or for a doc sync.
---

# Documentation Sync

After any code or behavior change, bring the docs back in line. This is a template differentiator: docs and code never silently diverge. Follows `.claude/rules/documentation.md` and Constitution Art. VIII.

## When to run

- After completing a feature or fix.
- After a contract/API/schema change.
- Whenever code behavior no longer matches what a doc claims.

## Procedure

1. **Enumerate affected docs** — which of these does the change touch?
2. **Update each** to reflect the new reality.
3. **Refresh `last_updated`** to today's date on every doc you edit (required frontmatter field).
4. **Fix cross-references** — use relative Markdown links ending in `.md` (e.g. `[note](../section/note.md)`), never wikilinks or bare paths, in prose and in `related`.
5. **Obey the documentation rule** — valid YAML frontmatter (`title`, `category`, `last_updated` required), correct `category` value, no hard-wrapped paragraphs (one physical line per paragraph/list item/table row).

## What to update when

| Change | Update |
|---|---|
| New/changed behavior | the feature `spec.md` (FR), and `plan.md` if the HOW changed |
| Technical decision | a new ADR in `docs/architecture/adr/`; link `supersedes`/`superseded_by` if it replaces one |
| API/interface | the relevant `specs/*/contracts/*.md` |
| Task status | the card(s) in `docs/board.md` |
| User-facing setup/usage | `README.md` / the relevant guide |
| Released change | the changelog (see `changelog-release`) |

## Correct vs wrong

Correct: fix changes refresh token behavior → update `spec.md` FR-07, bump `last_updated`, move the board card to Done, add a relative link to the new ADR.

Wrong: ship the fix, leave the spec describing the old behavior, dates untouched.

## Relationship to subagents

This is the manual companion to `sdd-syncer` (which reconciles specs against `docs/draft.md`). Use this skill for the after-a-change doc refresh that any task triggers.
