string match -q dumb "$TERM"; and exit

# TERMCAP will override TERMINFO if set (e.g. by GNU screen)
set --erase TERMCAP

set -gx --path TERMINFO_DIRS
set -a TERMINFO_DIRS $XDG_DATA_HOME/terminfo
set -a TERMINFO_DIRS /usr/local/opt/ncurses/share/terminfo
set -a TERMINFO_DIRS /usr/share/terminfo
set TERMINFO_DIRS (path filter -d $TERMINFO_DIRS | un1q)
set -gx TERMINFO $TERMINFO_DIRS[1]

path is -d $TERMINFO; or set --erase TERMINFO
