function json --description 'Pretty-print a .json file'
  in-path jq; or return 127
  jq . < $argv[1]
end
