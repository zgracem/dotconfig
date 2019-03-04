# -----------------------------------------------------------------------------
# final initialization script
# sourced at the end of ~/.bashrc
# -----------------------------------------------------------------------------

if [[ -d $HOME/scripts ]]; then
  # cute login banner
  "$HOME/scripts/login/loginbanner.sh"

  # astronomical info 
  # -- requires suncalc and weather_ca gems
  # -- runs only on first login of the day
  if [[ $HOSTNAME == Athena* ]] && "$HOME/scripts/login/matins.sh"; then
    "$HOME/scripts/login/astro.rb"
  fi
fi
