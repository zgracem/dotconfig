# -----------------------------------------------------------------------------
# System
# -----------------------------------------------------------------------------

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
else
  # # Enable the MacBook Air SuperDrive on any Mac
  : # sudo nvram boot-args="mbasd=1"
fi

# Enable `>console` login
if (( MACOS_VERSION >= 10 )); then
    defaults write /Library/Preferences/com.apple.loginwindow.plist DisableConsoleAccess -bool false
fi

# Require password 8 hours after sleep or screen saver begins
defaults write com.apple.ScreenSaver askForPassword -int 1
defaults write com.apple.ScreenSaver askForPasswordDelay -int $(( 8 * 60 * 60 ))

# Enable Screen Sharing
sudo defaults write /Library/Preferences/com.apple.RemoteManagement VNCAlwaysStartOnConsole -bool true

### ZGM disabled 2016-08-18 -- redundant w/ Server?
# # Web Sharing -- enable Apache
# sudo defaults write /System/Library/LaunchDaemons/org.apache.httpd Disabled -bool false
