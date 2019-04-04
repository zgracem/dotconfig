function yaml2json --description "Convert a YAML file to JSON"
  set -l src
  if set -q argv[1]
    set src "Pathname.new(ARGV[0])"
  else if not isatty stdin
    set src "ARGF"
  else
    echo >&2 "nothing to convert!"
    return 1
  end

  ruby -rjson -rpathname -ryaml -e "puts YAML.load($src.read).to_json" $argv[1]
end
