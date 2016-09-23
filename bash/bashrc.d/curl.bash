# curl
# http://curl.haxx.se/

_inPath curl || return

# use alternate .curlrc
export CURLRC="${dir_config}/curlrc"

curl()
{
  local homebrew_curl=/usr/local/opt/curl/bin/curl

  if [[ -x $homebrew_curl ]]; then
    local curl=$homebrew_curl
  else
    local curl="command curl"
  fi

  $curl -K "${CURLRC}" "$@"
}
