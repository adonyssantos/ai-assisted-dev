---
title: Project Constitution
category: principle
last_updated: 2026-06-22
tags: [principles, governance]
related: ["../docs/framework/workflow.md", "../README.md"]
---

# Project Constitution

Non-negotiable principles. Every draft, spec, plan, test and implementation must respect them. If a decision contradicts them → stop and escalate to the user.

> **Framework defaults — edit for your project.** These articles ship as the SDD/TDD engine's defaults, not as example content. The subagents cite some by **number** (e.g. Article II = TDD, Article IV = language-agnostic), so if you **reorder or renumber** articles, update the citations in `.claude/agents/` and `templates/`. Otherwise adapt, remove or extend any article freely and add your own project-specific articles below. Bump the **version** on any change.

## Article I — Spec before code

No code change without an approved spec. The spec is the source of truth. When code and spec diverge, the spec wins (or the spec is updated explicitly, with a recorded reason).

## Article II — Test-first (TDD)

Write a failing test for each acceptance criterion **before** the implementation. Implement only to make failing tests pass, then refactor while green. **Never weaken, skip or delete a test to make it pass.** If a test is genuinely wrong, fix it deliberately and record why.

## Article III — Separate WHAT from HOW

The specification describes behavior and business value, never technology. The plan describes the technical implementation. They are not mixed.

## Article IV — Technology-agnostic & polyglot

The process makes no assumption about programming language. Each feature picks its language at plan time based on fit, not habit. This repo hosts multiple languages side by side under `projects/`.

## Article V — Simplicity first

Prefer the simplest solution that meets the requirements. Do not add abstraction, configurability or generalization without a requirement that justifies it (YAGNI).

## Article VI — Verifiability

Every requirement must be testable. Every task must have an objective acceptance criterion. If it cannot be verified, it is not well specified.

## Article VII — Traceability

Every technical decision and every task links back to the requirement that originated it. Architecture decisions are recorded as ADRs in `docs/architecture/adr/`. Tasks live on the board in `docs/board.md`.

## Article VIII — Documentation discipline

All documentation follows [documentation](../.claude/rules/documentation.md) — YAML frontmatter on every doc, relative Markdown links for cross-references, single Obsidian vault at the repo root.

## Article IX — Quality is not optional

Tests pass before a task is "done". No secrets in the repo. New code matches the style of the existing code in its project.

---

**Version:** 1.1.0
**Ratified:** _(date)_
**Last amended:** 2026-06-22
