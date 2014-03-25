# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/prompt.bash
# ------------------------------------------------------------------------------

addPromptCmd()
{   # append (or prepend with -p) to $PROMPT_COMMAND, avoiding duplicates
    [[ $1 = "-p" ]] && {
        declare pre=true
        shift
    }

    declare newCmd="$1"

    [[ ! $PROMPT_COMMAND =~ $newCmd ]] && {
        [[ $pre == true ]] && {
            PROMPT_COMMAND="${newCmd}${PROMPT_COMMAND:+; }${PROMPT_COMMAND}"
        } || {
            PROMPT_COMMAND+="${PROMPT_COMMAND:+; }${newCmd}"
        }
    }
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

iTermUpdate()
{   # notify iTerm of the current directory
    printf "%b%s%b" "\e]50;" "CurrentDir=$PWD" "\a"
}

# tell Terminal.app about the working directory at each prompt.
[[ $TERM_PROGRAM == "Apple_Terminal" ]] && {
    [[ $TMUX ]] && {
        # ANSI device control string
        tmuxEscAnte="\ePtmux;\e"
        tmuxEscPost="\e\\"
    }

    update_terminal_cwd()
    {   # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.

        declare SEARCH=' '
        declare REPLACE='%20'
        declare PWD_URL="file://${HOSTNAME}${PWD//$SEARCH/$REPLACE}"

        declare escAnte="\e]2;"

        printf '%b\e]7;%b\a%b' "$tmuxEscAnte" "$PWD_URL" "$tmuxEscPost"
    }

    addPromptCmd update_terminal_cwd
}
