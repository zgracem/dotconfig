# -----------------------------------------------------------------------------
# Power management
# -----------------------------------------------------------------------------

if [[ $HARDWARE == MacBook* ]]; then
  # Wait 24 hours to go into standby mode (speeds waking from sleep)
  sudo pmset -a standbydelay 86400

  # Automatically illuminate built-in MacBook keyboard in low light
  defaults write com.apple.BezelServices kDim -bool true

  # Turn off keyboard illumination when computer is not used for 5 minutes
  defaults write com.apple.BezelServices kDimTime -int 300
fi

# Energy Saver defaults
sudo systemsetup -setwakeonnetworkaccess on \
                 -setrestartpowerfailure on \
                 -setrestartfreeze on \
                 -setallowpowerbuttontosleepcomputer on \
                 -setremotelogin on \
                 -setcomputersleep "Never" \
                 -setdisplaysleep "60" \
                 -setharddisksleep "Never"
