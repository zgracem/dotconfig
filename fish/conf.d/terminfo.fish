string match -q $TERM dumb; and exit

# TERMCAP will override TERMINFO if set (e.g. by GNU screen)
set --erase TERMCAP

if fish-is-newer-than 3.0
    set -gx --path TERMINFO_DIRS $XDG_DATA_HOME/terminfo /usr/local/opt/ncurses/share/terminfo /usr/share/terminfo
    fix-path TERMINFO_DIRS
    set -gx TERMINFO $TERMINFO_DIRS[1]
else
    set -gx TERMINFO $XDG_DATA_HOME/terminfo
end


if not path is -d $TERMINFO
    set --erase TERMINFO
    exit
end
