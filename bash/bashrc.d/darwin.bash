# -----------------------------------------------------------------------------
# ~/.config/bash/bashrc.d/darwin.bash
# -----------------------------------------------------------------------------

[[ $PLATFORM == mac ]] || return

mapfile -t DARWIN_VERSINFO < <(uname -r | tr '.' ' ')
mapfile -t MACOS_VERSINFO < <(sw_vers -productVersion | tr '.' ' ')
MACOS_VERSION=${MACOS_VERSINFO[1]}

if [[ -z ${MACOS_VERSINFO[2]} ]]; then
  # initial releases return e.g. "10.12" instead of "10.12.0"
  MACOS_VERSINFO[2]=0
fi

# -----------------------------------------------------------------------------
# system commands
# -----------------------------------------------------------------------------

alias dnsflush="sudo dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias lsregister="/System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/Support/lsregister"
alias lockscreen='"/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession" -suspend'
alias gotosleep="pmset sleepnow"
alias PlistBuddy="/usr/libexec/PlistBuddy"
alias restart="sudo shutdown -r now"
alias screensaver="open -a ScreenSaverEngine"

# -----------------------------------------------------------------------------
# environment variables
# -----------------------------------------------------------------------------

# if [[ -n $OS_INSTALL || -n $__OSINSTALL_ENVIRONMENT ]]; then
#   : # booted from recovery partition
# fi
