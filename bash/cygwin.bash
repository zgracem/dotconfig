# -----------------------------------------------------------------------------
# ~zozo/.config/bash/cygwin                         executed if $OSTYPE = cygwin
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

if [[ ! $OSTYPE =~ cygwin ]]; then
    scold "${BASH_SOURCE[0]}" 'cannot source on this OS'
    return 1
fi

# -----------------------------------------------------------------------------
# shell variables
# ------------------------------------------------------------------------------

# add Windows's %PATH% if available
if [[ -n $ORIGINAL_PATH ]]; then
	PATH=$PATH:$ORIGINAL_PATH
fi

# don't warn on using MS-DOS-style paths instead of POSIX-style
if [[ ! $CYGWIN =~ dosfilewarning ]]; then
    CYGWIN="${CYGWIN+$CYGWIN }nodosfilewarning"
fi

# create Windows-native symlinks when possible
if [[ ! $CYGWIN =~ winsymlinks ]]; then
    CYGWIN="${CYGWIN+$CYGWIN }winsymlinks:native"
fi

# do not consider DLLs executable for completion purposes
export EXECIGNORE='*.dll'

# use the short name of programs when Tab-completing
shopt -s completion_strip_exe

# define default printer

pkey='/proc/registry/HKEY_CURRENT_USER/Software/Microsoft/Windows NT/CurrentVersion/Windows/Device'

if [[ -z $PRINTER && -e $pkey ]]; then
    read -r PRINTER < "$pkey"
    export PRINTER="${PRINTER%%,*}"
fi

unset pkey

# -----------------------------------------------------------------------------
# aliases
# -----------------------------------------------------------------------------

alias cpcd='cygpath -aw "$PWD" | tr -d "\n" | putclip'
alias eject="${SYSTEMROOT}/system32/rundll32 shell32.dll,Control_RunDLL hotplug.dll"

alias tar='/usr/bin/bsdtar'

# be like OS X
alias open='cygstart'
alias pbcopy='putclip '
alias pbpaste='getclip '

alias hide='"${SYSTEMROOT}/system32/attrib" +H'
alias unhide='"${SYSTEMROOT}/system32/attrib" -H'

alias emptytrash='command -p rm -rf ~/.Trash/* 1>/dev/null'
alias mdclip='getclip | ~/bin/Markdown.pl | putclip'
alias sp='ff'
