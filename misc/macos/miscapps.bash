# -----------------------------------------------------------------------------
# Built-in apps
# -----------------------------------------------------------------------------

# Dictionary -- use only one window
defaults write -app Dictionary ProhibitNewWindowForRequest -bool TRUE

# Image Capture/Photos -- don't automatically open when cameras are plugged in
defaults write com.apple.ImageCapture disableHotPlug -bool true

# Help Viewer -- set windows to non-floating mode
defaults write com.apple.helpviewer DevMode -bool true

# QuickTime Player -- auto-play videos when opened
defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen -bool true
