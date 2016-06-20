# -----------------------------------------------------------------------------
# ~/.config/bash/functions.bash
# -----------------------------------------------------------------------------

quietly()
{   # execute a command silently
    "$@" >/dev/null 2>&1
}

scold()
{   # echo to standard error
    printf '%b\n' >&2 "$@"
}

# -----------------------------------------------------------------------------
# true/false functions
# -----------------------------------------------------------------------------

_inPath()
{   # exits 0 if $1 is installed in $PATH
    quietly type -P "$1"
}

_isGNU()
{   # exits 0 if $1 uses GNU switches
    quietly command "$1" --version
}

_isFunction()
{   # exits 0 if $1 is defined as a function
    quietly declare -f "$1"
}

_optSet()
{   # exits 0 if shell variable/option $1 is set
    [[ :$SHELLOPTS: =~ :$1: ]] || shopt -pq "$1" 2>/dev/null
}

_inScreen()
{   # exits 0 if inside a GNU screen session
    [[ -p $SCREENDIR/$STY ]]
}

_inTmux()
{   # exits 0 if inside a tmux session
    [[ -S ${TMUX%%,*} ]]
}

_mux()
{   # exits 0 if inside a multiplexer session
    _inScreen || _inTmux
}
