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
{   # exits 0 if all shell variables in $@ are set

    local opt
    for opt in "$@"; do
        [[ :$SHELLOPTS: =~ :$opt: ]] || return 1
    done
}

_shoptSet()
{   # exits 0 if all shell options in $@ are set
    shopt -pq "$@" 2>/dev/null
}

_set()
{   # exits 0 if shell variable/option $1 is set
    _optSet "$1" || _shoptSet "$1"
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
