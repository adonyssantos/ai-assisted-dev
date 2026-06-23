---
title: ai-assisted-dev — SDD + TDD template
category: overview
last_updated: 2026-06-22
tags: [sdd, tdd, monorepo, claude-code, obsidian]
related: ["docs/framework/workflow.md", "memory/constitution.md", "docs/framework/task-tracking.md", ".claude/rules/documentation.md"]
---

# ai-assisted-dev — Spec-Driven Development template (Claude Code)

A **language-agnostic, multi-language monorepo** template for building software with AI using **Spec-Driven Development (SDD)** and **Test-Driven Development (TDD)**. Code is derived from an explicit **specification**, and **tests are written before the code** that satisfies them. The spec is the source of truth; expert subagents execute each step traceably.

Everything lives in one repo — the idea, the specs, the task board, the docs, and the code for every project, in any language. The repository root is an **Obsidian vault**: open it in Obsidian to browse all docs and the Kanban board with working relative links.

## Subagent-driven flow

Each SDD step is owned by an **expert subagent** in `.claude/agents/`. Slash commands are thin launchers that delegate to them; the main agent may also auto-invoke a subagent by description.

```
docs/draft.md → /draft → /specify → /clarify → /plan → /tasks → /analyze → /tests → /implement
                                                                       (red)     (green)
```

| Step | Subagent | Command | Produces |
|---|---|---|---|
| Discover | `sdd-drafter` | `/draft` | candidate features from `docs/draft.md` |
| Specify | `sdd-specifier` | `/specify` | `specs/NNN-slug/spec.md` (WHAT + WHY, no tech) |
| Clarify | `sdd-clarifier` | `/clarify` | clarifying questions → updated spec |
| Plan | `sdd-planner` | `/plan` | `plan.md`, `research.md`, `data-model.md`, `contracts/` (language chosen) |
| Tasks | `sdd-tasker` | `/tasks` | test-first cards on `docs/board.md` |
| Analyze | `sdd-analyzer` | `/analyze` | coherence report |
| Test (red) | `sdd-test-author` | `/tests` | failing tests from acceptance criteria |
| Implement (green) | `sdd-implementer` | `/implement` | code in `projects/` until tests pass |
| Sync | `sdd-syncer` | `/sync` | reconcile `specs/` with an updated `docs/draft.md` |

## Modes of operation

The same artifacts and subagents serve three ways of working — only the entry point changes.

### Mode 1 — Greenfield: from an empty `docs/draft.md` to all specs
1. Fill `docs/draft.md` with the product idea.
2. `/draft` → candidate features + build order.
3. Per feature: `/specify` → `/clarify` → `/plan` → `/tasks` → `/analyze` → `/tests` → `/implement`.

### Mode 2 — Sync: from an updated `docs/draft.md`, reconcile existing specs
1. Edit `docs/draft.md`.
2. `/sync` → reconciliation report: **NEW** (create), **CHANGED** (update), **UNCHANGED** (skip), **REMOVED** (mark obsolete, or delete **only with explicit confirmation**).
3. `/clarify` updated specs → `/tasks` → `/tests` → `/implement` for the deltas. `FR-XX` ids stay stable so traceability and board cards survive.

### Mode 3 — Maintenance: a mature product
`docs/draft.md` is a stable north-star, not the daily driver.
- **New feature:** `/specify <feature>` → … → `/tests` → `/implement`.
- **Bug fix / support:** write a **failing regression test first**, fix under `projects/<name>/`, add an ADR in `docs/architecture/adr/` if architectural.
- **Keep records living:** update the affected `spec.md` when behavior changes.

## Layout

```
.
├── CLAUDE.md                 # Project instructions for Claude Code (always loaded)
├── AGENTS.md                 # Monorepo + multi-language conventions
├── memory/constitution.md    # Non-negotiable principles (incl. TDD)
├── specs/NNN-slug/           # One folder per feature: spec, plan, research, data-model, contracts
├── templates/                # Skeletons (carry frontmatter) used by the subagents
├── .claude/
│   ├── commands/             # Thin launchers: draft, specify, clarify, plan, tasks, analyze,
│   │                         #   tests, implement, sync
│   ├── agents/               # Expert subagents (sdd-*, incl. sdd-spec-reviewer)
│   ├── rules/documentation.md# Documentation rule (frontmatter + relative links)
│   └── settings.json         # Shared repo config (.env.example readable, real .env denied)
├── docs/                     # Vault content (Obsidian) — Diátaxis-style sections, each with a MOC README
│   ├── README.md             # Top-level Map of Content
│   ├── draft.md              # ENTRY POINT — your raw app idea (brain dump)
│   ├── board.md              # Kanban board (all tasks)
│   ├── framework/            # SDD + TDD process (workflow.md, task-tracking.md)
│   ├── getting-started/      # Learning-oriented tutorials
│   ├── guides/               # Task-oriented how-tos
│   ├── reference/            # Information-oriented lookups
│   ├── architecture/         # System design + adr/ (Architecture Decision Records)
│   ├── operations/           # Runbooks, deploy, monitoring
│   └── domain/               # Glossary + domain concepts
├── projects/                 # Multi-language code — one self-contained project per subfolder
└── scripts/new-feature.sh    # Scaffolds specs/NNN-slug/ from templates
```

## Task tracking

Default tracker: an **Obsidian Kanban board** at `docs/board.md` (see [board](docs/board.md)). Open the repo as a vault — the *Kanban* plugin is vendored under `.obsidian/plugins/`, so the board renders without any install. The tracker is swappable — see [task-tracking](docs/framework/task-tracking.md) for **Jira** or **GitHub Projects** via MCP/CLI.

## Documentation

All documentation follows [documentation](.claude/rules/documentation.md): YAML frontmatter on every doc, relative Markdown links for cross-references, one Obsidian vault at the repo root. Operational files (`CLAUDE.md`, `AGENTS.md`, `.claude/**`) are exempt and keep their functional format.

## Configure the template for your project

After cloning, configure the template **before** writing the first spec. Edit in this order:

| Order | File | What to change | When |
|---|---|---|---|
| 1 | `docs/draft.md` | Capture your product idea (the north-star) | Before `/draft` |
| 2 | `memory/constitution.md` | Adapt the principles (articles) to your project | Before `/plan` |
| 3 | `.claude/settings.json` | Tune tool/command permissions | Before commands that need them |
| 4 | `.claude/rules/` | Add project rules; import them from `CLAUDE.md` | As conventions emerge |
| 5 | `AGENTS.md` + `projects/<name>/AGENTS.md` | Declare monorepo + per-project stack/conventions | When a project's language is chosen (`/plan`) |

### Permissions — `.claude/settings.json`

- `permissions.allow` / `permissions.deny` decide what runs without prompting; `deny` wins over `allow`.
- Real env files are denied (`.env`, `.env.local`, `.env.*.local`); example envs are readable (`.env.example`, `.env.sample`, `.env.template`) so the agent can learn variable names without secrets.
- Add your project's commands as you adopt them. Example — allow your test runner (match your language):

```json
"allow": [
  "Bash(pytest:*)",
  "Bash(go test:*)",
  "Bash(npm test:*)"
]
```

Keep entries narrow (a specific command, not blanket `Bash`).

### Project rules — `.claude/rules/`

Capture recurring conventions as rule files so they load every session:

1. Create `.claude/rules/<name>.md` (optionally with `description` + `globs` frontmatter, like `.claude/rules/documentation.md`).
2. Import it from `CLAUDE.md`:

```
@.claude/rules/<name>.md
```

Rule files are operational config — exempt from the documentation frontmatter requirement.

### Principles — `memory/constitution.md`

- Adapt, remove or add articles to fit your project; bump the **Version** on any change.
- ⚠️ Some articles are cited **by number** in `.claude/agents/` and `templates/` (Article II = TDD, Article IV = language-agnostic). If you **reorder or renumber** them, update those citations too.

### Other config

- **Obsidian / Kanban:** the vault is the repo root; the *Kanban* plugin is vendored under `.obsidian/plugins/`, so the board renders on open — no install needed.
- **Task tracker:** the board (`docs/board.md`) is the default; swap to Jira or GitHub Projects via MCP/CLI — see [task-tracking](docs/framework/task-tracking.md).

### First feature

Once configured, run the flow in Claude Code:

```
/draft → /specify → /clarify → /plan → /tasks → /analyze → /tests → /implement
```

Or scaffold a feature folder by hand: `./scripts/new-feature.sh my-feature`.

For a full step-by-step walkthrough, see the [quickstart](docs/getting-started/quickstart.md).

## Quality gates & CI

Conventions are enforced, not just documented:

- **`scripts/validate.sh`** — checks doc frontmatter, forbids `[[` wikilinks, verifies the Kanban block, scans example env files. Run it anytime; it must pass.
- **`scripts/check-traceability.sh`** — verifies every `FR-XX` has a board card tagged `#spec/NNN-slug`.
- **Git hooks** (`.githooks/`) — enable once with `git config core.hooksPath .githooks`. `pre-commit`/`pre-push` run the validator; `commit-msg` enforces Conventional Commits. Bypass with `--no-verify`.
- **Claude Code hook** (`.claude/settings.json`) — a non-blocking advisory doc-lint on edits.
- **CI** (`.github/workflows/`) — `validate.yml` runs the validator on push/PR; `tests.yml` is a per-project test skeleton. PRs use the Definition-of-Done template in `.github/PULL_REQUEST_TEMPLATE.md`.

## Principles

1. **The spec rules.** Code contradicts spec → spec wins (or is updated explicitly).
2. **Tests first (TDD).** Failing test before code; never weaken a test to pass it.
3. **Separate WHAT from HOW.** `spec.md` never names technology; `plan.md` does.
4. **Technology-agnostic.** Any language; the language is a plan-time decision.
5. **Traceability.** Every task references a spec requirement (`FR-XX`).
