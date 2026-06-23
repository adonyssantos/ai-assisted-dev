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
Nothing needs to be physically collected into `docs/`; `docs/` holds cross-feature, durable knowledge organised into Diátaxis-style sections, plus the board and ADRs. See §docs/ taxonomy for the full map.

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
| `docs/README.md` | Top-level Map of Content (links each section MOC) | `overview` |
| `docs/{section}/README.md` | Section Map of Content (one per Diátaxis section) | `overview` |
| `docs/framework/workflow.md` | The SDD flow + the three modes | `guide` |
| `docs/framework/task-tracking.md` | Board + Jira / GitHub Projects alternatives | `guide` |
| `docs/getting-started/*.md` | Learning-oriented tutorials (newcomer happy path) | `guide` |
| `docs/guides/*.md` | Task-oriented how-tos | `guide` |
| `docs/reference/*.md` | Information-oriented lookups (config, commands, conventions) | `reference` |
| `docs/architecture/*.md` | Understanding-oriented system design | `architecture` |
| `docs/architecture/adr/NNNN-*.md` | Architecture Decision Records | `adr` |
| `docs/operations/*.md` | Runbooks, deploy, monitoring, incident response | `runbook` |
| `docs/domain/*.md` | Ubiquitous language, glossary, domain concepts | `domain` |
| `docs/board.md` | Obsidian Kanban board (functional frontmatter) | `tracking` |
| `templates/moc-template.md` | Section MOC skeleton | `template` |
| `templates/guide-template.md` | Tutorial / how-to skeleton | `template` |
| `templates/reference-template.md` | Reference page skeleton | `template` |
| `templates/architecture-template.md` | Architecture note skeleton | `template` |
| `templates/runbook-template.md` | Runbook skeleton | `template` |
| `templates/glossary-template.md` | Domain glossary skeleton | `template` |
| `templates/adr-template.md` | ADR skeleton | `template` |
| `templates/*.md` (others) | Skeletons copied by the commands | `template` |
| `projects/README.md` | How the multi-language monorepo works | `project` |

## docs/ taxonomy

`docs/` is organised into Diátaxis-inspired sections. Each section is a folder with a MOC `README.md` (category `overview`) and its notes.

```
docs/
├── README.md            # top-level Map of Content (links every section MOC)
├── draft.md             # raw product idea (entry point)
├── board.md             # Kanban board
├── framework/           # the SDD + TDD process (workflow, task-tracking)
├── getting-started/     # learning-oriented tutorials
├── guides/              # task-oriented how-tos
├── reference/           # information-oriented lookups
├── architecture/        # understanding-oriented system design
│   └── adr/             # Architecture Decision Records (NNNN-kebab-title.md)
├── operations/          # runbooks, deploy, monitoring, incident response
└── domain/              # ubiquitous language, glossary, domain concepts
```

Doc type → location → category → template:

| Doc type | Location | Category | Template |
|---|---|---|---|
| Section index (MOC) | `docs/{section}/README.md` | `overview` | `templates/moc-template.md` |
| Tutorial (newcomer) | `docs/getting-started/` | `guide` | `templates/guide-template.md` |
| How-to | `docs/guides/` | `guide` | `templates/guide-template.md` |
| Reference page | `docs/reference/` | `reference` | `templates/reference-template.md` |
| Architecture note | `docs/architecture/` | `architecture` | `templates/architecture-template.md` |
| ADR | `docs/architecture/adr/` | `adr` | `templates/adr-template.md` |
| Runbook / ops | `docs/operations/` | `runbook` | `templates/runbook-template.md` |
| Glossary / domain | `docs/domain/` | `domain` | `templates/glossary-template.md` |
| Changelog | `docs/` (or project root) | `changelog` | `templates/changelog-template.md` |

### Where does a note belong?

- **About one feature** → keep it in `specs/NNN-slug/` (spec, plan, research, data-model, contracts).
- **Spans features or is durable** (process, cross-cutting reference, architecture, runbook, glossary) → `docs/` in the matching section.

### MOC + anti-orphan rule

- Every section has a MOC (`README.md`) that links its notes; the top-level `docs/README.md` links every section MOC.
- A note is **not done** until: (1) it is linked from its section MOC, and (2) it has at least one `related` wikilink in its frontmatter. Orphan notes (linked from nowhere) are not allowed.

### Naming

- Files are **kebab-case**: `database-setup.md`, not `DatabaseSetup.md`.
- ADRs are `NNNN-kebab-title.md` (4-digit zero-padded sequence), e.g. `0001-use-postgres.md`.

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
supersedes: "[[architecture/adr/0003-old]]"   # ADRs only
superseded_by: "[[architecture/adr/0009-new]]"# ADRs only
---
```

- **Required for all:** `title`, `category`, `last_updated`.
- **Allowed `category` values:** `overview`, `idea`, `principle`, `spec`, `plan`, `research`,
  `data-model`, `contract`, `guide`, `reference`, `architecture`, `runbook`, `domain`, `changelog`, `adr`, `template`, `project`, `tracking`.
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

## Line wrapping (no hard wraps)

Do NOT hard-wrap text. Write each paragraph, list item, blockquote line, and heading as a SINGLE physical line; rely on the editor's soft-wrap. Separate blocks with one blank line. Manual mid-sentence line breaks render as unexpected breaks in Obsidian.

Leave verbatim (do not join): YAML frontmatter, fenced code blocks, Markdown table rows (one row per line is required), and Kanban board card lists.

## When you create or edit documentation

1. Add or refresh the frontmatter; set `last_updated` to today.
2. Link related notes with wikilinks (body **and** the `related` field).
3. For a new spec/plan/ADR/decision, include `status` and, for decisions, `author`/`decided_by`.
4. Commands that generate docs (`/specify`, `/plan`, `/sync`, …) MUST emit valid frontmatter per
   this rule. Templates in `templates/` already carry the skeleton frontmatter.
5. Do NOT hard-wrap — one physical line per paragraph/list item/blockquote/heading (see §Line wrapping); rely on soft-wrap.
