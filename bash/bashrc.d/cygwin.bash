[[ $OSTYPE =~ cygwin ]] || return

# if we have Windows admin privileges, we will be a member of group 544 or 0
for group in "${GROUPS[@]}"; do
    if [[ $group =~ ^(0|544)$ ]]; then
        export CYGWIN_ADMIN=true
        break
    fi
done

unset group

# -----------------------------------------------------------------------------
# shell variables
# ------------------------------------------------------------------------------

# create Windows-native symlinks (if we have admin privileges)
if ! [[ $CYGWIN =~ winsymlinks ]]; then
    if [[ $CYGWIN_ADMIN == true ]]; then
        CYGWIN="${CYGWIN+$CYGWIN }winsymlinks:nativestrict"
    else
        # no admin privileges; create .lnk files instead
        CYGWIN="${CYGWIN/winsymlinks:native/winsymlinks:lnk}"
    fi
fi

# don't warn on using MS-DOS-style paths instead of POSIX-style
if ! [[ $CYGWIN =~ dosfilewarning ]]; then
    CYGWIN="${CYGWIN+$CYGWIN }nodosfilewarning"
fi

# file extensions considered "executable" by cmd.com (minimal set)
: ${PATHEXT:=".COM;.EXE;.BAT"}

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
# aliases
# -----------------------------------------------------------------------------

alias eject="$SYSTEMROOT/system32/rundll32 shell32.dll,Control_RunDLL hotplug.dll"

# be like OS X
open() { cygstart "$@"; }
alias emptytrash='command -p rm -rf ~/.Trash/* 1>/dev/null'
