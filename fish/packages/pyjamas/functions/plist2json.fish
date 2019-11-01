function plist2json --description "Convert property list to JSON"
  plutil -convert json -r $argv[1] -o -
end
