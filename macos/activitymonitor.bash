# -----------------------------------------------------------------------------
# Activity Monitor
# -----------------------------------------------------------------------------

# Show the main window on launch
defaults write com.apple.ActivityMonitor OpenMainWindow -bool true

# Visualize CPU usage in Dock icon
defaults write com.apple.ActivityMonitor IconType -int 5

# Show all processes
defaults write com.apple.ActivityMonitor ShowCategory -int 0

# Sort results by CPU usage
defaults write com.apple.ActivityMonitor SortColumn -string "CPUUsage"
defaults write com.apple.ActivityMonitor SortDirection -int 0
