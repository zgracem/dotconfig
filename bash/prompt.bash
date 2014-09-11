# -----------------------------------------------------------------------------
# ~zozo/.config/bash/prompt
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------
# setup
# -----------------------------------------------------------------------------

# root gets red prompt
if [[ $EUID -eq 0 ]]; then
    esc_user=${esc_red}
fi

# add prompt escape codes
# ($esc_green -> $PS1_green, $esc_true -> $PS1_true)
for index in ${!esc_*}; do
    eval "PS1_${index##*_}=\"\[${!index}\]\""
    unset index
done

export ${!PS1_*}

# -----------------------------------------------------------------------------
# functions
# -----------------------------------------------------------------------------

PS1_trim_pwd()
{   # fancy PWD display function
    declare leader=".."
    declare max=$((COLUMNS/4))      # maximum length of displayed path
    declare dir=${PWD##*/}          # basename of current dir

    # if basename of $PWD is too long by itself, don't trim it
    max=$(( (max < ${#dir}) ? ${#dir} : max ))

    _PWD=${PWD/#$HOME/\~}            # tilde-ify homedir

    # if $PWD is too long, by how much?
    declare offset=$(( ${#_PWD} - max ))
    if [[ ${offset} -gt 0 ]]; then
        _PWD="${_PWD:$offset:$max}" # cut to $max chars long
        _PWD="${_PWD#*/}"           # clean up any leading detritus
        _PWD="${leader}/${_PWD}"    # show that it's been trimmed
    fi

    echo -n "${_PWD}"
}

PS1_print_exit()
{   # print non-zero exit codes on the far right of the screen (zsh envy...)
    declare lastExit=$?

    if [[ $lastExit -ne 0 ]]; then
        declare screenWidth=${COLUMNS:-$(tput cols)}
        declare padding=$((screenWidth - 1))

        tput sc # save cursor position
        printf "%b%*d%b" "$esc_false" $padding $lastExit "$esc_reset"
        tput rc # restore cursor position
    fi
}

# notify iTerm of the current directory
# http://code.google.com/p/iterm2/wiki/ProprietaryEscapeCodes
if [[ $TERM_PROGRAM =~ iTerm.app ]]; then
    PS1_update_iTerm()
    {
        printf "%b%s%b" "\e]50;" "CurrentDir=$PWD" "\a"
    }
fi

# tell Terminal.app about the working directory at each prompt.
if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then
    if [[ -n $TMUX ]]; then
        # ANSI device control string
        tmuxEscAnte="\ePtmux;\e"
        tmuxEscPost="\e\\"
    fi

    PS1_update_Terminal()
    {   # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.

        declare pwdURL="file://${HOSTNAME}${PWD// /%20}"
        printf '%b\e]7;%b\a%b' "$tmuxEscAnte" "$pwdURL" "$tmuxEscPost"
    }
fi

if [[ $TERM =~ xterm|rxvt|putty|screen|cygwin ]]; then
    PS1_update_wintitle()
    {
        if [[ $TERM_PROGRAM != "Apple_Terminal" ]]; then
            # Terminal already shows $PWD in the title bar
            declare titleSuffix=": "${PWD/#$HOME/\~}
        fi

        setWindowTitle "${titlePrefix}${titleSuffix}"
    }
fi

PS1_git_info()
{
    declare branch status

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
# prompts -- see colours.bash
# -----------------------------------------------------------------------------

unset PS{1..4}

# primary prompt

PS1+="${PS1_2d}${HOSTNAME}${PS1_null}:"     # hostname, muted
PS1+="${PS1_hi}\$(PS1_trim_pwd)"            # current path, highlighted
# PS1+="\$(PS1_git_info)"
PS1+="\$(PS1_git_status)"                   # red star for uncommitted changes
PS1+=" ${PS1_user}\\\$${PS1_null} "         # blue $ for me, red # for root

# secondary prompt (for multi-line commands)

PS2+="${PS1_hi}"$'\xC2\xBB'"${PS1_null} "   # bright white right guillemet

# `select` prompt

PS3+="${PS1_blue}?${PS1_null} "             # blue question mark

# prefix for xtrace output

xse="${PS1_null}${PS1_hi}:"                 # separator

PS4+="${PS1_2d}\${BASH_SOURCE##*/}${xse}"   # muted filename
PS4+="${PS1_blue}\${LINENO}"                # blue line number
PS4+="\${FUNCNAME[0]+${xse}${PS1_2d}\${FUNCNAME[0]}()}"
                                            # function name (if applicable)
PS4+="${xse}${PS1_null}"                    # reset

export PS{1..4}

# -----------------------------------------------------------------------------
# $PROMPT_COMMAND
# -----------------------------------------------------------------------------

add_prompt_cmd()
{   # append (or prepend with -p) to $PROMPT_COMMAND, avoiding duplicates
    if [[ $1 = "-p" ]]; then
        declare prepend=true
        shift
    fi

    declare new_cmd="$@"

    if [[ ! $PROMPT_COMMAND =~ $new_cmd ]]; then
        if [[ $prepend == true ]]; then
            PROMPT_COMMAND="${new_cmd}${PROMPT_COMMAND:+; }${PROMPT_COMMAND}"
        else
            PROMPT_COMMAND+="${PROMPT_COMMAND:+; }${new_cmd}"
        fi
    fi

    return 0
}

add_prompt_cmd -p PS1_print_exit

if _isFunction PS1_update_iTerm; then
    add_prompt_cmd PS1_update_iTerm
fi

if _isFunction PS1_update_Terminal; then
    add_prompt_cmd PS1_update_Terminal
fi

if _isFunction PS1_update_wintitle; then
    add_prompt_cmd PS1_update_wintitle
fi

# for func in iTerm Terminal wintitle; do
#     if _isFunction "PS1_update_${func}"; then
#         add_prompt_cmd "PS1_update_${func}"
#     fi
# done
