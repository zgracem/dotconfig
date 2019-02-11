# -----------------------------------------------------------------------------
# WS168014:~/.local/init.bash
# -----------------------------------------------------------------------------
# launch apps
# -----------------------------------------------------------------------------

_isRunning() { command ps -sW | command grep -iq "${1}\\.exe\$"; }

# Google Chrome
if ! _isRunning chrome && [[ -n $ALL_PROXY ]]; then
  "$dir_scripts/cygwin/chrome.sh"
fi

# Dropbox
_isRunning Dropbox \
    || run "$(cygpath -au "$APPDATA\\Dropbox\\bin\\Dropbox.exe")" "/home"

# Pageant
_isRunning pageant \
    || run "$dir_apps/WinSCP/pageant.exe" "$(cygpath -aw ~/.ssh/key.ppk)"

# unset -f _isRunning
