---
name: error-handling
description: Error and exception conventions — fail fast, never swallow silently, add context, use idiomatic mechanisms per language, and never leak internals to users. Use when writing or reviewing error handling, exceptions, failure paths, or when something fails or is swallowed.
---

# Error Handling

Make failures loud, contextual, and safe. Supports verifiability (Art. VI — failures are observable) and security (Art. IX — no internals leaked).

## Principles

- **Fail fast**: validate inputs and preconditions early; stop at the first invalid state rather than limping forward with bad data.
- **No silent swallow**: never catch an error and do nothing (or only log at debug). Either handle it meaningfully, or let it propagate.
- **Add context**: when re-raising/wrapping, include what operation failed and the relevant identifiers — preserve the original cause (chain/wrap, don't discard the stack).
- **Be idiomatic**: use the language's standard mechanism — exceptions, result/error-return values, or option types — consistently within a project. Don't mix paradigms arbitrarily.
- **Catch narrowly**: catch the specific error you can handle, not a blanket catch-all. A broad catch hides bugs.
- **Never leak internals to users**: return a safe, generic message + a correlation id to the user; log the full detail server-side. No stack traces, secrets, or internal paths in user-facing output.
- **Clean up reliably**: release resources on every path (finally/defer/with) — including the error path.

## Quick checklist

| Check | Pass |
|---|---|
| Preconditions validated up front | yes |
| Every catch either handles or rethrows with context | yes |
| Specific error types caught (not blanket) | yes |
| Original cause preserved | yes |
| User-facing message safe; details only in logs | yes |
| Resources cleaned up on error paths | yes |

## Correct vs wrong

Correct: validate the id, attempt the op, on failure wrap as `"charge failed for order <id>"` preserving the cause, return a generic error + correlation id to the caller, log details.

Wrong: `try { ... } catch (e) { /* ignore */ }` — failure vanishes, data is now inconsistent.

## Relationship to subagents

General code practice, loaded during implementation/review. Pairs with `code-review` (error-handling row), `systematic-debugging`, and `security-review` (no leakage).
