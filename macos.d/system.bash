# -----------------------------------------------------------------------------
# System
# -----------------------------------------------------------------------------

# shellcheck disable=SC2154
if [[ -n $computer_name ]]; then
    # Set computer name (as done via System Preferences → Sharing)
    sudo scutil --set ComputerName  "${computer_name}"
    sudo scutil --set HostName      "${computer_name}.local"
    sudo scutil --set LocalHostName "${computer_name}"
    sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.smb.server NetBIOSName -string "${computer_name}"
fi

# Disable Resume system-wide
defaults write -g NSQuitAlwaysKeepsWindows -bool false

# Disable automatic termination of inactive apps
defaults write -g NSDisableAutomaticTermination -bool true

# Automatically quit printer app once the print jobs complete
defaults write com.apple.print.PrintingPrefs "Quit When Finished" -bool true

# # Disable Notification Center and remove the menu bar icon
# launchctl unload -w /System/Library/LaunchAgents/com.apple.notificationcenterui.plist 2> /dev/null

# Enable access for assistive devices pre-Mavericks.
# Post-Mavericks, use <github.com/jacobsalmela/tccutil>.
if (( MACOS_VERSION < 9 )); then
  sudo touch "/private/var/db/.AccessibilityAPIEnabled"
fi

# Disable disk image verification
defaults write com.apple.frameworks.diskimages skip-verify -bool true
defaults write com.apple.frameworks.diskimages skip-verify-locked -bool true
defaults write com.apple.frameworks.diskimages skip-verify-remote -bool true

if [[ $HARDWARE == MacBook* ]]; then
  # Disable the sudden motion sensor as it’s not useful for SSDs
  sudo pmset -a sms 0
fi

# Enable `>console` login
if (( MACOS_VERSION >= 10 )); then
    defaults write /Library/Preferences/com.apple.loginwindow.plist DisableConsoleAccess -bool false
fi

# Require password 4 hours after sleep or screen saver begins
defaults write com.apple.ScreenSaver askForPassword -int 1
defaults write com.apple.ScreenSaver askForPasswordDelay -int $(( 4 * 60 * 60 ))

# Enable Screen Sharing
sudo defaults write /Library/Preferences/com.apple.RemoteManagement VNCAlwaysStartOnConsole -bool true
