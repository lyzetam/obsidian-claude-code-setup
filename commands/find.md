Search the vault for: $ARGUMENTS

Steps:
1. Check `memory/MEMORY.md` first. If a line there answers it, open that fact file.
2. Otherwise run `grep -ril --exclude-dir=private --exclude-dir=.obsidian "$ARGUMENTS" .`
   Try two or three variant phrasings if the first returns nothing.
3. Read the top five candidates. Prefer dated notes and decision notes.
4. Answer in this shape:
   - **[[note-name]]** — YYYY-MM-DD — one line of context
   - > the exact line that answers the question, quoted
5. If nothing fits, say so. Do not guess.

Read-only. Do not create, edit, move or delete any file.
Never read or quote anything under private/, even if grep returns it.
