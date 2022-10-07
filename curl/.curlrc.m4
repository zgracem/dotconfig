# -----------------------------------------------------------------------------
# ~/.config/curl/.curlrc
# export CURL_HOME=$XDG_CONFIG_HOME/curl
# Generated from $XDG_CONFIG_HOME/curl/curlrc.m4
# -----------------------------------------------------------------------------

# [-#] display simple progress bar
progress-bar

# [-A] disguise user agent
user-agent = "_USER_AGENT_"

# [-L] follow HTTP directs
location

# [-e] automatically set the previous URL when redirected
referer = ";auto"

# [-f] don't show/download error document - only error code
fail

# [-R] use the server-provided last modification date, if available
remote-time

# request a compressed response and save the uncompressed document
compressed
