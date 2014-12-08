# curl
# http://curl.haxx.se/

_inPath curl || return

# use alternate .curlrc
export CURLRC="${dir_config}/curlrc"

# -----------------------------------------------------------------------------
# aliases
# -----------------------------------------------------------------------------

alias curl='curl -K "${CURLRC}" '

if ! _inPath wget; then
    alias dl='curl -OJ'             # download a file
    alias headers='curl -Is'        # get HTTP headers
    alias myip='curl -S $ip_site'   # external IP address (see private.bash)
fi
