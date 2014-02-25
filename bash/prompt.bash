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
# prompts -- see ~/.config/bash/colours.bash
# -----------------------------------------------------------------------------

unset PS1 PS2 PS4

PS1+="${esc_2d}${HOSTNAME}:"                # hostname, muted
PS1+="${esc_hi}\$(pwdTrim) "                # current path, highlighted
PS1+="${esc_user}\\\$${esc_null} "          # blue $ for me, red # for root

PS2+="${esc_hi}"$'\xC2\xBB'"${esc_null} "   # bright white right guillemet

PS4+="${esc_green}\${BASH_SOURCE##*/}"      # green filename
PS4+="${esc_hi}:${esc_yellow}\${LINENO}"    # yellow line number
PS4+="${esc_hi}:${esc_null}"                # colon separator
PS4+="\${FUNCNAME[0]:+\${FUNCNAME[0]}():}"  # function name (if applicable)

export PS{1..4}

# -----------------------------------------------------------------------------
# fires when a command is aborted with Ctrl+C
# -----------------------------------------------------------------------------

trap 'echo -ne "${colour_false}^C${null}"' INT

# -----------------------------------------------------------------------------
# $PROMPT_COMMAND -- see ~/.config/bash/functions/prompt.bash
# -----------------------------------------------------------------------------

addPromptCmd -p printExit

[[ $TERM =~ xterm|rxvt|putty|screen|cygwin ]] && {
    addPromptCmd updateWindowTitle
}
