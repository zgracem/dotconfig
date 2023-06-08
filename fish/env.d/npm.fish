# Remove ad spam during `npm install` et al.
set -gx ADBLOCK true
set -gx OPEN_SOURCE_CONTRIBUTOR true

in-path npm; or exit

set -gx NODE_PATH $XDG_DATA_HOME/npm/lib/node_modules /usr/local/lib/node_modules

# prevent creation of ~/.config/configstore by update-notifier module
set -gx NO_UPDATE_NOTIFIER true
