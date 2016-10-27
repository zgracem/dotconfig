[ "$OSTYPE" = "cygwin" ] || return

# If we have Windows admin privileges, we will be a member of group 544 or 0
for g in `id -G`; do
  if [ "$g" -eq 0 ] || [ "$g" -eq 544 ]; then
    export CYGWIN_ADMIN=true
    break
  fi
done

unset -v g

# -----------------------------------------------------------------------------
# shell variables
# ------------------------------------------------------------------------------

# create Windows-native symlinks (if we have admin privileges)
if [ "${CYGWIN#*winsymlinks}" = "$CYGWIN" ]; then
  if [ "$CYGWIN_ADMIN" = true ]; then
    CYGWIN="${CYGWIN+$CYGWIN }winsymlinks:nativestrict"
  else
    # no admin privileges; create .lnk files instead
    CYGWIN="${CYGWIN+$CYGWIN }winsymlinks:lnk"
  fi
fi

# don't warn on using MS-DOS-style paths instead of POSIX-style
if [ "${CYGWIN#*dosfilewarning}" = "$CYGWIN" ]; then
  CYGWIN="${CYGWIN+$CYGWIN }nodosfilewarning"
fi

export CYGWIN
