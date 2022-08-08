function pyjamas --description "Convert configuration files between formats"
    argparse -x{i,o},m 'i/in=' 'o/out=' 'm/mode=' -- $argv
    or return

    if set -q _flag_mode
        string split ":" $_flag_mode | read -L _flag_in _flag_out
    end

    set -l src
    set -q _flag_in; and set -l ext_in $_flag_in

    if set -q argv[1]
        set src "Pathname.new(ARGV[0])"
        set -q ext_in; or set ext_in (path extension $argv[1] | string trim -c.)
    else if not isatty stdin
        set src ARGF
        if not set -q _flag_in
            echo >&2 "unknown file type! (specify with --in or --mode)"
            return 1
        end
    else
        echo >&2 "nothing to convert!"
        return 1
    end

    set -l input
    set -l libs date pathname

    switch "$ext_in"
        case json
            set input "JSON.load($src)"
            set -a libs json
        case plist
            set input "Plist.parse_xml($src)"
            set -a libs plist
        case toml
            set input "TomlRB.parse($src.read)"
            set -a libs toml-rb
        case yml yaml
            set input "YAML.safe_load($src.read, permitted_classes: [Date, Symbol], aliases: true)"
            set -a libs yaml
        case '*'
            echo >&2 "don't know how to read a “$ext_in” file!"
            return 1
    end

    set -l output
    set -l lang $_flag_out

    switch "$_flag_out"
        case json
            set output "$input.to_json"
            set -a libs json
        case plist
            set lang xml
            set output "$input.to_plist"
            set -a libs plist
        case toml
            set output "TomlRB.dump($input)"
            set -a libs toml-rb
        case yml yaml
            set lang yaml
            set output "$input.to_yaml"
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
