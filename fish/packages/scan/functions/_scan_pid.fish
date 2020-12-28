function _scan_pid --description 'Track access by process ID' -a pid
    sudo opensnoop -v -p $pid
end
