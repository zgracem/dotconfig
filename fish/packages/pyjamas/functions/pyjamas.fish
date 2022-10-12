function pyjamas --description "Convert configuration files between formats"
    argparse -x{i,o},m -n pyjamas 'i/in=' 'o/out=' 'm/mode=' -- $argv
    or return

    if set -q _flag_mode
        string split ":" $_flag_mode | read -L _flag_in _flag_out
    end

    set -q _flag_in; and set -l ext_in $_flag_in

    if set -q argv[1]
        set -f src "Pathname.new(ARGV[0])"
        set -q ext_in; or set ext_in (path extension $argv[1] | string trim -c.)
    else if not isatty stdin
        set -f src ARGF
        if not set -q _flag_in
            echo >&2 "unknown file type! (specify with --in or --mode)"
            return 1
        end
    else
        echo >&2 "nothing to convert!"
        return 1
    end

    set -l libs date pathname

    switch "$ext_in"
        case cson
            set -f input "JSON.load(Open3.capture2('cson2json', stdin_data: $src.read).first)"
            set -a libs json open3
        case json
            set -f input "JSON.load($src)"
            set -a libs json
        case plist
            set -f input "Plist.parse_xml($src)"
            set -a libs plist
        case toml
            set -f input "TomlRB.parse($src.read)"
            set -a libs toml-rb
        case yml yaml
            set -f input "YAML.unsafe_load($src.read)"
            set -a libs yaml
        case '*'
            echo >&2 "don't know how to read a “$ext_in” file!"
            return 1
    end

    set -l lang $_flag_out

    switch "$_flag_out"
        case cson
            set -f output "Open3.capture2('json2cson', stdin_data: $input.to_json).first"
            set -a libs json open3
        case json
            set -f output "$input.to_json"
            set -a libs json
        case plist
            set lang xml
            set -f output "$input.to_plist"
            set -a libs plist
        case toml
            set -f output "TomlRB.dump($input)"
            set -a libs toml-rb
        case yml yaml
            set lang yaml
            set -f output "$input.to_yaml"
            set -a libs yaml
        case '*'
            echo >&2 "don't know how to make a “$_flag_out” file!"
            return 1
    end

    if isatty stdout; and command -sq bat
        eval "function _at; cat | bat --style=plain --language=$lang; end"
    else
        function _at; cat; end
    end

    ruby -r$libs -e "puts $output" $argv[1] | _at
end
