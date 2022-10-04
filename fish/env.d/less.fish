# -----------------------------------------------------------------------------
# less preferences
# -----------------------------------------------------------------------------

set -gx LESS
set -a LESS --QUIET # [-Q] never ring the terminal bell
set -a LESS --ignore-case # [-i] case-insensitive searching
set -a LESS --squeeze-blank-lines # [-s] combine consecutive blank lines
set -a LESS --no-init # [-X] don't clear the screen on exit

set -gx LESSCHARSET utf-8

# don't keep a history file
set -gx LESSHISTFILE /dev/null

# source highlighting
if set -l highlighter (command -v src-hilite-lesspipe.sh 2>/dev/null)
    set -gx LESSOPEN "| $highlighter %s"
    set -a LESS --RAW-CONTROL-CHARS # [-R] output raw ANSI (e.g. \e[1;31m)
end

# ----------------------------------------------------------------------------

# begin/end "bold" mode (man page headers)
set -gx LESS_TERMCAP_md (set_color green)
set -gx LESS_TERMCAP_me (set_color normal)

# begin/end "underline" mode (man page variables)
set -gx LESS_TERMCAP_us (set_color yellow)
set -gx LESS_TERMCAP_ue (set_color normal)

# reset
set -gx LESS_TERMEND (set_color normal)
