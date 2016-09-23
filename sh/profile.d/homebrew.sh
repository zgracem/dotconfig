# Homebrew
# http://brew.sh/

[ -x /usr/local/bin/brew ] || return

export HOMEBREW_PREFIX="/usr/local"
export HOMEBREW_BREW_FILE="$HOMEBREW_PREFIX/bin/brew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"

export HOMEBREW_LOGS="$HOME/var/log/homebrew"
export HOMEBREW_CACHE="$HOME/var/cache/homebrew"

[ -d "$HOMEBREW_LOGS" ]  || mkdir -vp "$HOMEBREW_LOGS"
[ -d "$HOMEBREW_CACHE" ] || mkdir -vp "$HOMEBREW_CACHE"

# don't automatically `brew update`
export HOMEBREW_NO_AUTO_UPDATE=true

# also ring the bell when printing beer emoji
export HOMEBREW_INSTALL_BADGE=$(printf "\a\xf0\x9f\x8d\xba")

# if we're not in a GUI session on macOS...
if [ -z "$SECURITYSESSIONID" ]; then
  # # don't print beer emoji
  # export HOMEBREW_NO_EMOJI=true

  # only ring bell
  HOMEBREW_INSTALL_BADGE=$(printf "\a")

  # make `brew home` et al. print the URL instead of launching a browser
  export HOMEBREW_BROWSER=/bin/echo
fi
