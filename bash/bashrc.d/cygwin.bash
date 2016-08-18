[[ $OSTYPE =~ cygwin ]] || return

# If we have Windows admin privileges, we will be a member of group 544 or 0
export CYGWIN_ADMIN=false

for group in "${GROUPS[@]}"; do
  if [[ $group == @(0|544) ]]; then
    CYGWIN_ADMIN=true
    break
  fi
done

unset -v group

# -----------------------------------------------------------------------------
# shell variables
# ------------------------------------------------------------------------------

# create Windows-native symlinks (if we have admin privileges)
if ! [[ $CYGWIN =~ winsymlinks ]]; then
  if [[ $CYGWIN_ADMIN == true ]]; then
    CYGWIN="${CYGWIN+$CYGWIN }winsymlinks:nativestrict"
  else
    # no admin privileges; create .lnk files instead
    CYGWIN="${CYGWIN+$CYGWIN }winsymlinks:lnk"
  fi
fi

# don't warn on using MS-DOS-style paths instead of POSIX-style
if ! [[ $CYGWIN =~ dosfilewarning ]]; then
  CYGWIN="${CYGWIN+$CYGWIN }nodosfilewarning"
fi

# file extensions considered "executable" by cmd.com (minimal set)
: ${PATHEXT:=".COM;.EXE;.BAT"}

# disable logging by Windows' Component Servicing Infrastructure
export windows_tracing_flags=0

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

# be like macOS
open() { cygstart "$@"; }
alias emptytrash='command -p rm -rf ~/.Trash/* 1>/dev/null'

# -----------------------------------------------------------------------------
# cleanup
# -----------------------------------------------------------------------------

export CYGWIN 
unset -v CYGWIN_ADMIN
