# -----------------------------------------------------------------------------
# less preferences
# -----------------------------------------------------------------------------

export LESS=""
LESS="${LESS} --QUIET"                # [-Q] never ring the terminal bell
LESS="${LESS} --ignore-case"          # [-i] case-insensitive searching
LESS="${LESS} --squeeze-blank-lines"  # [-s] combine consecutive blank lines
LESS="${LESS} --no-init"              # [-X] don't clear the screen on exit

export LESSCHARSET=utf-8
export LESSHISTFILE=/dev/null         # don't keep a history file

# keep homedir tidy
[ -f "$HOME/.lesshst" ] && rm -fv "$HOME/.lesshst"

if lesspipe="$(command -v src-hilite-lesspipe.sh)"; then
  LESS="${LESS} --RAW-CONTROL-CHARS"  # [-R] output raw ANSI (e.g. \e[1;31m)
  export LESSOPEN="| $lesspipe %s"    # source highlighting
fi

unset -v lesspipe
