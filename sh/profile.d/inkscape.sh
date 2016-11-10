if command -v inkscape >/dev/null; then
  # defaults to ~/.config/inkscape
  export INKSCAPE_PROFILE_DIR="$XDG_DATA_HOME/inkscape"
fi
