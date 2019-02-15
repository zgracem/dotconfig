function headers
	if in-path wget
    wget --spider -Snv $argv
  else if in-path curl
    curl -Is $argv
  end
end
