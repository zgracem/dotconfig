# -----------------------------------------------------------------------------
# Terminal.app
# -----------------------------------------------------------------------------

# Only use UTF-8
defaults write -app Terminal StringEncodings -array 4

# Enable Secure Keyboard Entry
# >> https://security.stackexchange.com/a/47786/8918
defaults write -app Terminal SecureKeyboardEntry -bool true

# Disable line marks
defaults write -app Terminal ShowLineMarks -int 0

# Always show tab bar
defaults write -app Terminal ShowTabBar -bool true
