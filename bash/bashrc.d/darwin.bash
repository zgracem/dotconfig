# -----------------------------------------------------------------------------
# ~/.config/bash/bashrc.d/darwin.bash
# -----------------------------------------------------------------------------

[[ $OSTYPE =~ darwin ]] || return

HARDWARE=$(sysctl -n hw.model)

DARWIN_VERSINFO=($(uname -r | tr '.' ' '))
MACOS_VERSINFO=($(sw_vers -productVersion | tr '.' ' '))
if [[ -z ${MACOS_VERSINFO[2]} ]]; then
  MACOS_VERSINFO[2]=0
fi

# -----------------------------------------------------------------------------
# system commands
# -----------------------------------------------------------------------------

alias lockscreen='"/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession" -suspend'
alias gotosleep="pmset sleepnow"
alias PlistBuddy="/usr/libexec/PlistBuddy"
alias restart="sudo shutdown -r now"
alias screensaver='open -a ScreenSaverEngine'
# /System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app

if [[ -d /Volumes/BOOTCAMP ]]; then
  # bless(8) doesn't work if System Integrity Protection is enabled on El Cap+
  if (( MACOS_VERSINFO[1] < 11 )) || [[ $(csrutil status 2>&1) == *disabled. ]]; then
    # load Windows on next boot
    alias bootwin="sudo bless --mount /Volumes/BOOTCAMP --setBoot -nextonly "
    # ...or right now
    alias bootcamp="bootwin && restart"
  fi
fi

# -----------------------------------------------------------------------------
# environment variables
# -----------------------------------------------------------------------------

# if [[ -n $OS_INSTALL || -n $__OSINSTALL_ENVIRONMENT ]]; then
#   : # booted from recovery partition
# fi
