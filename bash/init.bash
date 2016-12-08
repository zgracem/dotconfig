# -----------------------------------------------------------------------------
# final initialization script
# sourced at the end of ~/.bashrc
# -----------------------------------------------------------------------------

if [[ -d $dir_scripts ]]; then
  # cute banner
  "$dir_scripts/login/loginbanner.sh"

  # run only on first login of the day:
  if "$dir_scripts/login/matins.sh"; then
    # astronomical info -- requires suncalc and weather_ca gems
    [[ $HOSTNAME == Athena* ]] && "$dir_scripts/login/astro.rb"

    # this day in history...
    "$dir_scripts/login/today_in_history.sh"
  fi
fi

# countdown (date & function set in private.d/countdown.bash)
_isFunction liz && liz

# print bash version if not the latest release (variables set in bashrc.bash)
if (( this_bash < latest_bash )) || [[ -n $newer_bash ]] \
  || [[ ${BASH_VERSINFO[4]} != "release" ]]\
  || [[ $BASH != $SHELL ]]; then
  printf 'GNU bash, version %s (%s)\n' "$BASH_VERSION" "$MACHTYPE"
fi
