#!/usr/bin/env bash
# -----------------------------------------------------------------------------
# Recommended usage:
#   export GIT_PROXY_COMMAND=/path/to/gitproxy.sh
#   git config --global core.gitproxy $GIT_PROXY_COMMAND
# -----------------------------------------------------------------------------

# get proxy value
if [[ $ALL_PROXY =~ "socks5h://" ]]; then
    proxy="${ALL_PROXY#*//}"
elif [[ -n $SOCKS5_SERVER ]]; then
    proxy="$SOCKS5_SERVER"
else
    proxy="127.0.0.1:8080"
fi

proxy_host="${proxy%%:*}"
proxy_port="${proxy##*:}"

git_host="$1"
git_port="$2"

method="SOCKS:${proxy_host}:${git_host}:${git_port},socksport=${proxy_port}"
exec socat - "$method"
