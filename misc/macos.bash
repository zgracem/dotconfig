#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# zozo's macOS configuration script
# Adapted from https://mths.be/macos
#          and https://github.com/herrbischoff/awesome-osx-command-line
# -----------------------------------------------------------------------------
# Configuration & setup
# -----------------------------------------------------------------------------

computer_name=

# Ask for the administrator password up front
sudo -v || exit

# Keep existing `sudo` timestamp up to date until script has finished
while true; do
  sudo -n true; sleep 60
  kill -0 "$$" || exit
done 2>/dev/null &

# Set helpful variables
HARDWARE=$(sysctl -n hw.model)
MACOS_VERSINFO=($(sw_vers -productVersion | tr "." " "; sw_vers -buildVersion))
MACOS_VERSION=${MACOS_VERSINFO[1]}

export HARDWARE MACOS_VERSINFO MACOS_VERSION

# -----------------------------------------------------------------------------
# Load preferences
# -----------------------------------------------------------------------------

source_dir=$(mdutil -t "${BASH_SOURCE[0]%/*}/macos")

shopt -s extglob nullglob

for pref in "${source_dir}"/*.bash; do
  [[ -f $pref ]] && echo "${pref}"
done

# -----------------------------------------------------------------------------
# Kill affected applications
# -----------------------------------------------------------------------------

declare -a apps=(
  "Activity Monitor"
  "cfprefsd"
  "Dock"
  "Finder"
  "Google Chrome"
  "iTunes"
  "Mail"
  "mds"
  "Messages"
  "Photos"
  "Safari"
  "SystemUIServer"
  "Terminal"
  "Transmission"
  "TextEdit"
)

# for app in "${apps[@]}"; do
#   killall "$app" &>/dev/null
# done

echo "Done. Note that some of these changes require a logout/restart to take effect."
