# Obsidian + Claude Code — the setup, as scripts

The scripts, slash commands and config files from the book **_Obsidian + Claude Code: The Second Brain Setup Guide_** by Landry Zetam (Kindle, 2026). Every file here was run in a clean test vault on the day the book was finished; the results are in [TESTS.md](TESTS.md).

The book explains why each piece exists and the incidents that shaped it. This repo is the copy-paste half. It is free; the book is $4.99.

**Book:** [Obsidian + Claude Code: The Second Brain Setup Guide](https://www.amazon.com/dp/B0HKBMT98W) — $4.99 on Kindle.

The rest of the series: [Small AI Agents With Claude Code](https://www.amazon.com/dp/B0HKG9HS1W) (scheduled agents, [kit here](https://github.com/lyzetam/small-ai-agents-with-claude-code)) and [Claude Code for Everyday Computer Work](https://www.amazon.com/dp/B0HKMD72CL) (the entry point, for people who do not code).

## What you get

| Path | What it is | Where the book covers it |
|---|---|---|
| `templates/CLAUDE.md` | A starter root `CLAUDE.md`: where things live, what is machine-written, what is confidential, how memory works | Chapter 3 |
| `templates/CLAUDE.subfolder.md` | A two-line `CLAUDE.md` for a confidential sub-folder, with the marker line that proves layering works | 3.3 |
| `scripts/capture.zsh` | zsh hook: every finished command → `terminal-logs/daily-logs/YYYY/MM/YYYY-MM-DD.md` | 4.1 |
| `scripts/sweep.py` | Files stray dated notes into `YYYY/MM/`. Moves only, never overwrites, idempotent, `--dry-run` | 2.2, 5.2 |
| `scripts/summarize.py` | Yesterday's terminal log → a daily summary via `claude -p` with **no tools**, and a guard that rejects a "Saved to…" stub | 4.2, 5.1 |
| `scripts/weekly.sh` + `prompts/weekly-review.md` | The last seven summaries → one weekly review, same guards | 5.2, 6.2 |
| `commands/daily-summary.md` | `/daily-summary` — the interactive version of the nightly job | 4.2 |
| `commands/morning.md` | `/morning` — one morning note from yesterday's summary, the inbox and memory | 4.3 |
| `commands/find.md` | `/find` — "where did I put that", read-only, memory index first | 5.3 |
| `commands/maintenance.md` | `/maintenance` — checks the system, not the content: missing days, stub summaries, log errors, stale memory, hand-edited generated files | 6.2 |
| `launchd/com.example.daily-summary.plist` | The 06:00 schedule for macOS | 5.1 |
| `templates/memory/` | The memory index and one example fact file | 6.1 |
| `examples/` | What the log, the summary, the morning note and the weekly review actually look like (from the test vault) | 1.2, 4.2, 4.3, 5.2 |

## Quick start (a weekend, per the book; an hour if you just want the jobs)

Requirements: macOS or Linux, zsh, Python 3, [Claude Code](https://code.claude.com/docs/en/setup) signed in (Pro/Max/Team), an Obsidian vault or any folder of markdown notes.

```bash
# 1. Put the files in your vault (assumes ~/second-brain; change every path if not)
cd ~/second-brain
mkdir -p scripts .claude/commands prompts logs memory daily inbox private
cp /path/to/this/repo/scripts/*        scripts/
cp /path/to/this/repo/commands/*       .claude/commands/
cp /path/to/this/repo/prompts/*        prompts/
cp /path/to/this/repo/templates/memory/MEMORY.md memory/
cp /path/to/this/repo/templates/CLAUDE.md CLAUDE.md   # then edit it — it describes YOUR vault

# 2. Capture: add to ~/.zshrc, then open a NEW shell (open shells keep the old code)
echo 'source ~/second-brain/scripts/capture.zsh' >> ~/.zshrc

# 3. File strays — preview first, always
python3 scripts/sweep.py ~/second-brain --dry-run
python3 scripts/sweep.py ~/second-brain

# 4. Summarize yesterday by hand once, read what it wrote
python3 scripts/summarize.py ~/second-brain

# 5. Schedule it: edit the three /Users/me paths, lint, load
cp /path/to/this/repo/launchd/com.example.daily-summary.plist ~/Library/LaunchAgents/
plutil -lint ~/Library/LaunchAgents/com.example.daily-summary.plist
launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.example.daily-summary.plist

# 6. Inside Claude Code in the vault:
#    /find <something you decided>      /morning      /maintenance
```

## The three rules the scripts enforce

1. **Dated notes carry the full date in the filename** — `2026-09-03.md`, never `03.md`. Obsidian resolves `[[2026-09-03]]` by basename; `03.md` collides across every month.
2. **Change the generator, not the file.** Anything a script writes is listed in `CLAUDE.md`; you fix the script, not the output.
3. **Headless runs get no tools.** `summarize.py` and `weekly.sh` call `claude -p --allowedTools ""` so the only thing the model can do is print the report, and they refuse to save an answer whose first line reads like *Saved* or *Done*. Nine weekly reports were lost to that before the guard existed.

## Privacy

Claude Code sends what it reads to Anthropic to get an answer. The templates mark `private/` as confidential and every command excludes it. Keep anything that must never leave your machine in there, and say so in `CLAUDE.md` — the tests show the model honoring that rule without being reminded.

## Contact

Corrections, questions, and fixes to the templates are all welcome. Open an issue
here, or email **landryzetam@agentmail.to**.

## License

MIT. Copy, change, ship. If the book helped, an honest review on Amazon helps the next reader find it.
