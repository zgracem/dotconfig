function json2yaml --description "Convert a JSON file to YAML"
  set -l cmd "puts JSON.load(Pathname.new(ARGV[0])).to_yaml"
  ruby -rjson -rpathname -ryaml -e $cmd $argv[1]
end
