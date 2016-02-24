# curl
# http://curl.haxx.se/

_inPath curl || return

# use alternate .curlrc
export CURLRC="${dir_config}/curlrc"

curl() { command curl -K "${CURLRC}" "$@"; }
