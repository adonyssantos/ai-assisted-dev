---
name: api-design
description: Contract-first API and interface design tied to specs/*/contracts/ — naming, versioning, idempotency, consistent error shapes, pagination. Use when designing an API, an endpoint, a contract, a public interface, or thinking about versioning.
---

# API Design

Design the contract before the implementation. The contract lives in `specs/*/contracts/` and is the source of truth (Constitution: spec-first, Constitution: what-vs-how — WHAT before HOW).

## Contract-first

- Write/agree the contract (operations, request/response shapes, errors, status semantics) in `specs/NNN-slug/contracts/*.md` before coding.
- Tests assert against the contract (see `test-design`); implementation conforms to it, not the reverse.
- Language-agnostic: applies to HTTP/REST, RPC, message schemas, or a library's public interface.

## Principles

| Topic | Guidance |
|---|---|
| Naming | Consistent, predictable resource/operation names; consistent casing; nouns for resources, clear verbs for actions. |
| Versioning | Version the contract (e.g. path/header/package major). Add fields backward-compatibly; breaking changes → new version + deprecation path (ties to semver, see `changelog-release`). |
| Idempotency | Safe operations (read) have no side effects; make unsafe retries safe via idempotency keys or natural idempotent design so retries don't double-apply. |
| Error shapes | One consistent error envelope across the whole API: stable error code + safe human message (+ correlation id). Never leak internals (see `error-handling`). |
| Pagination | Paginate any unbounded collection (cursor preferred over offset for large/changing sets); return page metadata; cap page size. |
| Compatibility | Be liberal in what you accept, strict in what you emit; don't repurpose existing fields. |

## Correct vs wrong

Correct: contract defines `POST /orders` accepting an `Idempotency-Key`, returns a typed error envelope, lists are cursor-paginated with a max size; documented in `contracts/orders.md` before implementation.

Wrong: build the endpoint first, return ad-hoc error strings, no versioning, unbounded list — then "document later".

## Relationship to subagents

Feeds `sdd-planner` (HOW/plan) and the contracts that `sdd-test-author` tests against. Pairs with `error-handling`, `test-design`, and `changelog-release` (versioning).
