export ATOM_HOME="${XDG_DATA_HOME:-~/.local/share}/atom"

if [ ! -d "$ATOM_HOME" ]; then
  mkdir -p "$ATOM_HOME"
fi
