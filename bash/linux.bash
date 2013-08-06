# -----------------------------------------------------------------------------
# ~zozo/.config/bash/linux                         executed if $OSTYPE = linux*
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

[[ $OSTYPE =~ linux ]] || {
    printf "%s: Cannot source on this OS\n" "$(basename ${BASH_SOURCE[0]} .sh)" 1>&2
    return 1
}

# -----------------------------------------------------------------------------

# nothing here (yet) b/c I don't use plain Linux much (yet)
