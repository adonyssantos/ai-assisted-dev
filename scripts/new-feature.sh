#!/usr/bin/env bash
# Scaffold a new feature folder in specs/ from the templates.
# Usage: ./scripts/new-feature.sh <feature-slug>
# Tasks are NOT created here — they live on the Obsidian board (docs/board.md) via /tasks.
set -euo pipefail

if [ $# -lt 1 ]; then
  echo "Usage: $0 <feature-slug>" >&2
  exit 1
fi

# Slug: lowercase, spaces -> dashes, keep only [a-z0-9-]
slug=$(echo "$*" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd 'a-z0-9-')
[ -n "$slug" ] || { echo "Empty slug after normalization." >&2; exit 1; }

root="$(cd "$(dirname "$0")/.." && pwd)"
cd "$root"

# Next 3-digit sequential number
last=$(find specs -maxdepth 1 -type d -name '[0-9][0-9][0-9]-*' 2>/dev/null \
        | sed -E 's#.*/([0-9]{3})-.*#\1#' | sort -n | tail -1)
next=$(printf '%03d' $(( 10#${last:-0} + 1 )))

dir="specs/${next}-${slug}"
if [ -d "$dir" ]; then
  echo "Already exists: $dir" >&2
  exit 1
fi

mkdir -p "$dir/contracts"
cp templates/spec-template.md "$dir/spec.md"
cp templates/plan-template.md "$dir/plan.md"

# Fill in the feature ID, a human title and today's date in the copied files (frontmatter included)
id="${next}-${slug}"
title=$(echo "$slug" | tr '-' ' ' | sed -E 's/\b(.)/\u\1/g')
today=$(date +%F)
sed -i -e "s/NNN-slug/${id}/g" \
       -e "s/FEATURE_NAME/${title}/g" \
       -e "s/{{DATE}}/${today}/g" \
       "$dir/spec.md" "$dir/plan.md"

echo "Feature created: $dir"
echo "Next: open Claude Code and run  /specify  describing the feature."
echo "Tasks will be added to docs/board.md by  /tasks."
