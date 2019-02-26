if in-path wget
  function dl --wraps wget --description 'Download a URL to the current directory'
    wget $argv
  end
else if in-path curl
  function dl --wraps curl --description 'Download a URL to the current directory'
    curl -OJ $argv
  end
else
  exit 127
end
