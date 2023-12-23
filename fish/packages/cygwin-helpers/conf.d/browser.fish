# fish_help_browser overrides the browser that may be defined by $BROWSER.
# The variable may be an array containing a browser name plus options.
# N.B. This must be a GUI app; fish will use cygstart(1) to launch it.
set -g fish_help_browser "$PROGRAMFILES\\Mozilla Firefox\\firefox.exe"
