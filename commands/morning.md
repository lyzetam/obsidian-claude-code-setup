Compose today's morning note. Today is $ARGUMENTS (if blank, use today's date from `date +%F`).

Inputs — read only these:
1. Yesterday's summary: `terminal-logs/daily-summaries/YYYY/MM/YYYY-MM-DD.md` for yesterday. If it is missing, say so in the table; do not search for a substitute.
2. Any file in `inbox/` (not `private/`).
3. `memory/MEMORY.md`, for decisions that affect today.

Write ONE file, `morning/YYYY/MM/YYYY-MM-DD.md` for today, and nothing else. Do not edit any other file. Format:

---
type: morning
date: YYYY-MM-DD
generated: <ISO timestamp>
---
# Morning — <weekday, date>

| Yesterday's summary | Inbox items | Decisions in memory |
|---|---|---|
| present / **missing** | <count> | <count> |

> [!todo] Today's three
> 1. most time-bound item first
> 2.
> 3.

## Still open
- [[YYYY-MM-DD]] — one line per loop that yesterday's summary left unfinished

Rules: leave a cell blank rather than guess a number. Take the three items only from the inputs. Keep it under 25 lines.
