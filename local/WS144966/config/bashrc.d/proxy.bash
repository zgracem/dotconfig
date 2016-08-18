# proxy

export SOCKS5_SERVER="127.0.0.1:8080"

if [[ -z $ALL_PROXY ]]; then
  if command curl -sSf --connect-timeout 3 --socks5-hostname $SOCKS5_SERVER inescapable.org &>/dev/null; then
    export ALL_PROXY="socks5h://${SOCKS5_SERVER}"
    export GIT_PROXY_COMMAND="${dir_scripts}/util/git-proxy.sh"
    . "${dir_config}/bash/bashrc.d/chrome.bash"

    links()
    {
      command links -socks-proxy "$SOCKS5_SERVER" "$@"
    }
  else
    scold "$BASH_SOURCE: could not find proxy at $SOCKS5_SERVER"
    unset -v SOCKS5_SERVER
  fi
fi

export http_proxy="http://uxhj:violet0815_Delta@proxy:8080/"
export https_proxy="$http_proxy"
export HTTP_PROXY="$http_proxy"
export HTTPS_PROXY="$http_proxy"
