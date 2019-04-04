function json2yaml --description "Convert JSON to YAML"
  set -l src
  if set -q argv[1]
    set src "Pathname.new(ARGV[0])"
  else if not isatty stdin
    set src "ARGF"
  else
    echo >&2 "nothing to convert!"
    return 1
  end

  set -l cmd "puts JSON.load($src).to_yaml"
  set -l libs json pathname yaml
  ruby -r$libs -e $cmd $argv[1]
end
