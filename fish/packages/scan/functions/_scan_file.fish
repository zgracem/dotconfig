function _scan_file --description 'Track access to a file' -a file
  sudo opensnoop -v -f $file
end
