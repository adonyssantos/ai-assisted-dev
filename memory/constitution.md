---
title: Project Constitution
category: principle
last_updated: 2026-06-22
tags: [principles, governance]
related: ["../docs/framework/workflow.md", "../README.md"]
---

# Project Constitution

Non-negotiable principles. Every draft, spec, plan, test and implementation must respect them. If a decision contradicts them → stop and escalate to the user.

> **Framework defaults — edit for your project.** These articles ship as the SDD/TDD engine's defaults, not as example content. Adapt, remove or extend any article freely and add your own below. Bump the **version** on any change.

> **How citations work (renumber-proof).** Subagents, skills and templates cite a principle by its **stable slug** (e.g. `Constitution: tdd`), never by its article number. The slug — declared in the index below and as an HTML anchor on each heading — is the durable identifier. You may **reorder, renumber, retitle** articles freely; as long as a slug keeps pointing at the same principle, every citation stays valid. If you **rename or delete a slug**, update the citations (find them with `grep -rn 'Constitution: ' .` and re-run `scripts/validate.sh`, which fails on any citation whose slug is not defined here).

## Principle index

| Slug | Article | Principle |
|---|---|---|
| `spec-first` | I | Spec before code |
| `tdd` | II | Test-first (TDD) |
| `what-vs-how` | III | Separate WHAT from HOW |
| `agnostic` | IV | Technology-agnostic & polyglot |
| `simplicity` | V | Simplicity first |
| `verifiability` | VI | Verifiability |
| `traceability` | VII | Traceability |
| `docs-discipline` | VIII | Documentation discipline |
| `quality` | IX | Quality is not optional |

## Article I — Spec before code <a id="spec-first"></a>

No code change without an approved spec. The spec is the source of truth. When code and spec diverge, the spec wins (or the spec is updated explicitly, with a recorded reason).

## Article II — Test-first (TDD) <a id="tdd"></a>

Write a failing test for each acceptance criterion **before** the implementation. Implement only to make failing tests pass, then refactor while green. **Never weaken, skip or delete a test to make it pass.** If a test is genuinely wrong, fix it deliberately and record why.

## Article III — Separate WHAT from HOW <a id="what-vs-how"></a>

The specification describes behavior and business value, never technology. The plan describes the technical implementation. They are not mixed.

## Article IV — Technology-agnostic & polyglot <a id="agnostic"></a>

The process makes no assumption about programming language. Each feature picks its language at plan time based on fit, not habit. This repo hosts multiple languages side by side under `projects/`.

## Article V — Simplicity first <a id="simplicity"></a>

Prefer the simplest solution that meets the requirements. Do not add abstraction, configurability or generalization without a requirement that justifies it (YAGNI).

## Article VI — Verifiability <a id="verifiability"></a>

Every requirement must be testable. Every task must have an objective acceptance criterion. If it cannot be verified, it is not well specified.

## Article VII — Traceability <a id="traceability"></a>

Every technical decision and every task links back to the requirement that originated it. Architecture decisions are recorded as ADRs in `docs/architecture/adr/`. Tasks live on the board in `docs/board.md`.

## Article VIII — Documentation discipline <a id="docs-discipline"></a>

All documentation follows [documentation](../.claude/rules/documentation.md) — YAML frontmatter on every doc, relative Markdown links for cross-references, single Obsidian vault at the repo root.

## Article IX — Quality is not optional <a id="quality"></a>

Tests pass before a task is "done". No secrets in the repo. New code matches the style of the existing code in its project.

---

**Version:** 1.2.0
**Ratified:** _(date)_
**Last amended:** 2026-06-22
