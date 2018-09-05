# -----------------------------------------------------------------------------
# Menu bar items
# -----------------------------------------------------------------------------

extras_dir="/System/Library/CoreServices/Menu Extras"

defaults delete com.apple.SystemUIServer menuExtras

defaults write com.apple.SystemUIServer menuExtras -array-add "$extras_dir/Displays.menu"
defaults write com.apple.SystemUIServer menuExtras -array-add "$extras_dir/Bluetooth.menu"
defaults write com.apple.SystemUIServer menuExtras -array-add "$extras_dir/AirPort.menu"
defaults write com.apple.SystemUIServer menuExtras -array-add "$extras_dir/Volume.menu"

if [[ $HARDWARE == MacBook* ]]; then
  defaults write com.apple.SystemUIServer menuExtras -array-add "$extras_dir/Battery.menu"
fi

defaults write com.apple.SystemUIServer menuExtras -array-add "$extras_dir/Clock.menu"
defaults write com.apple.SystemUIServer menuExtras -array-add "$extras_dir/TimeMachine.menu"
defaults write com.apple.SystemUIServer menuExtras -array-add "$extras_dir/VPN.menu"

if (( MACOS_VERSION >= 12 )); then
  defaults write com.apple.SystemUIServer "NSStatusItem Visible com.apple.menuextra.airplay" -bool true
  defaults write com.apple.SystemUIServer "NSStatusItem Visible com.apple.menuextra.bluetooth" -bool true
  defaults write com.apple.SystemUIServer "NSStatusItem Visible com.apple.menuextra.airport" -bool true
  defaults write com.apple.SystemUIServer "NSStatusItem Visible com.apple.menuextra.volume" -bool true

  if [[ $HARDWARE == MacBook* ]]; then
    defaults write com.apple.SystemUIServer "NSStatusItem Visible com.apple.menuextra.battery" -bool true
  fi

  defaults write com.apple.SystemUIServer "NSStatusItem Visible com.apple.menuextra.clock" -bool true
  defaults write com.apple.SystemUIServer "NSStatusItem Visible com.apple.menuextra.TimeMachine" -bool true
  defaults write com.apple.SystemUIServer "NSStatusItem Visible com.apple.menuextra.vpn" -bool true

  defaults write com.apple.Siri StatusMenuVisible -bool true
  defaults write com.apple.SystemUIServer "NSStatusItem Visible Siri" -bool true
fi

unset -v extras_dir
