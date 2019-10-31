if in-path wget
  function headers --wraps wget --description 'Display HTTP headers for a given URL'
    wget --spider -Snv $argv
  end
else if in-path curl
  function headers --wraps curl --description 'Display HTTP headers for a given URL'
    curl -Is $argv
  end
end
