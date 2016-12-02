# -----------------------------------------------------------------------------
# Google Chrome
# -----------------------------------------------------------------------------

# Use the system-native print preview dialog
defaults write com.google.Chrome DisablePrintPreview -bool true

# Expand the print dialog by default
defaults write com.google.Chrome PMPrintingExpandedStateForPrint2 -bool true

# Check for updates daily
defaults write com.google.Keystone.Agent checkInterval 86400
