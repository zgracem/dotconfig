# -----------------------------------------------------------------------------
# final initialization script
# sourced at the end of ~/.bashrc
# -----------------------------------------------------------------------------

if [[ -d $dir_scripts ]]; then
  # cute banner
  "$dir_scripts/login/loginbanner.sh"

  # astronomical info 
  # -- requires suncalc and weather_ca gems
  # -- runs only on first login of the day
  if [[ $HOSTNAME == Athena* ]] && "$dir_scripts/login/matins.sh"; then
    "$dir_scripts/login/astro.rb"
  fi
fi
