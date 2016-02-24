# proxy

export SOCKS5_SERVER='127.0.0.1:8080'
export ALL_PROXY="socks5h://${SOCKS5_SERVER}"
export GIT_PROXY_COMMAND="${dir_scripts}/git-proxy.sh"

export http_proxy="http://uxhj:violet0224_Delta@proxy:8080/"
export https_proxy="$http_proxy"
export HTTP_PROXY="$http_proxy"
export HTTPS_PROXY="$http_proxy"

. "${dir_config}/bash/bashrc.d/chrome.bash"

links()
{
    command links -socks-proxy "$SOCKS5_SERVER" "$@"
}
