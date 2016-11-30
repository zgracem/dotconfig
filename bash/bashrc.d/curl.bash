# curl
# >> http://curl.haxx.se/

_inPath curl || return

curl()
{
  # use alternate .curlrc
  local curlrc="$XDG_CONFIG_HOME/curlrc"

  # prefer Homebrew's curl if present
  local PATH="$HOMEBREW_PREFIX/opt/curl/bin:$PATH"

  command curl -K "$curlrc" "$@"
}
