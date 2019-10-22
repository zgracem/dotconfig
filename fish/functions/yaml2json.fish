function yaml2json --description "Convert YAML to JSON"
  set -l src
  if set -q argv[1]
    set src "Pathname.new(ARGV[0])"
  else if not isatty stdin
    set src "ARGF"
  else
    echo >&2 "nothing to convert!"
    return 1
  end

  set -l cmd "puts YAML.safe_load($src.read).to_json"
  set -l libs json pathname yaml
  ruby -r$libs -e $cmd $argv[1]
end
