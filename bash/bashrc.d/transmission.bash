# Transmission
# https://www.transmissionbt.com/

export TRANSMISSION_HOME="$HOME/.config/transmission"
export TRANSMISSION_WEB_HOME="$HOME/Library/Application Support/transmission-daemon/web"

if [[ ! -d $TRANSMISSION_WEB_HOME ]]; then
    unset TRANSMISSION_WEB_HOME
fi
