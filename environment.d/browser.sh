unset -v BROWSER

# Set default browser to links, if available
if command -v links 1>/dev/null; then
  BROWSER=links
fi

# Use GUI app if not logged in remotely
if [ -z "$SSH_CONNECTION" ]; then
  if [ "$PLATFORM" = "windows" ] ; then
    # Wrapper script for Firefox
    BROWSER="$HOME/bin/firefox"
  else
    BROWSER=open
  fi
fi

export BROWSER
