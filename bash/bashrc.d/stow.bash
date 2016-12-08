_inPath stow || return

unstow() { command stow --delete "$@"; }
