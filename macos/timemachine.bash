# -----------------------------------------------------------------------------
# Time Machine
# -----------------------------------------------------------------------------

# Prevent Time Machine from prompting to use new hard drives as backup volume
defaults write com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

if [[ $HARDWARE == MacBook* ]]; then
  # Disable local Time Machine snapshots
  sudo tmutil disablelocal
fi
