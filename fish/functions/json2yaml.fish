function json2yaml --description "Convert a JSON file to YAML"
  set -l src
  if set -q argv[1]
    set src "Pathname.new(ARGV[0])"
  else if not isatty stdin
    set src "ARGF"
  else
    echo >&2 "nothing to convert!"
    return 1
  end

  ruby -rjson -rpathname -ryaml -e "puts JSON.load($src).to_yaml" $argv[1]
end
