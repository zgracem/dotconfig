# -----------------------------------------------------------------------------
# Time Machine
# -----------------------------------------------------------------------------

# Prevent Time Machine from prompting to use new hard drives as backup volume
sudo defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true

if [[ $HARDWARE == MacBook* ]]; then
  # Disable local Time Machine snapshots
  sudo tmutil disablelocal
fi
