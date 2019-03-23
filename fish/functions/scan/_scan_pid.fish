function _scan_pid -a pid --description 'Track access by process ID'
  sudo opensnoop -v -p $pid
end
