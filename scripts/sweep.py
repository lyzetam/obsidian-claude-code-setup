#!/usr/bin/env python3
"""sweep.py — move stray dated notes (YYYY-MM-DD.md) into <root>/YYYY/MM/.
Moves only. Never overwrites. Idempotent. --dry-run to preview."""
import re, sys
from pathlib import Path

VAULT = Path(sys.argv[1]).expanduser()
ROOTS = ["daily", "terminal-logs/daily-logs", "terminal-logs/daily-summaries"]
SKIP = {"private", ".obsidian", ".git", "node_modules"}
DATED = re.compile(r"^(\d{4})-(\d{2})-(\d{2})\.md$")
dry = "--dry-run" in sys.argv

def home_for(name: str) -> Path:
    """Where a stray file belongs. Files found under one of ROOTS stay in that
    root; anything else (inbox, vault root, a phone capture) goes to daily/."""
    return VAULT / "daily"

moved = skipped = 0
for path in VAULT.rglob("*.md"):
    if SKIP & set(path.relative_to(VAULT).parts): continue
    m = DATED.match(path.name)
    if not m: continue
    y, mo = m[1], m[2]
    root = next((VAULT / r for r in ROOTS if (VAULT / r) in path.parents), home_for(path.name))
    dest = root / y / mo / path.name
    if dest == path: continue                      # already home
    if dest.exists():
        print(f"SKIP  {path.relative_to(VAULT)} — {dest.relative_to(VAULT)} already exists"); skipped += 1; continue
    print(f"{'WOULD MOVE' if dry else 'MOVE'}  {path.relative_to(VAULT)} -> {dest.relative_to(VAULT)}")
    if not dry:
        dest.parent.mkdir(parents=True, exist_ok=True); path.rename(dest); moved += 1
print(f"done: {moved} moved, {skipped} skipped")
