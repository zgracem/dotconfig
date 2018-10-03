# -----------------------------------------------------------------------------
# Dock & hot corners
# -----------------------------------------------------------------------------

# Set the icon size of Dock items to 64 pixels & lock it
defaults write com.apple.Dock tilesize -int 64
defaults write com.apple.Dock size-immutable -bool true

# Change minimize/maximize window effect
defaults write com.apple.Dock mineffect -string "scale"

# Don't animate opening applications from the Dock
defaults write com.apple.Dock launchanim -bool false
defaults write com.apple.Dock no-bouncing -bool false

# Show indicator lights for open applications in the Dock
defaults write com.apple.Dock show-process-indicators -bool true

# Enable spring loading for all Dock items
defaults write com.apple.Dock enable-spring-load-actions-on-all-items -bool true

# Enable scroll gestures
defaults write com.apple.Dock scroll-to-open -bool true

# Disable hot corners
defaults write com.apple.Dock wvous-tl-corner   -int 0
defaults write com.apple.Dock wvous-tl-modifier -int 0
defaults write com.apple.Dock wvous-tr-corner   -int 0
defaults write com.apple.Dock wvous-tr-modifier -int 0
defaults write com.apple.Dock wvous-bl-corner   -int 0
defaults write com.apple.Dock wvous-bl-modifier -int 0
defaults write com.apple.Dock wvous-br-corner   -int 0
defaults write com.apple.Dock wvous-br-modifier -int 0

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
