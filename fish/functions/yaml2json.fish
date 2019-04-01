function yaml2json --description "Convert a YAML file to JSON"
  set -l cmd "puts YAML.load(Pathname.new(ARGV[0]).read).to_json"
  ruby -rjson -rpathname -ryaml -e $cmd $argv[1]
end
