---
name: security-review
description: Baseline language-agnostic security pass over a change — secrets scan, dependency/CVE audit, injection/taint, authn/z gaps, unsafe deserialization, .env handling — with ranked findings. Use when asked about security, a vulnerability, a secret, an audit, injection, authz, or a dependency CVE.
---

# Security Review

A baseline security sweep of a change or codebase. Language-agnostic; speak in terms of the project's package manager, audit tool, and runtime. Reinforces Art. IX (no secrets in the repo).

## Checks

| Check | What to look for |
|---|---|
| Secrets / credentials | Hardcoded keys, tokens, passwords, connection strings in code, configs, tests, or history. Use a secret scanner. |
| Dependency / CVE audit | Run the ecosystem's audit (`npm audit`, `pip-audit`, `cargo audit`, `govulncheck`, …). Flag known-vulnerable or unmaintained deps. |
| Injection / taint | Untrusted input reaching SQL, shell/exec, file paths, templates, or HTTP calls without validation/parameterization/escaping. |
| AuthN / AuthZ | Endpoints/actions missing authentication; missing per-resource authorization checks; privilege escalation paths. |
| Unsafe deserialization | Deserializing untrusted data with formats/libraries that can execute or instantiate arbitrary types. |
| `.env` / config | Secrets only via env/secret store, never committed; `.env` git-ignored; example file uses placeholders, never real values. |
| Output / errors | No secrets or stack traces leaked to users or logs (see `error-handling`). |

## Ranked findings

Report each as `severity — location — issue — remediation`, ordered by severity.

| Severity | Meaning |
|---|---|
| Critical | Exploitable now: leaked secret, RCE, auth bypass |
| High | Likely exploitable: injection sink, known high CVE |
| Medium | Weakness needing conditions to exploit |
| Low / Info | Hardening opportunity, defense-in-depth |

## Correct vs wrong

Correct: "Critical — db.x:18 — query built via string concat with request input (SQLi); use parameterized query / prepared statement."

Wrong: "ran a scanner, no output shown, assume it's fine."

## Relationship to subagents

Not owned by a subagent. Pairs with `code-review` (security-smells row) and `dependency-hygiene` (audit on add). Escalate anything Critical/High to the user before merge.
