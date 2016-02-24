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

z_newline()
{   # print a newline if output is going to a terminal (force with -f)
    # Usage: z_newline [-f]

    if [[ -t 1 || $1 == -f ]]; then
        printf '%b' '\n'
    else
        return 0
    fi
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

_isAlias()
{   # exits 0 if $1 is defined as an alias
    quietly alias "$1"
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
    shopt -pq "$@"
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

# -----------------------------------------------------------------------------
# $PATH-related functions
# -----------------------------------------------------------------------------

getPath()
{   # returns the full path to $1
    type -P "$1" 2>/dev/null
}

getGNU()
{   # return the path to the GNU version of $1, if available

    local bin="$1"

    if _isGNU "$bin"; then
        type -P "$bin"
    else
        getPath "g${bin}"
    fi
}
