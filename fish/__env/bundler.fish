command -sq bundle; or exit

set -gx BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundler/config
set -gx BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundler
set -gx BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundler
