_inPath exa || return

unalias ls ll 2>/dev/null
unset -f ls ll lsf

exa() { command exa "$@"; }

ls() { exa --all "$@"; }

ll() { ls --long --time-style=long-iso "$@"; }

lsf() { ll --group --inode --extended "$@"; }
