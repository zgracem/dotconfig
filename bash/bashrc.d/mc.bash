# Midnight Commander

_inPath mc || return

quietly unalias mc

export MC_TMPDIR="${TMPDIR:-$TMP}"

export MC_EDITOR=$EDITOR

if [[ -z $SSH_CONNECTION ]]; then
    MC_EDITOR=${VISUAL% --wait}
fi

# -----------------------------------------------------------------------------
# skins (~/share/mc/skins)
# -----------------------------------------------------------------------------

export MC_SKIN='zskin'

case $solarized in
    dark)
        MC_SKIN='solarized_dark'
        ;;
    light)
        MC_SKIN='solarized_light'
        ;;
esac

# -----------------------------------------------------------------------------
# flags
# -----------------------------------------------------------------------------

export flags_mc=()

# force xterm mode (for mouse support under tmux)
flags_mc+=('--xterm')

# use colourscheme-based skin
flags_mc+=("--skin=$MC_SKIN")

# -----------------------------------------------------------------------------
# simpler launch function
# -----------------------------------------------------------------------------

mc()
{
    if (( $# > 0 )); then
        local arg
        for arg in "$@"; do
            if [[ $arg =~ ^-([fFV]|-(configure-options|datadir(-info)?|version))$ ]]; then
                command mc ${flags_mc[*]} "$@"
                break
            fi
        done
    fi

    if _mux; then
        newwin --title mc EDITOR="$MC_EDITOR" PWD="$PWD" command mc ${flags_mc[*]} "$@"
    else
        command mc ${flags_mc[*]} "$@"
    fi
}

# -----------------------------------------------------------------------------
# set $PWD on exit
# -----------------------------------------------------------------------------

# mc()
# {
#     if _mux; then
#         if [[ -z $SSH_CONNECTION ]]; then
#             newwin --title mc EDITOR="${VISUAL% --wait}" command mc ${flags_mc[*]} "$@"
#         else
#             newwin --title mc command mc ${flags_mc[*]} "$@"
#         fi
#     else
#         local MC_USER="${USER:-$(id -un)}"
#         local MC_PWD_FILE="${MC_TMPDIR}/mc-$MC_USER/mc.pwd.$$"
#         local MC_PWD
#         flags_mc+=("--printwd=$MC_PWD_FILE")

#         command mc ${flags_mc[*]} "$@"

#         if [[ -s $MC_PWD_FILE ]]; then
#             read MC_PWD < "$MC_PWD_FILE"
#             if [[ -n $MC_PWD && -d $MC_PWD ]]; then
#                 quietly cd "$MC_PWD"
#             fi
#         fi

#         quietly rm -f "$MC_PWD_FILE"
#         unset -v MC_PWD MC_PWD_FILE
#     fi
# }
