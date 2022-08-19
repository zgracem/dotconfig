# Optimize the number of concurrent downloads according to bandwidth available
optimize-concurrent-downloads=true
# Set the maximum number of parallel downloads for every queue item (default: -j5)
max-concurrent-downloads=8
# The maximum number of connections to one server for each download (default: -x1)
max-connection-per-server=2
# Do not split files smaller than 2*SIZE (default: -k20M)
min-split-size=5M
# Completely disable netrc support
no-netrc=true
# Spoof user agent for HTTP(S) downloads (default: -Uaria2c/$VERSION)
user-agent=_USER_AGENT_
# Continue downloading partially downloaded files
continue=true
# Apply timestamp of the remote file to the local file, if available
remote-time=true
