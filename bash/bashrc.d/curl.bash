# curl
# http://curl.haxx.se/

_inPath curl || return

curl()
{
  # use alternate .curlrc
  local CURLRC="$dir_config/curlrc"

  # prefer Homebrew's curl if present
  local homebrew_curl="$HOMEBREW_PREFIX/opt/curl/bin/curl"

  if [[ -x $homebrew_curl ]]; then
    local curl=$homebrew_curl
  else
    local curl="command curl"
  fi

  $curl -K "$CURLRC" "$@"
}
