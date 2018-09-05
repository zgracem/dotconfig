# -----------------------------------------------------------------------------
# Dock & hot corners
# -----------------------------------------------------------------------------

# Set the icon size of Dock items to 64 pixels
defaults write com.apple.Dock tilesize -int 64

# Change minimize/maximize window effect
defaults write com.apple.dock mineffect -string "scale"

# Minimize windows into their application’s icon
defaults write com.apple.dock minimize-to-application -bool true

# Don't animate opening applications from the Dock
defaults write com.apple.Dock launchanim -bool false

# Show indicator lights for open applications in the Dock
defaults write com.apple.Dock show-process-indicators -bool true

# # Automatically hide and show the Dock
# defaults write com.apple.Dock autohide -bool true

# # Remove the auto-hiding Dock delay
# defaults write com.apple.Dock autohide-delay -float 0

# # Speed up the animation when hiding/showing the Dock
# defaults write com.apple.Dock autohide-time-modifier -float 0.25

# # Make Dock icons of hidden applications translucent
# defaults write com.apple.Dock showhidden -bool true

# Enable spring loading for all Dock items
defaults write com.apple.Dock enable-spring-load-actions-on-all-items -bool true

# # Add a stack with recent applications
# defaults write com.apple.Dock persistent-others -array-add \
#   '{ "tile-data" = { "list-type" = 1; }; "tile-type" = "recents-tile"; }'

# Disable hot corners
defaults write com.apple.Dock wvous-tl-corner   -int 0
defaults write com.apple.Dock wvous-tl-modifier -int 0
defaults write com.apple.Dock wvous-tr-corner   -int 0
defaults write com.apple.Dock wvous-tr-modifier -int 0
defaults write com.apple.Dock wvous-bl-corner   -int 0
defaults write com.apple.Dock wvous-bl-modifier -int 0
defaults write com.apple.Dock wvous-br-corner   -int 0
defaults write com.apple.Dock wvous-br-modifier -int 0
# Possible values:
#  0: no-op
#  2: Mission Control
#  3: Show application windows
#  4: Desktop
#  5: Start screen saver
#  6: Disable screen saver
#  7: Dashboard
# 10: Put display to sleep
# 11: Launchpad
# 12: Notification Center

# -----------------------------------------------------------------------------
# Dashboard, Spaces, and Mission Control
# -----------------------------------------------------------------------------

# Disable Dashboard
defaults write com.apple.dashboard mcx-disabled -bool true

# Don't show Dashboard as a space
defaults write com.apple.Dock dashboard-in-overlay -int 1

# # Enable Dashboard dev mode (allows keeping widgets on the desktop)
# defaults write com.apple.Dashboard devmode -bool true

# Don't automatically rearrange spaces
defaults write com.apple.Dock mru-spaces -int 0

# Speed up Mission Control animations
defaults write com.apple.Dock expose-animation-duration -float 0.25
