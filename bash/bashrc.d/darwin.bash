if [[ $OSTYPE =~ darwin ]]; then
    HARDWARE=$(sysctl -n hw.model)
    OSX_VERSINFO=($(sw_vers -productVersion | tr '.' ' '; sw_vers -buildVersion))
else
    return
fi

# -----------------------------------------------------------------------------
# system commands
# -----------------------------------------------------------------------------

alias lockscreen='"/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession" -suspend'
alias gotosleep='pmset sleepnow'
alias plistbuddy='/usr/libexec/PlistBuddy'
alias restart='sudo shutdown -r now'
alias screensaver='open "/System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app"'

# sound
alias mute='osascript -e "set volume output muted true"'
alias unmute='osascript -e "set volume output muted false"'

# bless(8) doesn't work on El Capitan thanks to SIP/rootless
if (( OSX_VERSINFO[1] < 11 )) && [[ -d /Volumes/BOOTCAMP ]]; then
  # load Windows on next boot
  alias bootwin='sudo bless --mount "/Volumes/BOOTCAMP" --setBoot -nextonly '
  # ...or right now
  alias bootcamp='bootwin && restart'
fi

# -----------------------------------------------------------------------------
# environment variables
# -----------------------------------------------------------------------------

# if [[ -n $OS_INSTALL || -n $__OSINSTALL_ENVIRONMENT ]]; then
#   : # booted from recovery partition
# fi
