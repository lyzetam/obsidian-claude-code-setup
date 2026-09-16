# capture.zsh — append every finished command to terminal-logs/daily-logs/YYYY/MM/YYYY-MM-DD.md
# Source this from ~/.zshrc. Requires zsh.
zmodload zsh/datetime
TERMINAL_LOG_DIR="${TERMINAL_LOG_DIR:-$HOME/second-brain/terminal-logs/daily-logs}"
_cmd_text=""; _cmd_start=""; _cmd_dir=""

_capture_preexec() {           # runs just before a command executes
  _cmd_text="$1"; _cmd_start=$EPOCHSECONDS; _cmd_dir="$PWD"
}
_capture_precmd() {            # runs after it finishes, before the next prompt
  local exit_code=$?
  [[ -z "$_cmd_text" ]] && return
  local elapsed=$((EPOCHSECONDS - _cmd_start)) dur=""
  (( elapsed >= 60 )) && dur=" ⏱$((elapsed/60))m $((elapsed%60))s"
  (( elapsed > 0 && elapsed < 60 )) && dur=" ⏱${elapsed}s"
  local logfile="$TERMINAL_LOG_DIR/$(date +%Y)/$(date +%m)/$(date +%F).md"
  [[ -d "${logfile:h}" ]] || mkdir -p "${logfile:h}"
  [[ -f "$logfile" ]] || print "# Terminal Log - $(date '+%A, %B %d, %Y')\n" >> "$logfile"
  local icon=$([[ $exit_code -eq 0 ]] && print "✓" || print "✗")
  print -- "- \`$(date +%H:%M:%S)\` $icon \`$_cmd_dir\`$dur" >> "$logfile"
  print -- "  \`\`\`bash\n  $_cmd_text\n  \`\`\`" >> "$logfile"
  _cmd_text=""
}
autoload -Uz add-zsh-hook
add-zsh-hook preexec _capture_preexec
add-zsh-hook precmd  _capture_precmd
