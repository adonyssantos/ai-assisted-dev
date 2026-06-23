#!/usr/bin/env bash
# validate.sh — repo-convention validator (guardrail).
#
# Turns this repo's documented conventions into enforcement. Language-agnostic,
# dependency-free (grep/sed/awk only). Exits non-zero on any violation and
# prints a per-file, per-rule report.
#
# Rules:
#   1. Frontmatter  — every documentation .md (outside .claude/, .github/,
#                     excluding README.md/AGENTS.md/CLAUDE.md and .obsidian/) has YAML
#                     frontmatter with at least: title, category, last_updated.
#                     (Obsidian Kanban files — `kanban-plugin: board` — are
#                     functional; they need title + category only.)
#   2. Wikilinks    — no Obsidian wikilinks ([[...]]) in any .md outside .obsidian/.
#   3. Kanban board — docs/board.md keeps `kanban-plugin: board` frontmatter and
#                     the `%% kanban:settings %%` block.
#   4. Secrets      — .env.example-style files contain no obvious real secrets
#                     (WARN only; never fails the run).
#
# Usage: scripts/validate.sh [--help]
set -euo pipefail

# ---- repo root (robust: works from any cwd) --------------------------------
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
cd "$ROOT"

usage() {
  cat <<'EOF'
validate.sh — repo-convention validator (guardrail)

Usage:
  scripts/validate.sh            Run all checks; exit non-zero on any violation.
  scripts/validate.sh --help     Show this help.

Checks (deterministic, low-false-positive):
  1. Frontmatter   Documentation .md files carry YAML frontmatter with at least
                   title, category, last_updated. Exempt: README.md, AGENTS.md,
                   CLAUDE.md, anything under .claude/, .github/ or .obsidian/.
                   Obsidian Kanban files (kanban-plugin: board) need
                   title + category.
  2. Wikilinks     No Obsidian wikilinks ([[...]]) in .md outside .obsidian/
                   and .github/.
  3. Kanban board  docs/board.md keeps its kanban-plugin frontmatter and the
                   %% kanban:settings %% block.
  4. Secrets       .env.example-style files have no obvious real secrets (warn).

Bypass: this script is advisory by exit code; git hooks that call it can be
skipped with `git commit --no-verify` (see .githooks/README.md).
EOF
}

case "${1:-}" in
  -h|--help) usage; exit 0 ;;
  "") : ;;
  *) echo "Unknown argument: $1" >&2; usage >&2; exit 2 ;;
esac

FAIL=0
WARN=0
pass() { printf '  ok    %s\n' "$1"; }
fail() { printf '  FAIL  %s\n' "$1"; FAIL=$((FAIL+1)); }
warn() { printf '  warn  %s\n' "$1"; WARN=$((WARN+1)); }

# Extract the YAML frontmatter block (lines between the first `---` and the
# next `---`). Empty output if the file does not start with a frontmatter block.
frontmatter() {
  awk 'NR==1 && $0!="---" {exit} NR==1 {next} $0=="---" {exit} {print}' "$1"
}

# List documentation .md files: outside .claude/, .github/, .obsidian/, .git/,
# and not the operational README/AGENTS/CLAUDE files. (.github/ holds GitHub
# operational templates with their own frontmatter format — not vault docs.)
doc_md_files() {
  find . -type f -name '*.md' \
    -not -path './.git/*' \
    -not -path './.claude/*' \
    -not -path './.github/*' \
    -not -path './.obsidian/*' \
    -not -path './node_modules/*' \
  | grep -vE '/(README|AGENTS|CLAUDE)\.md$' \
  | sort
}

# ---- Rule 1: frontmatter ---------------------------------------------------
echo "[1/4] Frontmatter (title, category, last_updated) on documentation .md"
while IFS= read -r f; do
  [ -n "$f" ] || continue
  if [ "$(head -n1 "$f")" != "---" ]; then
    fail "$f — no YAML frontmatter block (file must start with '---')"
    continue
  fi
  fm="$(frontmatter "$f")"
  missing=""
  printf '%s\n' "$fm" | grep -Eq '^title:[[:space:]]*[^[:space:]]' || missing="$missing title"
  printf '%s\n' "$fm" | grep -Eq '^category:[[:space:]]*[^[:space:]]' || missing="$missing category"
  # Obsidian Kanban files are functional; they don't require last_updated.
  if printf '%s\n' "$fm" | grep -Eq '^kanban-plugin:[[:space:]]*board'; then
    :
  else
    printf '%s\n' "$fm" | grep -Eq '^last_updated:[[:space:]]*[^[:space:]]' || missing="$missing last_updated"
  fi
  if [ -n "$missing" ]; then
    fail "$f — missing frontmatter:$missing"
  else
    pass "$f"
  fi
done <<EOF
$(doc_md_files)
EOF

# ---- Rule 2: no wikilinks --------------------------------------------------
echo "[2/4] No Obsidian wikilinks ([[...]]) in .md outside .obsidian/ and .github/"
# grep returns 1 when nothing matches; tolerate that under set -e.
wl="$(grep -rn --include='*.md' -e '\[\[' . 2>/dev/null | grep -v '/\.obsidian/' | grep -v '/\.git/' | grep -v '/\.github/' || true)"
if [ -n "$wl" ]; then
  while IFS= read -r line; do
    [ -n "$line" ] && fail "wikilink: $line"
  done <<EOF
$wl
EOF
else
  pass "no wikilinks found"
fi

# ---- Rule 3: docs/board.md kanban integrity --------------------------------
echo "[3/4] docs/board.md Kanban integrity"
BOARD="docs/board.md"
if [ ! -f "$BOARD" ]; then
  fail "$BOARD — file missing"
else
  board_fm="$(frontmatter "$BOARD")"
  if printf '%s\n' "$board_fm" | grep -Eq '^kanban-plugin:[[:space:]]*board'; then
    pass "$BOARD — kanban-plugin: board frontmatter present"
  else
    fail "$BOARD — missing 'kanban-plugin: board' frontmatter"
  fi
  if grep -q '%% kanban:settings' "$BOARD"; then
    pass "$BOARD — %% kanban:settings %% block present"
  else
    fail "$BOARD — missing '%% kanban:settings %%' block"
  fi
fi

# ---- Rule 4: secrets in .env.example-style files (warn only) ---------------
echo "[4/4] No obvious real secrets in .env.example-style files (warn only)"
env_examples="$(find . -type f \
  \( -name '*.env.example' -o -name '.env.example' \
     -o -name '*.env.sample' -o -name '.env.sample' \
     -o -name '*.env.template' -o -name '.env.template' \) \
  -not -path './.git/*' -not -path './node_modules/*' 2>/dev/null | sort || true)"
if [ -z "$env_examples" ]; then
  pass "no .env.example-style files to check"
else
  # Heuristic: a KEY=VALUE where the value looks like a real, non-placeholder
  # secret. Placeholders (CHANGEME, your-..., <...>, xxx, empty, quoted empty)
  # are ignored to keep false positives low.
  while IFS= read -r ef; do
    [ -n "$ef" ] || continue
    hits="$(grep -nEi '^[[:space:]]*[A-Z0-9_]*(SECRET|TOKEN|PASSWORD|PASSWD|APIKEY|API_KEY|PRIVATE_KEY|ACCESS_KEY)[A-Z0-9_]*=[^[:space:]]' "$ef" 2>/dev/null \
      | grep -vEi '=(""|''|changeme|change-me|your[-_]|<[^>]*>|xxx+|placeholder|example|todo|replace|secret_here|\.\.\.)' \
      | grep -vE '=[[:space:]]*$' || true)"
    if [ -n "$hits" ]; then
      while IFS= read -r h; do
        [ -n "$h" ] && warn "possible secret in $ef: $h"
      done <<EOF
$hits
EOF
    else
      pass "$ef — no obvious secrets"
    fi
  done <<EOF
$env_examples
EOF
fi

# ---- summary ---------------------------------------------------------------
echo
if [ "$FAIL" -gt 0 ]; then
  echo "RESULT: FAIL — $FAIL violation(s), $WARN warning(s)."
  exit 1
fi
echo "RESULT: PASS — 0 violations, $WARN warning(s)."
exit 0
