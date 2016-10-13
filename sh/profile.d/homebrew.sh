# Homebrew
# http://brew.sh/

HOMEBREW_BREW_FILE=$(command -v brew) || return

export HOMEBREW_PREFIX="${HOMEBREW_BREW_FILE%/bin/brew}"

if [ "${HOMEBREW_PREFIX#*linuxbrew}" != "$HOMEBREW_PREFIX" ]; then
  export HOMEBREW_TEMP="$HOME/var/tmp"
fi

export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
export HOMEBREW_LOGS="$HOME/var/log/homebrew"
export HOMEBREW_CACHE="$XDG_CACHE_HOME/homebrew"

[ -d "$HOMEBREW_LOGS" ]  || mkdir -vp "$HOMEBREW_LOGS"
[ -d "$HOMEBREW_CACHE" ] || mkdir -vp "$HOMEBREW_CACHE"

# Only automatically `brew update` every 24 hours
unset -v HOMEBREW_NO_AUTO_UPDATE
export HOMEBREW_AUTO_UPDATE_SECS=$(( 24 * 60 * 60 ))

# If we're not in a GUI session on macOS...
if [ -z "$SECURITYSESSIONID" ]; then
  # don't print beer emoji
  export HOMEBREW_NO_EMOJI=true

  # make `brew home` et al. print the URL instead of launching a browser
  export HOMEBREW_BROWSER=/bin/echo
fi

# Pumpkin Spice Homebrew!
# -- https://twitter.com/MacHomebrew/status/783028298351730688
if [ "$(date +%B)" = "October" ]; then
  export HOMEBREW_INSTALL_BADGE="\xf0\x9f\x8e\x83" # 🎃
fi
