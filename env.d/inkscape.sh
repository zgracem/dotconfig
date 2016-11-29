INKSCAPE_PROFILE_DIR="$XDG_DATA_HOME/inkscape" # defaults to ~/.config/inkscape

if command -v inkscape >/dev/null; then
  export INKSCAPE_PROFILE_DIR
else
  unset -v INKSCAPE_PROFILE_DIR
fi
