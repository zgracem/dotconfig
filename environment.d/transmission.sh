# Transmission
# >> https://www.transmissionbt.com/

TRANSMISSION_WEB_HOME="$HOME/Library/Application Support/transmission-daemon/web"

if [ -d "$TRANSMISSION_WEB_HOME" ]; then
  export TRANSMISSION_WEB_HOME
else
  unset -v TRANSMISSION_WEB_HOME
fi
