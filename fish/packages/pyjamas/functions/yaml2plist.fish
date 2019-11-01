function yaml2plist --description "Convert YAML to property list"
  set -l src
  if set -q argv[1]
    set src "Pathname.new(ARGV[0])"
  else if not isatty stdin
    set src "ARGF"
  else
    echo >&2 "nothing to convert!"
    return 1
  end

  set -l cmd "puts YAML.load($src.read).to_plist"
  set -l libs pathname plist yaml
  ruby -r$libs -e $cmd $argv[1]
end
