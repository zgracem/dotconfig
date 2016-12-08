# -----------------------------------------------------------------------------
# less preferences
# -----------------------------------------------------------------------------

export LESS=""
LESS="${LESS}--QUIET "                # [-Q] never ring the terminal bell
LESS="${LESS}--ignore-case "          # [-i] case-insensitive searching
LESS="${LESS}--squeeze-blank-lines "  # [-s] combine consecutive blank lines
LESS="${LESS}--no-init "              # [-X] don't clear the screen on exit

export LESSCHARSET=utf-8
export LESSHISTFILE=/dev/null         # don't keep a history file

if lesspipe="$(command -v src-hilite-lesspipe.sh)"; then
  LESS="${LESS}--RAW-CONTROL-CHARS "  # [-R] output raw ANSI (e.g. \e[1;31m)
  export LESSOPEN="| ${lesspipe} %s"    # source highlighting
fi

unset -v lesspipe

# -----------------------------------------------------------------------------
# colourize man pages
# -----------------------------------------------------------------------------

CSI="$(printf '%b' '\e[')"

# begin/end "bold" mode -- used for man page headers
export LESS_TERMCAP_md="${CSI}32m"
export LESS_TERMCAP_me="${CSI}0m"

# begin/end "underline" mode -- used to highlight variables
export LESS_TERMCAP_us="${CSI}33m"
export LESS_TERMCAP_ue="${CSI}0m"

# reset everything
export LESS_TERMEND="${CSI}0m"
