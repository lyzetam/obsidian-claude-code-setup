Check the system, not the content. Report only problems. Read-only: do not create, edit, move or delete anything.

1. For each of the last 7 days (today is `date +%F`), say whether `terminal-logs/daily-summaries/YYYY/MM/YYYY-MM-DD.md` exists, and if it does not, whether the matching log in `terminal-logs/daily-logs/YYYY/MM/` exists.
2. List any summary under 400 characters or whose first line reads like a confirmation ("Saved", "Done", "I've written").
3. Read every `*.log` file under `logs/`. Quote any `REJECTED`, `CLI failed` or `SKIP` line, with the file it came from.
4. Read `memory/MEMORY.md`. Flag any fact contradicted by this week's daily summaries.
5. List any summary whose file was modified after the `generated` line inside it, or after the day it covers — a hand edit the generator will never reproduce.
6. Propose a one-line fix to `CLAUDE.md` for any recurring confusion you can see in the summaries. If none, say none.

Format: one heading per item, one line per finding, "none" where clean.
