# -----------------------------------------------------------------------------
# Software Update/App Store
# -----------------------------------------------------------------------------

# Enable automatic update checks
defaults write com.apple.SoftwareUpdate AutomaticCheckEnabled -bool true

# Check for updates every day
defaults write com.apple.SoftwareUpdate ScheduleFrequency -int 1

# Download newly available updates in background
defaults write com.apple.SoftwareUpdate AutomaticDownload -int 1

# Install System data files & security updates
defaults write com.apple.SoftwareUpdate CriticalUpdateInstall -int 1

# Automatically download apps purchased on other Macs
defaults write com.apple.SoftwareUpdate ConfigDataInstall -int 1

# Turn off app auto-update
defaults write com.apple.commerce AutoUpdate -bool false

# Don't allow the App Store to reboot machine on macOS updates
defaults write com.apple.commerce AutoUpdateRestartRequired -bool false
