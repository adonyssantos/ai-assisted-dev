---
name: dependency-hygiene
description: Add third-party dependencies safely — justify each one, pin/lock versions, check maintenance and license, prefer a minimum release age, commit the lockfile, run an audit. Use when adding a package, taking on a dependency, installing, touching the lockfile, or thinking about supply chain.
---

# Dependency Hygiene

Every dependency is permanent attack surface and maintenance cost. Add deliberately. Honors YAGNI (Art. V) and "no secrets / safe code" (Art. IX).

## Before adding a dependency

1. **Justify it (YAGNI)** — is the need real and non-trivial? Prefer the standard library or a few lines of your own over a package for something small. Record why the dep is warranted.
2. **Vet it** — check: actively maintained (recent releases, open issues addressed), reasonable popularity, sane transitive dependency tree, and a **compatible license**.
3. **Prefer a minimum release age** — avoid brand-new versions published hours/days ago (supply-chain risk); prefer versions that have been public for a cool-off period.

## When adding

- **Pin / lock versions**: use exact or constrained versions and commit the ecosystem's **lockfile** so builds are reproducible. Never rely on floating "latest".
- Add it in the right scope — runtime vs dev/test/build dependency.
- **Commit the lockfile** in the same change as the manifest edit.
- **Run an audit** (`npm audit`, `pip-audit`, `cargo audit`, `govulncheck`, …) and resolve flagged issues (see `security-review`).

## Ongoing

- Keep deps updated in small, reviewable bumps; re-run the audit on update.
- Remove unused dependencies promptly (dead weight = risk).

## Correct vs wrong

Correct: need date math → add a maintained, permissively-licensed lib at a pinned 3-week-old version, lockfile committed, audit clean.

Wrong: `install left-pad@latest` for one trim call, no lockfile change, no audit, license unchecked.

## Relationship to subagents

Loaded by whoever edits dependencies (often during `sdd-implementer` work). Pairs with `security-review` (CVE audit) and `changelog-release` (record notable dep/build changes via `build` commits).
