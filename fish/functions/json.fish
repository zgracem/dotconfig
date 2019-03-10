function json --description 'Pretty-print a .json file'
  jq . < $argv[1]
end
