# Homebrew
# http://brew.sh/

_inPath brew || return

export HOMEBREW_BREW_FILE=${HOMEBREW_BREW_FILE:=$(getPath brew)}
export HOMEBREW_PREFIX=${HOMEBREW_PREFIX:=$(brew --prefix)}
export HOMEBREW_CELLAR="$HOMEBREW_PREFIX/Cellar"
# export HOMEBREW_CELLAR=${HOMEBREW_CELLAR:=$(brew --cellar)}
# export HOMEBREW_CACHE=${HOMEBREW_CACHE:=$(brew --cache)}
# export HOMEBREW_REPOSITORY=${HOMEBREW_REPOSITORY:=$(brew --repository)}

# print developer warnings
export HOMEBREW_DEVELOPER=true

# when logged in remotely...
if [[ -n $SSH_CONNECTION ]]; then
	# don't print beer emoji
    export HOMEBREW_NO_EMOJI=true
    # export HOMEBREW_INSTALL_BADGE=$'\xF0\x9F\x8D\xBA'

    # make `brew home` et al. print the URL instead of launching a browser
    export HOMEBREW_BROWSER=/bin/echo
fi
