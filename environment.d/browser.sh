unset -v BROWSER

# Set default browser to links, if available
if command -v links 1>/dev/null; then
  BROWSER=links
else
  BROWSER=open
fi

export BROWSER
