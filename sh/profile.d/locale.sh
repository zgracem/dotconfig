# -----------------------------------------------------------------------------
# Localization: Canadian English, UTF-8
# -----------------------------------------------------------------------------

if [ -z "$LANGUAGE" ]; then
  export LANGUAGE=en_CA # 'en_CA:en_US:en'
fi

if [ -z "$LANG" ]; then
  # Some systems have 'en_CA.UTF-8', some have 'en_CA.utf8' -- search locales
  # to find whichever is available.
  export LANG="$(locale -a 2>/dev/null | /usr/bin/grep -Ei "$LANGUAGE\.utf-?8")"
fi

if [ -z "$LC_ALL" ]; then
  # LC_COLLATE="$LANG"  # collation information for regular expressions and sorting
  # LC_CTYPE="$LANG"    # character type and classification information
  # LC_MESSAGES="$LANG" # conventions for messages, incl. yes/no responses
  # LC_MONETARY="$LANG" # money-related numeric formatting
  # LC_NUMERIC="$LANG"  # other numeric formatting (e.g. thousands separator)
  # LC_TIME="$LANG"     # date and time formatting
  export LC_ALL="$LANG" # overrides the above (in most cases)
fi

# time zone
if [ -z "$TZ" ]; then
  export TZ='America/Edmonton'
fi
