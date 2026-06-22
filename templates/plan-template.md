---
title: "Plan: FEATURE_NAME"
category: plan
feature: NNN-slug
status: Draft
last_updated: {{DATE}}
tags: [plan]
related: ["[[spec]]"]
---

# Technical plan: FEATURE_NAME

**Spec:** [[spec]]

> Describe HOW. Technology goes here. Each decision links a requirement (FR-XX).

## 1. Language & project

- **Language / runtime:** _(decided here, per Article IV)_
- **Target project:** `projects/<name>/` (new or existing)
- **Rationale:** why this language fits this feature.

## 2. Overall approach

3–5 line summary of the technical solution.

## 3. Architecture

Affected components, data flow, integrations. Diagram if helpful.

## 4. Technical decisions

| Decision | Chosen option | Rejected alternatives | Covers |
|----------|---------------|-----------------------|--------|
| … | … | … | FR-01 |

Relevant architecture decisions → ADR in `docs/adr/`.

## 5. Data model

See [[data-model]].

## 6. Contracts / API

See the `contracts/` folder.

## 7. Risks & mitigations

| Risk | Impact | Mitigation |
|------|--------|------------|
| … | … | … |

## 8. Test strategy (TDD)

Tests are written first (red) by `sdd-test-author`, then implemented to green. State the test
framework, the unit/integration/E2E split, and which `FR-XX` each test covers.
