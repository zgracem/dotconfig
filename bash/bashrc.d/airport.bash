# -----------------------------------------------------------------------------
# AirPort utilities
# -----------------------------------------------------------------------------

[[ $OSTYPE =~ darwin ]] || return

# AirPort card (e.g. en1)
if [[ -z $netcard ]]; then
    netcard=$(scutil <<< "list" \
        | sed -nE 's#^.*Setup:/Network/Interface/(en[[:digit:]])/AirPort$#\1#p')
fi
