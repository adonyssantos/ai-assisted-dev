---
title: Capabilities — commands, subagents & skills
category: reference
last_updated: 2026-06-22
tags: [reference, commands, subagents, skills, disambiguation]
related: ["../framework/workflow.md", "../framework/task-tracking.md", "../../.claude/rules/documentation.md"]
---

# Capabilities — commands, subagents & skills

One map of every automated capability in this repo, so it is always clear **what to invoke** and the three layers never overlap or contradict each other.

## The three layers

| Layer | Lives in | Owns | How it runs | Own context/tools? |
|---|---|---|---|---|
| **Command** | `.claude/commands/` | A single SDD workflow step | You type `/name`; it's a thin launcher that delegates to one subagent | No — it just launches |
| **Subagent** | `.claude/agents/` | A workflow STEP end-to-end (e.g. write the spec, write the tests) | Launched by its command, by the main agent matching its description, or via the Agent tool | Yes — isolated context + a restricted tool set |
| **Skill** | `.claude/skills/` | Reusable KNOWLEDGE / a checklist for a cross-cutting concern | Loaded on demand by the main agent or by a subagent while doing a step | No — it's guidance applied in the current context |

**Decision rule.** Moving the feature through the pipeline → use the **command** for that step. Need depth on a concern *inside* a step (how to test, how to handle errors, how to review a diff) → load the matching **skill**. A skill never replaces a step, and a step never inlines what a skill already documents.

## Commands ↔ subagents (the SDD pipeline)

One command per step; each launches exactly one subagent. Full flow and modes: [workflow](../framework/workflow.md).

| Step | Command | Subagent | Read-only? |
|---|---|---|---|
| Discover | `/draft` | `sdd-drafter` | yes |
| Specify | `/specify` | `sdd-specifier` | no |
| Clarify | `/clarify` | `sdd-clarifier` | yes (main agent applies answers) |
| Plan | `/plan` | `sdd-planner` | no |
| Tasks | `/tasks` | `sdd-tasker` | no |
| Analyze | `/analyze` | `sdd-analyzer` | yes |
| Test (red) | `/tests` | `sdd-test-author` | no |
| Implement (green) | `/implement` | `sdd-implementer` | no |
| Sync | `/sync` | `sdd-syncer` | no |
| Spec review | — | `sdd-spec-reviewer` | yes (no command; auto-invoked or via Agent tool) |

## Skills catalog

Skills are concern-based knowledge, not pipeline steps. Each row says when to load it and which step/agent typically uses it.

| Skill | Use it for | Typically loaded during |
|---|---|---|
| `test-design` | How to write good tests (AAA, edges, FR mapping) | `/tests`, `/implement` |
| `error-handling` | Failure-path conventions (fail fast, add context, no leaks) | `/plan`, `/implement` |
| `api-design` | Contract-first interface/API design into `specs/*/contracts/` | `/plan` |
| `data-migrations` | Safe, reversible, idempotent schema/data changes | `/plan`, `/implement` |
| `refactoring` | Behavior-preserving cleanup under a green suite | `/implement`, maintenance |
| `systematic-debugging` | Evidence-first bug hunt; regression test before the fix | Mode 3 bug/support |
| `code-review` | Pre-merge review of a CODE diff | before merge (Mode 3 / PRs) |
| `security-review` | Baseline language-agnostic security pass | before merge, audits |
| `dependency-hygiene` | Vetting/pinning a new third-party dependency | `/plan`, adding a package |
| `conventional-commits` | Commit message format + traceability footer | every commit |
| `git-workflow` | Branch + PR conventions tied to the spec id | branching, opening a PR |
| `changelog-release` | Keep-a-Changelog entries + semver release | cutting a release |
| `documentation-sync` | Bring docs back in line after a change | after any feature/fix |
| `retro` | Turn lessons into durable rules (constitution/ADR/rule) | after a milestone/release |

## Overlaps resolved (don't confuse these)

These pairs share a word or a theme but do different jobs. Pick by the column.

| Looks similar | This one… | …vs this one |
|---|---|---|
| **review** | `code-review` (skill) reviews a **code diff** before merge | `sdd-spec-reviewer` (subagent) reviews a **spec** (WHAT/WHY) before `/plan` |
| **sync** | `documentation-sync` (skill) reconciles **docs ↔ code** after a change | `/sync` → `sdd-syncer` reconciles **specs ↔ `docs/draft.md`** (Mode 2) |
| **tests** | `test-design` (skill) is **how** to write a good test | `sdd-test-author` (subagent) **writes the failing tests** for a feature and proves red |
| **security** | `security-review` (skill) is this repo's **language-agnostic checklist** | `/security-review` & `/review` are **Claude Code built-ins** (harness commands); use either — they complement |
| **commits** | `conventional-commits` (skill) **writes** the message | `.githooks/commit-msg` **enforces** the format on commit |

## Enforcement (not a layer — a guardrail)

Conventions above are checked, not just documented: `scripts/validate.sh` (frontmatter, links, board integrity + card grammar, constitution-citation slugs, secrets), `scripts/check-traceability.sh` (every spec `FR-XX` has a board card), the git hooks in `.githooks/`, and CI in `.github/workflows/`. See [git hooks](../../.githooks/README.md).
