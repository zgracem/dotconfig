# -----------------------------------------------------------------------------
# WS144966:~/.local/init.bash
# -----------------------------------------------------------------------------
# launch apps
# -----------------------------------------------------------------------------

_isRunning() { command ps -sW | command grep -iq "${1}\.exe\$"; }

# Google Chrome
_isRunning chrome \
    || "${dir_scripts}/chrome.sh"

# Dropbox
_isRunning Dropbox \
    || run "$(cygpath -au "${APPDATA}\Dropbox\bin\Dropbox.exe")" "/home"
    # || run "${dir_apps}/DropboxPortableAHK/DropboxPortableAHK.exe"

# Pageant
_isRunning pageant \
    || run "$(find_drive RED)/apps/WinSCP/pageant.exe" "$(cygpath -aw ~/.ssh/key.ppk)"

# unset -f _isRunning
