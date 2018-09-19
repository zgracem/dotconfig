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

# Enable spring loading for all Dock items
defaults write com.apple.Dock enable-spring-load-actions-on-all-items -bool true

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

# Don't automatically rearrange spaces
defaults write com.apple.Dock mru-spaces -int 0

# Speed up Mission Control animations
defaults write com.apple.Dock expose-animation-duration -float 0.25
