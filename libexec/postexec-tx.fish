#!/usr/local/bin/fish

# This script is called by Transmission.app when a torrent finishes downloading,
# and writes a simple log file to ~/var/log/transmission about it.
# See: <https://github.com/transmission/transmission/blob/main/docs/Scripts.md>
#
# To "install":
#   defaults write -app Transmission DoneScriptPath "$XDG_CONFIG_HOME/libexec/postexec-tx.fish"

set -gx LOG_DIR "$HOME/var/log/transmission"
set -gx TIMESTAMP (gdate +%Y%m%d_%H%M%S) # for errors
set -gx LOG_FILE "$LOG_DIR/$TIMESTAMP.txt" # fallback path

## For testing:
# set -gx TR_TORRENT_HASH 7367c6abd6a0da19a7da08f5178f1bf46b1a2bcf
# set -gx TR_TORRENT_ID 10

if not command -sq transmission-remote
    begin
        echo "transmission-remote not found in PATH:"
        set --show PATH
    end | tee $LOG_FILE
    exit 127
else if not set -q TR_TORRENT_ID[1]
    begin
        echo "TR_TORRENT_ID not found in environment:"
        set --show
    end | tee $LOG_FILE
    exit 1
else
    set -gx LOG_FILE "$LOG_DIR/$TR_TORRENT_HASH.txt"
    mkdir -p $LOG_DIR
end

function main
    transmission-remote --torrent $TR_TORRENT_ID --info
    transmission-remote --torrent $TR_TORRENT_ID --info-files
end

main | tee $LOG_FILE
