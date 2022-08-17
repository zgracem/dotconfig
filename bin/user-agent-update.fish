#!/usr/bin/env fish

# Execute this script to rebuild configuration files for utilities that spoof
# their user-agent string, based on the current version of Google Chrome.

make -C $XDG_CONFIG_HOME -B user-agent
