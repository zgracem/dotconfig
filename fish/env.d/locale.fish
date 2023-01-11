# -----------------------------------------------------------------------------
# Localization: Canadian English, UTF-8
# -----------------------------------------------------------------------------

set -q LANGUAGE
or set -gx --path LANGUAGE en_CA en_US en

# LANG: used as a substitute for any unset LC_* variable.
# Some systems have 'en_CA.UTF-8', some have 'en_CA.utf8'
# Search locales to find whichever is available, and cache the result.
set -l lang_file $XDG_CACHE_HOME/locale/LANG

if not path is -f $lang_file
    mkdir -pv (dirname $lang_file)
    set -l lang $LANGUAGE[1]
    locale -a 2>/dev/null | string match -ir $lang"\.utf-?8\$" >"$lang_file"
end

set -q LANG; or read -gx LANG <"$lang_file"
set -q LC_ALL; or set -gx LC_ALL "$LANG"

# ----------------------------------------------------------------------------

set -q TIME_STYLE; or set -gx TIME_STYLE long-iso
set -q TZ; or set -gx TZ America/Edmonton
if not set -q TZDIR[1]
    switch $PLATFORM
    case macOS
        set -gx TZDIR /var/db/timezone/zoneinfo
    case Cygwin Linux
        set -gx TZDIR /usr/*/zoneinfo
    end
end
