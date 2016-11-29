# -----------------------------------------------------------------------------
# iTunes
# -----------------------------------------------------------------------------

# display now-playing notifications in the Dock
defaults write com.apple.Dock itunes-notifications -bool true

# disable Ping
defaults write -app iTunes disablePingSidebar -bool true
defaults write -app iTunes disablePing -bool true

# make Cmd + F focus the search input
defaults write -app iTunes NSUserKeyEquivalents -dict-add "Target Search Field" "@F"
