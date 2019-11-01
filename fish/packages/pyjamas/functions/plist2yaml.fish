function plist2yaml --description "Convert property list to YAML"
  plist2json $argv | json2yaml
end
