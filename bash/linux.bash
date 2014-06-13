# -----------------------------------------------------------------------------
# ~zozo/.config/bash/linux                         executed if $OSTYPE = linux*
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

if [[ ! $OSTYPE =~ linux ]]; then
    scold "${BASH_SOURCE[0]}" "cannot source on this OS"
    return 1
fi

# -----------------------------------------------------------------------------

# nothing here (yet) b/c I don't use plain Linux much (yet)
