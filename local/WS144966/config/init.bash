# -----------------------------------------------------------------------------
# WS144966:~/.local/init.bash
# -----------------------------------------------------------------------------
# launch apps
# -----------------------------------------------------------------------------

_isRunning()
{
    command ps -sW | command grep -q "${1}\.exe\$"
}

# Google Chrome
_isRunning GoogleChromePortable \
    || "${dir_scripts}/chrome.sh"

# Dropbox
_isRunning Dropbox \
    || run "${dir_apps}/DropboxPortableAHK/DropboxPortableAHK.exe"

# # ColorCop
# _isRunning ColorCop \
#     || cygstart /cygdrive/f/apps/ColorCop/ColorCop.exe

unset -f _isRunning
