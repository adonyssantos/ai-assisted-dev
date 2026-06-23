#!/usr/bin/env bash
# check-traceability.sh — verify SDD traceability: every FR-NN in a spec has a board card.
#
# For each specs/*/spec.md it reads the feature id (NNN-slug, from the folder name) and
# the FR-NN requirement ids the spec declares. For each FR it checks that at least one
# card in docs/board.md references that FR id together with the feature tag
# #spec/<NNN-slug> on the same line. Uncovered FRs (no matching card) are reported and
# cause a non-zero exit.
#
# Dependency-free: bash + coreutils (find, sort) + grep/sed. No jq/yq/python.
# PASSes with exit 0 when specs/ is empty — the template ships with no specs.
#
# Usage: bash scripts/check-traceability.sh   (--help for details)
set -euo pipefail

usage() {
  cat <<'USAGE'
check-traceability.sh — verify SDD traceability (spec FR-NN -> board card)

For each specs/*/spec.md, every functional requirement id (FR-NN) must be referenced
by at least one card in docs/board.md that also carries the feature tag #spec/<NNN-slug>
on the same line.

Usage:
  bash scripts/check-traceability.sh        Run the check.
  bash scripts/check-traceability.sh --help Show this help.

Exit codes:
  0  All FRs are covered, OR specs/ is empty / declares no FRs (nothing to check).
  1  One or more FRs have no matching board card (or the board is missing).
  2  Bad usage.
USAGE
}

case "${1:-}" in
  -h|--help) usage; exit 0 ;;
  "") : ;;
  *) echo "Unknown argument: $1" >&2; usage >&2; exit 2 ;;
esac

# Resolve repo root from this script's location, so it works from any cwd.
script_dir=$(cd "$(dirname "$0")" && pwd)
root=$(cd "$script_dir/.." && pwd)
board="$root/docs/board.md"

# Collect spec files (sorted, stable) into an array. No match -> empty array.
specs=()
while IFS= read -r f; do
  [ -n "$f" ] && specs+=("$f")
done < <(find "$root/specs" -mindepth 2 -maxdepth 2 -type f -name spec.md 2>/dev/null | sort)

if [ "${#specs[@]}" -eq 0 ]; then
  echo "no specs yet, nothing to check"
  exit 0
fi

if [ ! -f "$board" ]; then
  echo "ERROR: docs/board.md not found (specs exist but the board is missing)" >&2
  exit 1
fi

total_fr=0
uncovered=0

for spec in "${specs[@]}"; do
  feature_dir=$(dirname "$spec")
  feature=$(basename "$feature_dir")   # NNN-slug

  # Extract FR ids (FR-01, FR-12, ...), normalize, dedupe, sort.
  frs=$(grep -oE 'FR-[0-9]+' "$spec" 2>/dev/null | sort -u || true)

  if [ -z "$frs" ]; then
    echo "WARN: $feature/spec.md declares no FR-NN requirements" >&2
    continue
  fi

  for fr in $frs; do
    total_fr=$((total_fr + 1))
    # A covering card mentions both the FR id and the feature tag on the same line.
    if grep -F "$fr" "$board" | grep -Fq "#spec/$feature"; then
      :
    else
      echo "UNCOVERED: $fr ($feature) has no board card tagged #spec/$feature"
      uncovered=$((uncovered + 1))
    fi
  done
done

if [ "$total_fr" -eq 0 ]; then
  echo "no FR-NN requirements declared in any spec, nothing to check"
  exit 0
fi

if [ "$uncovered" -gt 0 ]; then
  echo ""
  echo "FAIL: $uncovered of $total_fr requirement(s) lack a board card."
  exit 1
fi

echo "OK: all $total_fr requirement(s) are covered by board cards."
exit 0
