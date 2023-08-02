# See also: $XDG_CONFIG_HOME/homebrew/brew.env

if [ -n "$SSH_CONNECTION" ]; then
  # make `brew home` et al. print the URL instead of launching a browser
  export HOMEBREW_BROWSER=/bin/echo
fi
