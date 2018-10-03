# Homebrew
# >> http://brew.sh/

HOMEBREW_COMPLETION="$HOMEBREW_PREFIX/etc/bash_completion.d"

if [[ -f $HOMEBREW_COMPLETION/brew ]]; then
  . "$HOMEBREW_COMPLETION/brew"
fi

unset -v HOMEBREW_COMPLETION
