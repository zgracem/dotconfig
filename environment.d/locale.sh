# -----------------------------------------------------------------------------
# Localization: Canadian English, UTF-8
# -----------------------------------------------------------------------------

if [ -z "$LANGUAGE" ]; then
  export LANGUAGE='en_CA:en_US:en'
fi

# LANG: used as a substitute for any unset LC_* variable.
# Some systems have 'en_CA.UTF-8', some have 'en_CA.utf8' -- search locales
# to find whichever is available, and cache the result.
lang_file="$XDG_DATA_HOME/locale/LANG"

if [ -f "$lang_file" ] && [ -z "$LANG" ]; then
  read -r LANG < "$lang_file"
fi

unset -v lang_file

if [ -z "$LC_ALL" ]; then
  export LC_ALL="$LANG" # overrides the above (in most cases)
fi

# time zone
if [ -z "$TZ" ]; then
  export TZ='America/Edmonton'
fi

if [ -z "$TIME_STYLE" ]; then
  export TIME_STYLE='long-iso'
fi
