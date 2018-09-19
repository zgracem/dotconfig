# -----------------------------------------------------------------------------
# Text & keyboard
# -----------------------------------------------------------------------------

# Disable press-and-hold for keys in favor of key repeat
defaults write -g ApplePressAndHoldEnabled -bool false

# Display ASCII control characters using caret notation in standard text views
defaults write -g NSTextShowsControlCharacters -bool true

# Disable smart quotes
defaults write -g NSAutomaticQuoteSubstitutionEnabled -bool false

# Disable smart dashes
defaults write -g NSAutomaticDashSubstitutionEnabled -bool false

# Disable auto-correct
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false
