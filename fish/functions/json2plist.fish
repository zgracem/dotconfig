function json2plist --description "Convert JSON to property list"
  set -l src
  if set -q argv[1]
    set src "Pathname.new(ARGV[0])"
  else if not isatty stdin
    set src "ARGF"
  else
    echo >&2 "nothing to convert!"
    return 1
  end

  set -l cmd "puts JSON.load($src).to_plist"
  set -l libs json pathname plist
  ruby -r$libs -e $cmd $argv[1]
end
