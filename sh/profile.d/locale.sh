# -----------------------------------------------------------------------------
# localization: Canadian English, UTF-8
# -----------------------------------------------------------------------------

LANGUAGE='en_CA:en'

# grep available locales to find 'en_CA.UTF-8' or 'en_CA.utf8'
if test -z $LANG; then
    LANG="`locale -a 2>/dev/null | grep -Ei 'en_CA\.utf-?8'`"
fi

# LC_COLLATE="$LANG"  # collation information for regular expressions and sorting
# LC_CTYPE="$LANG"    # character type and classification information
# LC_MESSAGES="$LANG" # conventions for messages, incl. yes/no responses
# LC_MONETARY="$LANG" # money-related numeric formatting
# LC_NUMERIC="$LANG"  # other numeric formatting (e.g. thousands separator)
# LC_TIME="$LANG"     # date and time formatting
LC_ALL="$LANG"      # overrides the above (in most cases)

# time zone
TZ='America/Edmonton'

export LANG LANGUAGE TZ \
    LC_COLLATE LC_CTYPE LC_MESSAGES LC_MONETARY LC_NUMERIC LC_TIME LC_ALL
