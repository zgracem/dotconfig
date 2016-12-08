[ "$PLATFORM" = "windows" ] || return

# -----------------------------------------------------------------------------
# Shell variables
# ------------------------------------------------------------------------------

# If we have Windows admin privileges, we will be a member of group 544 or 0
for g in $(id -G); do
  if [ "$g" -eq 0 ] || [ "$g" -eq 544 ]; then
    export WINDOWS_ADMIN=true
    break
  fi
  unset -v WINDOWS_ADMIN
done

unset -v g

# File extensions considered "executable" by cmd.com (minimal set)
if [ -z "$PATHEXT" ]; then
  PATHEXT=".COM;.EXE;.BAT"
fi

# Disable logging by Windows' Component Servicing Infrastructure
export windows_tracing_flags=0

# -----------------------------------------------------------------------------
# Import/adjust settings from CYGWIN environment variable
# -----------------------------------------------------------------------------

# create Windows-native symlinks (if we have admin privileges)
if [ "${CYGWIN#*winsymlinks}" = "$CYGWIN" ]; then
  if [ "$WINDOWS_ADMIN" = true ]; then
    CYGWIN="${CYGWIN+$CYGWIN }winsymlinks:nativestrict"
  else
    # no admin privileges; create .lnk files instead
    CYGWIN="${CYGWIN+$CYGWIN }winsymlinks:lnk"
  fi
fi

# Don't warn on using MS-DOS-style paths instead of POSIX-style
if [ "${CYGWIN#*dosfilewarning}" = "$CYGWIN" ]; then
  CYGWIN="${CYGWIN+$CYGWIN }nodosfilewarning"
fi

if [ "$OSTYPE" = "cygwin" ]; then
  export CYGWIN
elif [ "$OSTYPE" = "msys" ]; then
  export MSYS="$CYGWIN"
  unset -v CYGWIN
fi

# -----------------------------------------------------------------------------
# Default printer
# -----------------------------------------------------------------------------

key="/proc/registry/HKEY_CURRENT_USER/Software/Microsoft/Windows NT/CurrentVersion/Windows/Device"

if [ -z "$PRINTER" ] && [ -e "$key" ]; then
  read -r PRINTER < "$key"
  export PRINTER="${PRINTER%%,*}"
fi

unset -v key
