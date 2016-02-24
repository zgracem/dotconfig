# -----------------------------------------------------------------------------
# preferences
# -----------------------------------------------------------------------------

export LESS=''
LESS+='--QUIET '                # [-Q] never ring the terminal bell
LESS+='--ignore-case '          # [-i] case-insensitive searching
LESS+='--squeeze-blank-lines '  # [-s] combine consecutive blank lines
LESS+='--no-init '              # [-X] don't clear the screen on exit

export LESSCHARSET=utf-8
export LESSHISTFILE=/dev/null   # don't keep a history file

if lesspipe="$(getPath src-hilite-lesspipe.sh)"; then
    export LESSOPEN="| ${lesspipe} %s"  # source highlighting
    LESS+='--RAW-CONTROL-CHARS '        # output raw ANSI (e.g. \e[1;31m) [-R]
    unset -v lesspipe
fi

# -----------------------------------------------------------------------------

### ZGM added 2015-11-01 -- just somewhere to stash this

# LESS_TERMCAP_mb=$(tput blink)           # blinking mode
# LESS_TERMCAP_md=$(tput bold)            # bold mode [headers]
# LESS_TERMCAP_mr=$(tput rev)             # reverse video mode
# LESS_TERMCAP_mh=$(tput dim)             # dim mode
# LESS_TERMCAP_me=$(tput sgr0)            # end attributes mode
# LESS_TERMCAP_so=$(tput smso)            # standout [info box]
# LESS_TERMCAP_se=$(tput rmso; tput sgr0) # end standout
# LESS_TERMCAP_us=$(tput smul)            # underline [variables]
# LESS_TERMCAP_ue=$(tput rmu; tput sgr0)  # end underline
# LESS_TERMCAP_ZN=$(tput ssubm)           # subscript mode
# LESS_TERMCAP_ZV=$(tput rsubm)           # end subscript mode
# LESS_TERMCAP_ZO=$(tput ssupm)           # superscript mode
# LESS_TERMCAP_ZW=$(tput rsupm)           # end superscript mode
# LESS_TERMCAP_ZH=$(tput sitm)            # italics mode
# LESS_TERMCAP_ZR=$(tput ritm)            # end italics mode
# LESS_TERMEND=$(tput reset)              # reset colours
