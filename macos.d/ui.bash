# -----------------------------------------------------------------------------
# General UI/UX
# -----------------------------------------------------------------------------

# Expand save panel by default
defaults write -g NSNavPanelExpandedStateForSaveMode  -bool true
defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

# Expand print panel by default
defaults write -g PMPrintingExpandedStateForPrint  -bool true
defaults write -g PMPrintingExpandedStateForPrint2 -bool true

# Username and password fields at login instead of user badges
sudo defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true

# Set sidebar icon size to small
defaults write -g NSTableViewDefaultSizeMode -int 1

# Increase window resize speed for Cocoa applications
defaults write -g NSWindowResizeTime -float 0.001

# Disable the over-the-top focus ring animation
defaults write -g NSUseAnimatedFocusRing -bool false

# Disable transparency in the menu bar and elsewhere on Yosemite
if (( MACOS_VERSION >= 10 )); then
  defaults write com.apple.universalaccess reduceTransparency -bool true
fi

# Enable subpixel font rendering on non-Apple LCDs
defaults write -g AppleFontSmoothing -int 2

# Enable HiDPI display modes (requires restart)
sudo defaults write /Library/Preferences/com.apple.windowserver DisplayResolutionEnabled -bool true
