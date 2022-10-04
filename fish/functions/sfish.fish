# For ssh'ing directly to a `~/opt/bin/fish --login` session on shared web
# servers where `/usr/bin/fish` hasn't been updated since 2016.
function sfish -d "Remote login to fish" -a remote_host
    ssh $remote_host TERM_PROGRAM=$TERM_PROGRAM fish -l
end
