# Homebrew
# http://brew.sh/

_inPath brew || return

export HOMEBREW_PREFIX="/usr/local"
export HOMEBREW_BREW_FILE="$HOMEBREW_PREFIX/bin/brew"
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"

export HOMEBREW_LOGS="$HOME/var/log/homebrew"
export HOMEBREW_CACHE="$dir_cache/homebrew"

[[ -d $HOMEBREW_LOGS ]]  || mkdir -vp "$HOMEBREW_LOGS"
[[ -d $HOMEBREW_CACHE ]] || mkdir -vp "$HOMEBREW_CACHE"

# print developer warnings
export HOMEBREW_DEVELOPER=true

# if we're not in a GUI session on OSX...
if [[ -z $SECURITYSESSIONID ]]; then
  # don't print beer emoji
  export HOMEBREW_NO_EMOJI=true

  # make `brew home` et al. print the URL instead of launching a browser
  export HOMEBREW_BROWSER=/bin/echo
fi
