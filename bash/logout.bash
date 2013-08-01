# -----------------------------------------------------------------------------
# ~zozo/.config/bash/logout                                  executed on logout
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# revoke sudo privileges
[[ $(who | grep -c "^$USER\>") -le 1 ]] && {
    hash sudo &>/dev/null
    sudo -k &>/dev/null
}

# clear screen
[[ $SHLVL -eq 1 ]] && {
    hash clear 2>/dev/null &&
        : clear
}
