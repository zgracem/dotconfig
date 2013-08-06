# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/misc.bash
# ------------------------------------------------------------------------------

ssaver()
{   # very serious-looking screensaver of nonsense
    cat /dev/urandom |
    hexdump -C |
    grep --color=auto 'c9 1f'
}

div()
{   # print a bright divider across the terminal
    declare colour line=" " p="="

    printf -v line '%*s' $COLUMNS

    printf "\n${colour_hi}${line// /$p}${colour_reset}\n\n"
}
