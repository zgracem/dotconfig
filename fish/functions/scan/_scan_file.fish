function _scan_file -a file --description 'Track access to a file'
  sudo opensnoop -v -f $file
end
