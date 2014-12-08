# Transmission
# https://www.transmissionbt.com/

export TRANSMISSION_HOME="${HOME}/.config/transmission"
export TRANSMISSION_WEB_HOME="${HOME}/Library/Application Support/transmission-daemon/web"

if [[ ! -d $TRANSMISSION_WEB_HOME ]]; then
    unset TRANSMISSION_WEB_HOME
fi

# -----------------------------------------------------------------------------
# aliases
# -----------------------------------------------------------------------------

# command-line utilities
if _inPath transmission-remote; then
    alias btadd='transmission-remote --add'
fi

# transmission-remote-cli
# https://github.com/fagga/transmission-remote-cli
if [[ -e $dir_mybin/github/transmission-remote-cli ]]; then
    alias bt="newwin --title transmission ${dir_mybin}/github/transmission-remote-cli/transmission-remote-cli"
fi
