---
name: retro
description: Run a retrospective / lessons-learned pass and feed the lessons back into the repo's durable rules. Use after a milestone or release, when asked for a retro, retrospective, post-mortem, lessons learned, "what went wrong", or to capture what to do differently next time. Language-agnostic.
---

# Retro

Turn what just happened into durable improvements. A retro is worthless if it stays in a chat log: every systemic lesson must land somewhere the next agent and the next human will actually read — the constitution, an agent rule, or an ADR. This is the loop that keeps the template honest over time.

## When to run

- After a milestone, release, or finishing a feature through `/implement`.
- After an incident or a painful debugging session (a "post-mortem").
- When the user asks for a retro, "lessons learned", or "what went wrong / what to do differently".
- Whenever the same mistake shows up twice — that is the signal a one-off has become systemic.

## Procedure

Keep it short and concrete. Work through four prompts, naming specifics (commits, files, requirements) rather than vague feelings:

1. **What worked** — practices, tools or decisions worth repeating. Name them so they can be reinforced.
2. **What didn't** — what slowed us down, broke, or had to be redone. Be specific and blameless.
3. **Root causes** — for each "didn't", ask why until you reach a cause you can act on, not a symptom.
4. **Actions** — one concrete change per root cause, each with an owner and a destination (see below). No action without a home.

## How lessons feed back

Route each action to where it will be enforced, by scope:

| Lesson scope | Where it goes | How |
|---|---|---|
| Systemic principle (applies to all future work) | [the constitution](../../../memory/constitution.md) | Add a **new article** (or amend one), then bump the constitution **version**. If you reorder/renumber articles, update the citations that reference them by number. |
| Recurring agent behavior (how an agent should act) | [the rules folder](../../rules/) | Add or edit a rule file (one concern per file); it is `@import`-ed into every agent. |
| One-off technical decision (this choice, this context) | `docs/architecture/adr/` | Record an ADR as `NNNN-kebab-title.md` from [the ADR template](../../../templates/adr-template.md), including **Razón / Impacto / Decidido por** (Reason / Impact / Decided by). |

Rule of thumb: if it must hold for *every* future feature, it is a constitution article or a rule; if it is "we chose X here for these reasons", it is an ADR. When in doubt between a rule and an ADR, prefer the ADR — it is cheaper to record and you can promote it to a rule later if the pattern repeats.

## Relationship to other skills and the constitution

- The [constitution](../../../memory/constitution.md) is the top of the chain — retro is the only routine that should propose **amending** it. Treat such amendments deliberately and bump the version.
- After a retro changes any documentation (a new ADR, an edited rule, a constitution bump), run the [documentation-sync](../documentation-sync/SKILL.md) skill to refresh `last_updated`, fix relative links, and link the new ADR from its section MOC so it is not orphaned.
- This skill captures *lessons*; the actual spec/test/code work that a lesson triggers still flows through the normal SDD + TDD cycle.

## Correct vs wrong

Correct: a flaky integration test wasted two sessions → root cause "no isolation rule for tests" → add a rule in `.claude/rules/`, record an ADR for the specific fix, run documentation-sync.

Wrong: hold the retro, agree "we should test better", write nothing down, repeat the same mistake next milestone.
