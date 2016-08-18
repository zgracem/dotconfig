# -----------------------------------------------------------------------------
# Mouse & trackpad
# -----------------------------------------------------------------------------

# Trackpad: swipe between pages with three fingers
defaults write -g AppleEnableSwipeNavigateWithScrolls -bool true
defaults write -g com.apple.trackpad.threeFingerHorizSwipeGesture -int 1
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerHorizSwipeGesture -int 1

# Right click for magic mouse
defaults write com.apple.driver.AppleBluetoothMultitouch.mouse MouseButtonMode TwoButton
