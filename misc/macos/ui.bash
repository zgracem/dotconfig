# -----------------------------------------------------------------------------
# General UI/UX
# -----------------------------------------------------------------------------

# Hide the following menu items:
for domain in ~/Library/Preferences/ByHost/com.apple.SystemUIServer.*; do
    defaults write "${domain}" dontAutoLoad -array \
        "/System/Library/CoreServices/Menu Extras/Eject.menu" \
        "/System/Library/CoreServices/Menu Extras/TextInput.menu" \
        "/System/Library/CoreServices/Menu Extras/User.menu"
done

# Show the following menu items:
defaults write com.apple.SystemUIServer menuExtras -array \
    "/System/Library/CoreServices/Menu Extras/Displays.menu" \
    "/System/Library/CoreServices/Menu Extras/TimeMachine.menu" \
    "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
    "/System/Library/CoreServices/Menu Extras/AirPort.menu" \
    "/System/Library/CoreServices/Menu Extras/TextInput.menu" \
    "/System/Library/CoreServices/Menu Extras/Volume.menu" \
    "/System/Library/CoreServices/Menu Extras/Clock.menu"

# # Graphite, not Aqua
# defaults write -g AppleAquaColorVariant -int 6
# defaults write -g AppleHighlightColor -string '0.780400 0.815700 0.858800'

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
