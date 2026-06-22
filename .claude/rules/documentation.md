---
description: Documentation structure and authoring rule — every documentation Markdown file carries YAML frontmatter and links related notes with Obsidian wikilinks. Defines the folder structure, the frontmatter schema, the wikilink convention, and which operational files are exempt.
globs: "**/*.md"
alwaysApply: true
---

# Documentation Rule

How documentation is structured, named and linked in this repo. Applies to every **documentation**
Markdown file (human-readable knowledge). Operational/config files are exempt — see §Exemptions.

## Vault

The **repository root is the Obsidian vault**. Every `.md` is browsable and linkable from Obsidian.
Nothing needs to be physically collected into `docs/`; `docs/` only holds cross-feature guides,
the board and ADRs.

## Structure — what each thing means

| Path | Meaning | Category |
|---|---|---|
| `README.md` | Repo overview & quick start | `overview` |
| `docs/draft.md` | Raw product idea — entry point (Modes 1 & 2) | `idea` |
| `memory/constitution.md` | Non-negotiable project principles | `principle` |
| `specs/NNN-slug/spec.md` | WHAT + WHY of a feature (tech-free) | `spec` |
| `specs/NNN-slug/plan.md` | HOW — technical design, language chosen | `plan` |
| `specs/NNN-slug/research.md` | Investigated technical options & decisions | `research` |
| `specs/NNN-slug/data-model.md` | Entities, fields, relations | `data-model` |
| `specs/NNN-slug/contracts/*.md` | API contracts / interfaces | `contract` |
| `docs/README.md` | Vault index / home note | `overview` |
| `docs/workflow.md` | The SDD flow + the three modes | `guide` |
| `docs/task-tracking.md` | Board + Jira / GitHub Projects alternatives | `guide` |
| `docs/board.md` | Obsidian Kanban board (functional frontmatter) | `tracking` |
| `docs/adr/NNNN-*.md` | Architecture Decision Records | `adr` |
| `templates/*.md` | Skeletons copied by the commands | `template` |
| `projects/README.md` | How the multi-language monorepo works | `project` |

## Frontmatter (required on every documentation `.md`)

A YAML block at the very top of the file. Set `last_updated` to today's date whenever you edit.

```yaml
---
title: Database Setup            # required — human title
category: guide                  # required — see allowed values below
last_updated: 2026-06-22         # required — YYYY-MM-DD
status: Draft                    # specs/plans/adrs: Draft | In Review | Approved | Obsolete
feature: NNN-slug                # spec-related docs: the feature id (traceability)
difficulty: intermediate         # guides: beginner | intermediate | advanced
tags: [setup, database]          # Obsidian tags
related: ["[[architecture/data-flow]]", "[[reference/config]]"]  # wikilinks (quoted in YAML)
author: Jane Doe                 # decisions/ADRs
decided_by: Jane Doe             # ADRs / TDs — who made the call
supersedes: "[[adr/0003-old]]"   # ADRs only
superseded_by: "[[adr/0009-new]]"# ADRs only
---
```

- **Required for all:** `title`, `category`, `last_updated`.
- **Allowed `category` values:** `overview`, `idea`, `principle`, `spec`, `plan`, `research`,
  `data-model`, `contract`, `guide`, `adr`, `template`, `project`, `tracking`.
- Add only the optional fields that apply to the file's category. Do not invent ad-hoc keys.

## Wikilinks (always)

- Cross-reference other notes with Obsidian wikilinks `[[note]]`, never bare Markdown paths,
  in documentation prose.
- When a note name is ambiguous (e.g. several `spec.md`), use the path form:
  `[[specs/NNN-slug/spec]]`, optionally aliased: `[[specs/NNN-slug/spec|spec]]`.
- In frontmatter `related`/`supersedes`/`superseded_by`, write wikilinks as **quoted** strings so the
  YAML stays valid: `related: ["[[workflow]]"]`.

## Exemptions (operational / config — keep their own format)

These are NOT documentation; do not add doc-frontmatter or convert their paths to wikilinks:

| File | Why | Keep |
|---|---|---|
| `CLAUDE.md` | Agent instructions, auto-loaded | `@imports`, literal paths |
| `AGENTS.md` | Agent/stack conventions, auto-read | literal paths |
| `.claude/rules/*.md` | Agent rules, `@import`-ed | plain |
| `.claude/commands/*.md` | Slash commands | their `description`/`argument-hint` frontmatter |
| `.claude/agents/*.md` | Subagents | their `name`/`description`/`tools` frontmatter |
| `docs/board.md` | Obsidian Kanban | `kanban-plugin: board` frontmatter (may add `title`/`category` alongside) |

In operational files, file paths are literal instructions to the agent — leave them as paths.

## When you create or edit documentation

1. Add or refresh the frontmatter; set `last_updated` to today.
2. Link related notes with wikilinks (body **and** the `related` field).
3. For a new spec/plan/ADR/decision, include `status` and, for decisions, `author`/`decided_by`.
4. Commands that generate docs (`/specify`, `/plan`, `/sync`, …) MUST emit valid frontmatter per
   this rule. Templates in `templates/` already carry the skeleton frontmatter.
