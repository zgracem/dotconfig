# -----------------------------------------------------------------------------
# final initialization script
# sourced at the end of ~/.bashrc
# -----------------------------------------------------------------------------

# shellcheck disable=SC2154
if [[ -d $dir_scripts ]]; then
  # cute banner
  "$dir_scripts/login/loginbanner.sh"

  # astronomical info -- requires suncalc and weather_ca gems
  [[ $HOSTNAME == Athena* ]] && "$dir_scripts/login/astro.rb"

  # run only on first login of the day:
  if "$dir_scripts/login/matins.sh"; then
    # this day in history...
    "$dir_scripts/login/today_in_history.sh"
  fi
fi
