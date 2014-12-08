# set default
if type -P links 1>/dev/null; then
    BROWSER=links
fi

# use GUI app if not logged in remotely
if [ -z "$SSH_CONNECTION" ]; then
    if [ -x /usr/bin/open ]; then
        BROWSER=/usr/bin/open
    elif [ ":$OSTYPE:" = ':cygwin:' ]; then
        BROWSER="$HOME/scripts/chrome.sh"
    fi
fi

export BROWSER
