# -----------------------------------------------------------------------------
# Text & keyboard
# -----------------------------------------------------------------------------

# Enable full keyboard access for all controls (e.g. enable Tab in modal dialogs)
defaults write -g AppleKeyboardUIMode -int 3

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

### ZGM disabled 2016-06-03 -- still necessary?
# # Fix for the ancient UTF-8 bug in QuickLook (http://mths.be/bbo)
# # Known to cause problems when saving files in Adobe Illustrator CS5
# echo "0x08000100:0" >| ~/.CFUserTextEncoding
