# -----------------------------------------------------------------------------
# ~zozo/.config/bash/prompt
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------
# setup
# -----------------------------------------------------------------------------

# root gets red prompt
[[ $EUID -eq 0 ]] &&
    colour_user=${red}

# add prompt escape codes
# ($green -> $esc_green, $colour_true -> $esc_true)
for index in ${colours[@]}; do
    eval "esc_${index#*_}=\"\[${!index}\]\""
    unset index
done

export ${!esc_*}

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
    [[ ${offset} -gt 0 ]] && {
        _PWD="${_PWD:$offset:$max}" # cut to $max chars long
        _PWD="${_PWD#*/}"           # clean up any leading detritus
        _PWD="${leader}/${_PWD}"    # show that it's been trimmed
    }

    echo -n "${_PWD}"
}

PS1_print_exit()
{   # print non-zero exit codes on the far right of the screen (zsh envy...)
    declare lastExit=$?

    [[ $lastExit -eq 0 ]] || {
        declare screenWidth=${COLUMNS:-$(tput cols)}
        declare padding=$((screenWidth - 1))

        tput sc # save cursor position
        printf "%b%*d%b" "$colour_false" $padding $lastExit "$colour_reset"
        tput rc # restore cursor position
    }
}

PS1_update_iTerm()
{   # notify iTerm of the current directory
	# http://code.google.com/p/iterm2/wiki/ProprietaryEscapeCodes

    printf "%b%s%b" "\e]50;" "CurrentDir=$PWD" "\a"
}

# tell Terminal.app about the working directory at each prompt.
if [[ $TERM_PROGRAM == "Apple_Terminal" ]]; then
    [[ $TMUX ]] && {
        # ANSI device control string
        tmuxEscAnte="\ePtmux;\e"
        tmuxEscPost="\e\\"
    }

    PS1_update_Terminal()
    {   # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.

        declare pwdURL="file://${HOSTNAME}${PWD// /%20}"
        printf '%b\e]7;%b\a%b' "$tmuxEscAnte" "$pwdURL" "$tmuxEscPost"
    }
fi

PS1_update_wintitle()
{
    [[ $TERM_PROGRAM != "Apple_Terminal" ]] && {
        # Terminal already shows $PWD in the title bar
        declare titleSuffix=": "${PWD/#$HOME/\~}
    }
    
    setWindowTitle "${titlePrefix}${titleSuffix}"
}

PS1_git_info()
{
    declare branch status

    # get name of branch
    branch="$(git branch --no-color 2>/dev/null | sed -nE 's/^\* (.+)$/\1/p')"

    # bail out if no branch exists 
    [[ -z $branch ]] && return

    # $status = '*' if there's anything to commit
    if git status --porcelain 2>/dev/null | grep -m1 -q '^.'; then
        status='*'
    fi

    echo " on ${branch}${status} "
}

# -----------------------------------------------------------------------------
# prompts -- see colours.bash
# -----------------------------------------------------------------------------

unset PS{1..4}

# primary prompt

PS1+="${esc_2d}${HOSTNAME}:"                # hostname, muted
PS1+="${esc_hi}\$(PS1_trim_pwd) "                # current path, highlighted
# PS1+="\$(PS1_git_info)"
PS1+="${esc_user}\\\$${esc_null} "          # blue $ for me, red # for root

# secondary prompt (for multi-line commands)
PS2+="${esc_hi}"$'\xC2\xBB'"${esc_null} "   # bright white right guillemet

# `select` prompt
PS3+="${esc_blue}?${esc_null} "             # blue question mark

# prefix for xtrace output

xse="${esc_hi}:"                            # separator

PS4+="${esc_2d}\${BASH_SOURCE##*/}${xse}"   # muted filename
PS4+="${esc_blue}\${LINENO}${xse}"          # blue line number
PS4+="\${FUNCNAME[0]+${esc_2d}\${FUNCNAME[0]}()${xse}}"
                                            # function name (if applicable)
PS4+="${esc_null}"                          # reset

# -----------------------------------------------------------------------------
# print a red "^C" when a command is aborted
# (.inputrc should have "set echo-control-characters off")
# -----------------------------------------------------------------------------

trap 'echo -ne "${colour_false}^C${null}"' INT

# -----------------------------------------------------------------------------
# $PROMPT_COMMAND
# -----------------------------------------------------------------------------

addPromptCmd()
{   # append (or prepend with -p) to $PROMPT_COMMAND, avoiding duplicates
    [[ $1 = "-p" ]] && {
        declare pre=true
        shift
    }

    declare newCmd="$@"

    if [[ ! $PROMPT_COMMAND =~ $newCmd ]]; then
        if [[ $pre == true ]]; then
            PROMPT_COMMAND="${newCmd}${PROMPT_COMMAND:+; }${PROMPT_COMMAND}"
        else
            PROMPT_COMMAND+="${PROMPT_COMMAND:+; }${newCmd}"
        fi
    fi

    return 0
}

addPromptCmd -p PS1_print_exit

addPromptCmd PS1_update_iTerm

_isFunction PS1_update_Terminal &&
	addPromptCmd PS1_update_Terminal

[[ $TERM =~ xterm|rxvt|putty|screen|cygwin ]] &&
    addPromptCmd PS1_update_wintitle
