# -----------------------------------------------------------------------------
# preferences
# -----------------------------------------------------------------------------

export LESS=
LESS+='--QUIET '                # never ring the terminal bell [-Q]
LESS+='--ignore-case '          # case-insensitive searching [-i]
LESS+='--squeeze-blank-lines '  # combine consecutive blank lines [-s]
LESS+='--no-init '              # don't clear the screen on exit [-X]

export LESSCHARSET=utf-8
export LESSHISTFILE=/dev/null   # don't keep a history file

if lesspipe="$(getPath src-hilite-lesspipe.sh)"; then
    export LESSOPEN="| ${lesspipe} %s"  # source highlighting
    LESS+='--RAW-CONTROL-CHARS '        # output raw ANSI (e.g. \e[1;31m) [-R]
    unset lesspipe
fi

# -----------------------------------------------------------------------------
# colourize man pages
# -----------------------------------------------------------------------------

LESS_TERMCAP_mb="${esc_magenta}"      # begin blinking mode
LESS_TERMCAP_md="${esc_green}"        # begin bold mode [headers]
LESS_TERMCAP_me="${esc_null}"         # end blink/bold mode
LESS_TERMCAP_us="${esc_yellow}"       # begin underline [variables]
LESS_TERMCAP_ue="${esc_null}"         # end underline
LESS_TERMCAP_so="${esc_orange}"       # begin standout [info box]
LESS_TERMCAP_se="${esc_null}"         # end standout
LESS_TERMEND="${esc_null}"            # reset colours

export ${!LESS_TERM*}
