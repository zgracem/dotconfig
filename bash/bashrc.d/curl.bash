# curl
# >> http://curl.haxx.se/

_inPath curl || return

curl()
{
  # prefer Homebrew's curl if present
  local PATH="$HOMEBREW_PREFIX/opt/curl/bin:$PATH"

  command curl "$@"
}
