# -----------------------------------------------------------------------------
# ~/.config/wget/wgetrc
# Generated from $XDG_CONFIG_HOME/wget/wgetrc.m4
# -----------------------------------------------------------------------------

# Disguise user agent
user_agent = "_USER_AGENT_"

# Wait (0.5~1.5 * <wait>) seconds between requests to mask wget's presence
random_wait = on
wait = 2

# Ignore `robots.txt` and `<meta name=robots content=nofollow>`
robots = off

# Use the server-provided last modification date, if available
timestamping = on

# Add a `.html` extension to `text/html` or `application/xhtml+xml` files
# that lack one, or a `.css` extension to `text/css` files that lack one
adjust_extension = on

# Do not generate host-prefixed directories
add_hostdir = off

# Retry a few times when a download fails, but don't overdo it
# (The default is 20!)
tries = 3

# Don't check the server certificate against available certificate authorities
check_certificate = off

# Turn off verbose, but print error messages and basic information
verbose = off
progress = bar

# Continue getting a partially-downloaded file.
continue = on

# Specify alternate path for ~/.wget-hsts
hsts-file = "_XDG_CACHE_HOME_/wget-hsts"

# Save the original URL and Referer HTTP header in extended filesystem metadata.
xattr = on

# -----------------------------------------------------------------------------
# recursive options
# -----------------------------------------------------------------------------

# Never ascend to the parent directory when downloading recursively
no_parent = on

# Follow FTP links from HTML documents by default
follow_ftp = on
