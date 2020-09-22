#!/usr/bin/env fish

# Execute this script to rebuild configuration files for utilities that spoof
# their user-agent string, based on the current version of Google Chrome.

if set -q XDG_CONFIG_HOME
  cd $XDG_CONFIG_HOME
  make -B user-agent
end
