function plist --description 'Display a .plist file in human-readable format'
  plutil -p $argv[1]
end
