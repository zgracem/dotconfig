[[ $OSTYPE =~ darwin ]] || return

unquar() { xattr -d -r com.apple.quarantine "$@"; }
