function dl --description 'Download a URL to the current directory'
	if in-path wget
    wget $argv
  else if in-path curl
    curl -OJ $argv
  end
end
