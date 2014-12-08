# -----------------------------------------------------------------------------
# cygwin
# -----------------------------------------------------------------------------

if ! [[ $OSTYPE =~ cygwin ]]; then
    return
fi

# -----------------------------------------------------------------------------
# shell variables
# ------------------------------------------------------------------------------

# don't warn on using MS-DOS-style paths instead of POSIX-style
if ! [[ $CYGWIN =~ dosfilewarning ]]; then
    CYGWIN="${CYGWIN+$CYGWIN }nodosfilewarning"
fi

# create Windows-native symlinks when possible
if ! [[ $CYGWIN =~ winsymlinks ]]; then
    CYGWIN="${CYGWIN+$CYGWIN }winsymlinks:native"
fi

# use gdb debugger for when faults occur
if ! [[ $CYGWIN =~ error_start ]]; then
    CYGWIN="${CYGWIN+$CYGWIN }error_start=gdb -nw %1 %2"
fi

# # generate real core dumps instead
# if ! [[ $CYGWIN =~ error_start ]]; then
#     CYGWIN="${CYGWIN+$CYGWIN }error_start=dumper -d %1 %2"
# fi

# do not consider DLLs executable for completion purposes
export EXECIGNORE='*.dll'

# -----------------------------------------------------------------------------
# printer
# -----------------------------------------------------------------------------

printer_key='/proc/registry/HKEY_CURRENT_USER/Software/Microsoft/Windows NT/CurrentVersion/Windows/Device'

if [[ -z $PRINTER && -e $printer_key ]]; then
    read -r PRINTER < "$printer_key"
    export PRINTER="${PRINTER%%,*}"
fi

unset -v printer_key

# -----------------------------------------------------------------------------
# aliases (TODO: move these around)
# -----------------------------------------------------------------------------

alias eject="${SYSTEMROOT}/system32/rundll32 shell32.dll,Control_RunDLL hotplug.dll"

# be like OS X
alias open='cygstart'
alias emptytrash='command -p rm -rf ~/.Trash/* 1>/dev/null'
