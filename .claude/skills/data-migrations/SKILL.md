---
name: data-migrations
description: Safe schema and data migrations — idempotent, reversible, forward-compatible, with backup/restore and language/DB-agnostic principles. Use when writing or reviewing a migration, changing a schema, doing an ALTER, or running a data backfill.
---

# Data Migrations

Migrations change persistent state, so they must be safe to re-run, safe to roll back, and safe to deploy alongside running code. Principles are DB-agnostic (relational, document, or other stores).

## Principles

| Principle | Detail |
|---|---|
| Idempotent | Re-running must not fail or double-apply. Guard with existence checks (e.g. "if not exists" / check the catalog before altering). Backfills must be safely resumable. |
| Reversible | Provide a down/rollback path, or a documented forward-fix if truly irreversible. Test the rollback, not just the apply. |
| Forward-compatible | Deploy so the old and new code can both run during rollout. Use expand → migrate → contract: add new structures, backfill, switch code, then remove old structures in a later step — never rename/drop in one shot. |
| Backed up | Take/verify a backup or snapshot before destructive steps; know the restore procedure. Destructive ops (drop/truncate/delete) require explicit confirmation. |
| Small & ordered | One logical change per migration, applied in deterministic order, recorded in a migration ledger. |
| Big backfills | Batch large data changes to avoid long locks/timeouts; make them restartable and observable. |

## Procedure

1. Write the migration with existence guards (idempotent) and a rollback.
2. Ensure current code tolerates both old and new shape (expand phase).
3. Apply on a copy/staging first; verify data and rollback.
4. Backup/snapshot prod; apply; monitor.
5. Only after the new code is fully live, schedule the contract step (drop old columns/structures).

## Correct vs wrong

Correct: add nullable `email_verified`, backfill in batches, deploy code that reads it, later make it non-null / drop the legacy column in a separate migration.

Wrong: a single migration that renames a column and the code that depended on the old name ships separately — old pods break mid-deploy.

## Relationship to subagents

Planned as part of the HOW in `sdd-planner` / the feature `plan.md`; data shape comes from `data-model.md`. Pairs with `data-model` documentation, `error-handling`, and `documentation-sync` (update the data-model doc after).
