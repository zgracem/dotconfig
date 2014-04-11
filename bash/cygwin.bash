# -----------------------------------------------------------------------------
# ~zozo/.config/bash/cygwin                         executed if $OSTYPE = cygwin
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

[[ $OSTYPE =~ cygwin ]] || {
    scold "${BASH_SOURCE[0]}" "cannot source on this OS"
    return 1
}

# -----------------------------------------------------------------------------
# shell variables
# ------------------------------------------------------------------------------

# create Windows-native symlinks when possible
if [[ ! $CYGWIN =~ winsymlinks ]]; then
	export CYGWIN="$CYGWIN${CYGWIN+ }winsymlinks:native"
fi

# do not consider DLLs executable for completion purposes
export EXECIGNORE="*.dll"

# use the short name of programs when Tab-completing
shopt -s completion_strip_exe

# -----------------------------------------------------------------------------
# aliases
# -----------------------------------------------------------------------------

alias cpcd='cygpath -aw "$PWD" > /dev/clipboard'
alias eject="$SYSTEMROOT/system32/rundll32 shell32.dll,Control_RunDLL hotplug.dll"

alias tar="/usr/bin/bsdtar"

# be like OS X
alias open='cygstart'
alias pbcopy='cat > /dev/clipboard '
alias pbpaste='cat /dev/clipboard'

alias emptytrash='command -p rm -rf ~/.Trash/* 1>/dev/null'
alias mdclip='~/bin/Markdown.pl /dev/clipboard > /dev/clipboard'
alias sp='ff'
