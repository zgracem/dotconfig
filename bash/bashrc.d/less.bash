# -----------------------------------------------------------------------------
# less preferences
# -----------------------------------------------------------------------------

export LESS=''
LESS+='--QUIET '                # [-Q] never ring the terminal bell
LESS+='--ignore-case '          # [-i] case-insensitive searching
LESS+='--squeeze-blank-lines '  # [-s] combine consecutive blank lines
LESS+='--no-init '              # [-X] don't clear the screen on exit

export LESSCHARSET=utf-8
export LESSHISTFILE=/dev/null   # don't keep a history file

if lesspipe="$(type -P src-hilite-lesspipe.sh 2>/dev/null)"; then
    export LESSOPEN="| $lesspipe %s"    # source highlighting
    LESS+='--RAW-CONTROL-CHARS '        # output raw ANSI (e.g. \e[1;31m) [-R]
fi

unset -v lesspipe

# -----------------------------------------------------------------------------
# colourize man pages
# -----------------------------------------------------------------------------

# begin/end "bold" mode -- used for man page headers
LESS_TERMCAP_md=${esc_green}
LESS_TERMCAP_me=${esc_reset}

# begin/end "underline" mode -- used to highlight variables
LESS_TERMCAP_us=${esc_yellow}         
LESS_TERMCAP_ue=${esc_reset}          

# reset everything
LESS_TERMEND=${esc_reset}

export ${!LESS_TERM*}
