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
for index in $colours ${!colour_*}; do
    eval "esc_${index#*_}=\"\[${!index}\]\""
    unset index
done

export ${!esc_*}

# -----------------------------------------------------------------------------
# prompts -- see ~/.config/bash/colours.bash
# -----------------------------------------------------------------------------

unset PS1 PS2 PS4

PS1+="${esc_2d}${HOSTNAME}${esc_null}:" # hostname, muted
PS1+="${esc_hi}\$(pwdTrim)${esc_null} " # current path, highlighted
PS1+="${esc_user}\\\$${esc_null} "      # blue $ for me, red # for root

PS2+="${esc_hi}"$'\xC2\xBB'"${esc_null} " # bright white right guillemet

PS4+="${esc_blue}\${LINENO}${esc_null} "
PS4+="${esc_hi}+${esc_null} "

export PS{1..4}

# -----------------------------------------------------------------------------
# $PROMPT_COMMAND -- see ~/.config/bash/functions/prompt.bash
# -----------------------------------------------------------------------------

addPromptCmd -p printExit

[[ $TERM =~ xterm|rxvt|putty|screen|cygwin ]] && {
    addPromptCmd updateWindowTitle
}
