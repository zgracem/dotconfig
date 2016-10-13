[[ $OSTYPE == cygwin ]] || return

# -----------------------------------------------------------------------------
# aliases
# -----------------------------------------------------------------------------

# be like macOS
open() { cygstart "$@"; }
alias emptytrash='command -p rm -rf ~/.Trash/* 1>/dev/null'
