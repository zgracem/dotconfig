# Homebrew
# http://brew.sh/

_inPath brew || return

export HOMEBREW_PREFIX="/usr/local"
export HOMEBREW_BREW_FILE="$HOMEBREW_PREFIX/bin/brew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"

export HOMEBREW_LOGS="$HOME/var/log/homebrew"
export HOMEBREW_CACHE="$HOME/var/cache/homebrew"

[[ -d $HOMEBREW_LOGS ]] || mkdir -p "$HOMEBREW_LOGS"
[[ -d $HOMEBREW_CACHE ]] || mkdir -p "$HOMEBREW_CACHE"

# print developer warnings
export HOMEBREW_DEVELOPER=true

# when logged in remotely...
if [[ -n $SSH_CONNECTION ]]; then
  # don't print beer emoji
  export HOMEBREW_NO_EMOJI=true

  # make `brew home` et al. print the URL instead of launching a browser
  export HOMEBREW_BROWSER=/bin/echo
fi
