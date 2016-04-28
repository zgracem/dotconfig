# -----------------------------------------------------------------------------
# WS144966:~/.local/init.bash
# -----------------------------------------------------------------------------

# cute login banner
if [[ -x $dir_scripts/loginbanner.sh ]]; then
    "${dir_scripts}/loginbanner.sh"
fi

# this day in history...
if [[ -x $dir_scripts/matins.sh ]]; then
    "${dir_scripts}/matins.sh"
fi

# countdown (date & function set in private.bash)
_isFunction cl && cl

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

# -----------------------------------------------------------------------------

# print bash version
bashver
