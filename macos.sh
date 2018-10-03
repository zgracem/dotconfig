#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# macOS configuration script
# Adapted from https://mths.be/macos
#          and https://github.com/herrbischoff/awesome-osx-command-line
# -----------------------------------------------------------------------------
# Configuration & setup
# -----------------------------------------------------------------------------

# Close any open System Preferences panes, to prevent them from overriding
# settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# Ask for the administrator password up front
sudo -v || exit

# Keep existing `sudo` timestamp up to date until script has finished
while true; do
  sudo -n true; sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Set helpful variables
HARDWARE=$(sysctl -n hw.model)
mapfile -t DARWIN_VERSINFO < <(uname -r | tr '.' ' ')
mapfile -t MACOS_VERSINFO < <(sw_vers -productVersion | tr '.' ' ')

export HARDWARE DARWIN_VERSINFO MACOS_VERSINFO
export MACOS_VERSION=${MACOS_VERSINFO[1]}

if [[ -z ${MACOS_VERSINFO[2]} ]]; then
  # initial releases return e.g. "10.12" instead of "10.12.0"
  MACOS_VERSINFO[2]=0
fi

# -----------------------------------------------------------------------------
# Load preferences
# -----------------------------------------------------------------------------

source_dir=$(mdutil -t "${BASH_SOURCE[0]%/*}/macos.d")

shopt -s extglob nullglob

for pref in "${source_dir}"/*.bash; do
  [[ -f $pref ]] && . "${pref}"
done

# -----------------------------------------------------------------------------

echo "Done. Note that some of these changes require a logout/restart to take effect."
