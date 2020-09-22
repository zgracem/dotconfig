#!/usr/bin/env fish

# Execute this script to rebuild configuration files for utilities that spoof
# their user-agent string, based on the current version of Google Chrome.

set files curlrc wgetrc youtube-dl

touch $XDG_CONFIG_HOME/.src/$files.m4

cd $XDG_CONFIG_HOME; and make USER_AGENT=(./get-user-agent.fish) user-agent
