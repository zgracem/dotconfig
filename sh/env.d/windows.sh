[ "$PLATFORM" = "windows" ] || return

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

# OSTYPE is not defined in POSIX
# shellcheck disable=SC2039
if [ "$OSTYPE" = "cygwin" ]; then
  export CYGWIN
elif [ "$OSTYPE" = "msys" ]; then
  export MSYS="$CYGWIN"
  unset -v CYGWIN
fi
