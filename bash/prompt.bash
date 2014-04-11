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
for index in ${colours[@]}; do
    eval "esc_${index#*_}=\"\[${!index}\]\""
    unset index
done

export ${!esc_*}

# -----------------------------------------------------------------------------
# functions
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

pwdTrim()
{   # fancy PWD display function
    declare leader=".."
    declare max=$((COLUMNS/4))      # maximum length of displayed path
    declare dir=${PWD##*/}          # basename of current dir

    # if basename of $PWD is too long by itself, don't trim it
    max=$(( (max < ${#dir}) ? ${#dir} : max ))

    _PWD="${PWD/#$HOME/~}"          # tilde-ify homedir

    # if $PWD is too long, by how much?
    declare offset=$(( ${#_PWD} - max ))
    [[ ${offset} -gt 0 ]] && {
        _PWD="${_PWD:$offset:$max}" # cut to $max chars long
        _PWD="${_PWD#*/}"           # clean up any leading detritus
        _PWD="${leader}/${_PWD}"    # show that it's been trimmed
    }

    echo -n "${_PWD}"
}

printExit()
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

update_iTerm()
{   # notify iTerm of the current directory
	# http://code.google.com/p/iterm2/wiki/ProprietaryEscapeCodes

    printf "%b%s%b" "\e]50;" "CurrentDir=$PWD" "\a"
}

# tell Terminal.app about the working directory at each prompt.
[[ $TERM_PROGRAM == "Apple_Terminal" ]] && {
    [[ $TMUX ]] && {
        # ANSI device control string
        tmuxEscAnte="\ePtmux;\e"
        tmuxEscPost="\e\\"
    }

    update_Terminal()
    {   # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.

        declare pwdURL="file://${HOSTNAME}${PWD// /%20}"
        printf '%b\e]7;%b\a%b' "$tmuxEscAnte" "$pwdURL" "$tmuxEscPost"
    }
}

# -----------------------------------------------------------------------------
# prompts -- see colours.bash
# -----------------------------------------------------------------------------

unset PS{1..4}

# primary prompt
PS1+="${esc_2d}${HOSTNAME}:"                # hostname, muted
PS1+="${esc_hi}\$(pwdTrim) "                # current path, highlighted
PS1+="${esc_user}\\\$${esc_null} "          # blue $ for me, red # for root

# secondary prompt (for multi-line commands)
PS2+="${esc_hi}"$'\xC2\xBB'"${esc_null} "   # bright white right guillemet

# `select` prompt
PS3+="${esc_blue}?${esc_null} "

# prefix for xtrace output
PS4+="${esc_green}\${BASH_SOURCE##*/}"      # green filename
PS4+="${esc_hi}:${esc_yellow}\${LINENO}"    # yellow line number
PS4+="${esc_hi}:${esc_null}"                # colon separator
PS4+="\${FUNCNAME[0]:+\${FUNCNAME[0]}():}"  # function name (if applicable)

export PS{1..4}

# -----------------------------------------------------------------------------
# print a red "^C" when a command is aborted
# -----------------------------------------------------------------------------

trap 'echo -ne "${colour_false}^C${null}"' INT

# -----------------------------------------------------------------------------
# $PROMPT_COMMAND
# -----------------------------------------------------------------------------

addPromptCmd -p printExit

addPromptCmd update_iTerm

_isFunction update_Terminal &&
	addPromptCmd update_Terminal

# see functions/title.bash
[[ $TERM =~ xterm|rxvt|putty|screen|cygwin ]] &&
    addPromptCmd updateWindowTitle
