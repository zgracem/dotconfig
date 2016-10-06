unset -v BROWSER

# Set default browser to links, if available
if command -v links 1>/dev/null; then
  BROWSER=links
fi

# Use GUI app if not logged in remotely
if [ -z "$SSH_CONNECTION" ]; then
  if [ -x /usr/bin/open ]; then
    # open(1) will send URLs to the default GUI browser
    BROWSER=/usr/bin/open
  elif [ "$OSTYPE" = "cygwin" ]; then
    # Wrapper script for Google Chrome w/ custom command-line switches
    BROWSER="$HOME/bin/chrome"
  fi
fi

export BROWSER
