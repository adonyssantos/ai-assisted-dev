# Board Rule

How the Obsidian Kanban board (`docs/board.md`) and its task notes are written so the board **never breaks**. Operational file — `@import`-ed from `CLAUDE.md`, read by `sdd-tasker`, `sdd-test-author` and `sdd-implementer`. Enforced by `scripts/validate.sh` (board integrity + card grammar) and `scripts/check-traceability.sh` (FR coverage).

## The model: thin card on the board, full detail in a task note

The board holds only **one-line cards**. Every card links to exactly **one task note** that carries the full task detail. Prose never lives on the board — it lives in the task note.

- **Task note:** `specs/NNN-slug/tasks/FR-XX-(test|impl).md`, created from `templates/task-template.md`. One note per task (co-located with its feature, per the documentation rule). Holds the requirement, acceptance criterion, Definition of Done, dependencies and a backlink to the board.
- **Card:** a single physical line under a lane, linking to that note.

## Card grammar (exact, single line)

```
- [ ] [FR-XX (test|impl) — <short title>](../specs/NNN-slug/tasks/FR-XX-(test|impl).md) #spec/NNN-slug
```

- Starts with `- [ ] ` (open) or `- [x] ` (done). Nothing else starts a card.
- Contains a Markdown link `[text](relative-path.md)` to the task note. The path is **relative to `docs/board.md`** → it begins with `../specs/...`.
- Contains the `FR-XX` id and the `#spec/NNN-slug` tag **on the same line** (this is what `check-traceability.sh` greps for — never split them).
- TDD pairing: write the `FR-XX (test)` card before the `FR-XX (impl)` card.
- **One physical line. No line breaks inside a card** (Obsidian renders a broken card as two cards).

## Invariants — never violate these (they keep the board renderable)

1. **Keep the frontmatter.** The file MUST start with the `kanban-plugin: board` YAML block. Never remove or reorder it.
2. **Keep the settings block.** The file MUST end with the `%% kanban:settings ... %%` block verbatim. Never edit, move or drop it — the Kanban plugin stops rendering without it.
3. **Keep the four default lanes** as `## ` headings, in order: `## Backlog`, `## In Progress`, `## In Review`, `## Done`. You may add extra lanes, but only **after** `## Done` and **before** the settings block.
4. **Move, don't rewrite.** To change a task's state, cut the **whole card line** and paste it unchanged under the target lane; flip `[ ]`↔`[x]` only when moving to/from `## Done`. Never retype a card (it desyncs the link).
5. **Append new cards** to the bottom of `## Backlog`.
6. **No prose on the board.** Notes, checklists and acceptance criteria go in the task note, never as extra board lines.
7. **Keep card ↔ note in sync.** When you move a card, set the matching `status:` field in its task note (`Backlog` / `In Progress` / `In Review` / `Done`) and refresh `last_updated`.

## Editing safely

- Use targeted edits on single card lines; never rewrite the whole file.
- After any board edit, run `scripts/validate.sh` (integrity + card grammar) and `scripts/check-traceability.sh` (every spec `FR-XX` has a card).

## Opting out of Obsidian / the board

The board ships enabled by default. If you do not want it:

1. Delete `docs/board.md` and the `.obsidian/` folder.
2. Switch to another tracker (Jira, GitHub Projects) per [task-tracking](../../docs/framework/task-tracking.md) — keep the `FR-XX` + `NNN-slug` references so traceability survives.
3. `check-traceability.sh` then expects cards in the active tracker; adapt or skip it accordingly.

Task notes under `specs/NNN-slug/tasks/` are tracker-independent and stay useful even without the board.
