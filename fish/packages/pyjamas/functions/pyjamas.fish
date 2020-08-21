function pyjamas --description "Convert configuration files between formats"
  argparse -n pyjamas 'i/in=' 'o/out=' -- $argv
  or return

  set -l src
  set -l ext
  set -q _flag_in; and set ext $_flag_in

  if set -q argv[1]
    set src "Pathname.new(ARGV[0])"
    set -q ext; or set ext (string split "." -- $argv[1])[-1]
  else if not isatty stdin
    set src "ARGF"
    if not set -q _flag_in
      echo >&2 "don't know what kind of file this is! (specify with -i/--in)"
      return 1
    end
  else
    echo >&2 "nothing to convert!"
    return 1
  end

  set -l input
  set -l libs pathname
  switch "$ext"
  case json
    set input "JSON.load($src)"
    set -a libs json
  case plist
    set input "Plist.parse_xml($src)"
    set -a libs plist
  case toml
    set input "TomlRB.parse($src.read)"
    set -a libs toml-rb
  case yaml
    set input "YAML.load($src.read)"
    set -a libs yaml
  case '*'
    echo >&2 "don't know how to read a “$ext” file"
    return 1
  end

  set -l output
  switch "$_flag_out"
  case json
    set output "$input.to_json"
    set -a libs json
  case plist
    set output "$input.to_plist"
    set -a libs plist
  case toml
    set output "TomlRB.dump($input)"
    set -a libs toml-rb
  case yaml
    set output "$input.to_yaml"
    set -a libs yaml
  case '*'
    echo >&2 "don't know how to make a “$_flag_out” file"
    return 1
  end

  ruby -r$libs -e "puts $output" $argv[1]
end
