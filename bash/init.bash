# -----------------------------------------------------------------------------
# final initialization script
# sourced at the end of ~/.bashrc
# -----------------------------------------------------------------------------

# cute login banner
if [[ -x $dir_scripts/loginbanner.sh ]]; then
    "${dir_scripts}/loginbanner.sh"
fi

# this day in history...
if [[ -x $dir_scripts/matins.sh ]]; then
    "${dir_scripts}/matins.sh"
fi

# countdown (date & function set in private.d/countdown.bash)
_isFunction liz && liz

# print bash version if it's not the latest release
this_bash="${BASH_VERSINFO[0]}${BASH_VERSINFO[1]}"
latest_bash=44

if (( this_bash < latest_bash )) || [[ ${BASH_VERSINFO[4]} != "release" ]]; then
  printf 'GNU bash, version %s (%s)\n' "$BASH_VERSION" "$MACHTYPE"
fi

unset -v latest_bash this_bash
