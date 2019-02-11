# -----------------------------------------------------------------------------
# final initialization script
# sourced at the end of ~/.bashrc
# -----------------------------------------------------------------------------

if [[ -d $dir_scripts ]]; then
  # cute banner
  "$dir_scripts/login/loginbanner.sh"

  # astronomical info -- requires suncalc and weather_ca gems
  [[ $HOSTNAME == Athena* ]] && "$dir_scripts/login/astro.rb"
fi
