#!/usr/bin/env bash
# weekly.sh — read the last 7 daily summaries and write one weekly review.
# Usage: weekly.sh ~/second-brain   (writes terminal-logs/weekly-reviews/YYYY/YYYY-Wnn.md)
set -euo pipefail
VAULT="${1:?vault path}"; cd "$VAULT"
WEEK="$(date +%G-W%V)"; OUT="terminal-logs/weekly-reviews/$(date +%G)/$WEEK.md"
[ -e "$OUT" ] && { echo "exists: $OUT"; exit 0; }
FILES=$(find terminal-logs/daily-summaries -name '*.md' -mtime -8 | sort | tail -7)
[ -z "$FILES" ] && { echo "no summaries in the last 7 days"; exit 1; }
{
  cat prompts/weekly-review.md
  for f in $FILES; do printf '\n\n===== %s =====\n' "$(basename "$f" .md)"; cat "$f"; done
} | claude -p --allowedTools "" --setting-sources "" > /tmp/weekly.$$ || { echo "CLI failed"; exit 1; }
# same guard as summarize.py: a review has headings and is not a one-line confirmation
grep -qE '^#{1,4} ' /tmp/weekly.$$ || { echo "REJECTED: no headings"; exit 1; }
head -1 /tmp/weekly.$$ | grep -qiE '^(done|saved|wrote|written)\b' && { echo "REJECTED: confirmation"; exit 1; }
mkdir -p "$(dirname "$OUT")"
{ printf '# Weekly Review — %s\n\n' "$WEEK"; cat /tmp/weekly.$$; } > "$OUT"; rm -f /tmp/weekly.$$
echo "wrote $OUT"
