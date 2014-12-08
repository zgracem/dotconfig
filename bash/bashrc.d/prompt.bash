# -----------------------------------------------------------------------------
# ~zozo/.config/bash/bashrc.d/prompt
# -----------------------------------------------------------------------------
# functions
# -----------------------------------------------------------------------------

PS1_trim_pwd()
{   # fancy PWD display function

    local leader='..'
    local max=$(( COLUMNS / 4 ))    # maximum length of displayed path
    local dir="${PWD##*/}"          # basename of current dir
    local _PWD=${PWD/#$HOME/\~}     # tilde-ify homedir

    # if basename of PWD is too long by itself, don't trim it
    max=$(( (max < ${#dir}) ? ${#dir} : max ))

    # if PWD is too long, by how much?
    local offset=$(( ${#_PWD} - max ))

    if (( offset > 0 )); then
        _PWD="${_PWD:$offset:$max}" # cut to $max chars long
        _PWD="${_PWD#*/}"           # clean up any leading detritus
        _PWD="${leader}/${_PWD}"    # show that it's been trimmed
    fi

    printf '%s' "${_PWD}"
}

PS1_print_exit()
{   # print non-zero exit codes on the far right of the screen (zsh envy...)
    local last_exit=$?

    if (( last_exit != 0 )); then
        # abort if tput doesn't exist
        _inPath tput || return

        local screen_width=${COLUMNS:-$(tput cols)}
        local padding=$(( screen_width - 1 ))

        # save cursor position
        tput sc

        # print exit code
        printf "%b%*d%b" "$esc_false" $padding $last_exit "$esc_reset"

        # restore cursor position
        tput rc
    fi
}

if [[ $TERM_PROGRAM =~ iTerm ]]; then
    PS1_update_iTerm()
    {   # notify iTerm of the current directory
        # http://code.google.com/p/iterm2/wiki/ProprietaryEscapeCodes

        local esc_ante="\e]50;"
        local esc_post="\a"

        printf '%b%s%b' "$esc_ante" "CurrentDir=$PWD" "$esc_post"
    }
fi

if [[ $TERM_PROGRAM == Apple_Terminal ]]; then
    PS1_update_Terminal()
    {   # notify Terminal.app of the current directory
        # format: file://hostname/dir

        local pwd_url="file://${HOSTNAME}${PWD// /%20}"
        local esc_ante="\e]7;"
        local esc_post="\a"

        if [[ -n $TMUX ]]; then
            # ANSI device control string
            esc_ante="\ePtmux;\e$esc_ante"
            esc_post="$esc_post\e\\"
        fi

        printf '%b' "$esc_ante" "$pwd_url" "$esc_post"
    }
fi

PS1_update_wintitle()
{
    if [[ $TERM_PROGRAM != Apple_Terminal ]]; then
        # Terminal already shows $PWD in the title bar
        local title_suffix="${PWD/#$HOME/\\x7E}"
    fi

    # see ../functions.d/wintitle.bash
    setWindowTitle "${title_prefix+$title_prefix: }${title_suffix}"
}

PS1_git_info()
{
    local branch status

    # get name of branch
    read branch < <(
        git branch --no-color 2>/dev/null \
        | sed -nE 's/^\* (.+)$/\1/p'
    )

    # bail out if no branch exists
    [[ -z $branch ]] \
        && return

    # $status = '*' if there's anything to commit
    if git status --porcelain 2>/dev/null | grep -m1 -q '^.'; then
        status='*'
    fi

    echo " on ${branch}${status} "
}

PS1_git_status()
{
    if git status --porcelain 2>/dev/null | grep -m1 -q '^.'; then
        echo "${esc_false}*${esc_null}"
    fi
}

# -----------------------------------------------------------------------------
# $PROMPT_COMMAND
# -----------------------------------------------------------------------------

PS1_add_cmd()
{   # append (or prepend with -p) to $PROMPT_COMMAND, avoiding duplicates
    if [[ $1 = -p ]]; then
        local prepend=true
        shift
    fi

    local new_cmd="$@"

    if [[ ! $PROMPT_COMMAND =~ $new_cmd ]]; then
        if [[ $prepend == true ]]; then
            PROMPT_COMMAND="${new_cmd}${PROMPT_COMMAND:+; }${PROMPT_COMMAND}"
        else
            PROMPT_COMMAND+="${PROMPT_COMMAND:+; }${new_cmd}"
        fi
    fi

    return 0
}

PS1_add_cmd -p PS1_print_exit

if declare -f PS1_update_iTerm &>/dev/null; then
    PS1_add_cmd PS1_update_iTerm
fi

if declare -f PS1_update_Terminal &>/dev/null; then
    PS1_add_cmd PS1_update_Terminal
fi

if declare -f PS1_update_wintitle &>/dev/null; then
    PS1_add_cmd PS1_update_wintitle
fi

# -----------------------------------------------------------------------------
# colours
# -----------------------------------------------------------------------------

# root gets red prompt
if [[ $EUID -eq 0 ]]; then
    esc_user=${esc_red}
fi

# add prompt escape codes
# ($esc_green -> $PS1_green, $esc_true -> $PS1_true)
for index in ${!esc_*}; do
    var_name="PS1_${index##*_}"

    if [[ -z ${!var_name} ]]; then
        eval "${var_name}=\"\[${!index}\]\""
    fi

    unset -v index var_name
done

export ${!PS1_*}

# -----------------------------------------------------------------------------
# PS1-4
# -----------------------------------------------------------------------------

# primary prompt

PS1="${PS1_2d}${HOSTNAME}${PS1_null}:"      # hostname, muted
PS1+="${PS1_hi}\$(PS1_trim_pwd)"            # current path, highlighted
# PS1+="\$(PS1_git_info)"
# PS1+="\$(PS1_git_status)"                 # red star for uncommitted changes
PS1+=" ${PS1_user}\\\$${PS1_null} "         # blue $ for me, red # for root

# secondary prompt (for multi-line commands)

PS2="${PS1_hi}"$'\xC2\xBB'"${PS1_null} "    # bright white right guillemet

# `select` prompt

PS3="${PS1_blue}?${PS1_null} "              # blue question mark

# prefix for xtrace output

# xse="${PS1_null}${PS1_hi}:${PS1_null}"      # separator
xse="${PS1_null}:"      # separator

PS4='+ '
PS4+="\${BASH_SOURCE[0]+${PS1_2d}\${BASH_SOURCE[0]}${xse}${PS1_blue}\${LINENO}${xse}}"
PS4+=$'${BASH_COMMAND}\n'

export PS1 PS2 PS3 PS4
