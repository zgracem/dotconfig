function plist --description 'Display a .plist file in human-readable format'
  in-path plutil; or return 127
	plutil -p $argv[1]
end
