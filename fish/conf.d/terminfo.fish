string match -q $TERM dumb; and exit

# TERMCAP will override TERMINFO if set (e.g. by GNU screen)
set --erase TERMCAP

set -gx --path TERMINFO_DIRS $XDG_DATA_HOME/terminfo /usr{/local/opt/ncurses,}/share/terminfo
fix-path TERMINFO_DIRS
set -gx TERMINFO $TERMINFO_DIRS[1]

if not path is -d $TERMINFO
    set --erase TERMINFO
    exit
end
