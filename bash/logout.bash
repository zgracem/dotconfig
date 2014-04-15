# -----------------------------------------------------------------------------
# ~zozo/.config/bash/logout                                  executed on logout
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# revoke sudo privileges
[[ $(who | grep -ch "^$USER\>") -le 1 ]] && {
    _inPath sudo && sudo -k
}

# # clear screen
# [[ $SHLVL -eq 1 ]] && {
#     _inPath clear && clear
# }
