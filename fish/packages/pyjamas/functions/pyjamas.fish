function pyjamas --description "Convert configuration files between formats"
    argparse -x{i,o},m -n pyjamas 'i/in=' 'o/out=' 'm/mode=' -- $argv
    or return

    if set -q _flag_mode
        string split ":" $_flag_mode | read -L _flag_in _flag_out
    end

    set -q _flag_in; and set -l ext_in $_flag_in

    if set -q argv[1]
        set -f file $argv[1]
        set -q ext_in; or set ext_in (path extension $argv[1] | string trim -c.)
    else if not isatty stdin
        if not set -q _flag_in
            echo >&2 "unknown file type! (specify with --in or --mode)"
            return 1
        end
    else
        echo >&2 "nothing to convert!"
        return 1
    end

    set -l libs date

    switch "$ext_in"
        case cson
            set -f input "JSON.load(Open3.capture2('cson2json', stdin_data: ARGF.read).first)"
            set -a libs json open3
        case json
            set -f input "JSON.load(ARGF)"
            set -a libs json
        case plist
            if set -q file; and string match -q "bplist" (head -c6 $file)
                set -f argv[1] (mktemp -t tbcopy.XXXXXX)
                plutil -convert xml1 -o $argv[1] $file; or exit
            end
            set -f input "Plist.parse_xml(ARGF)"
            set -a libs plist
        case toml
            set -f input "TomlRB.parse(ARGF.read)"
            set -a libs toml-rb
        case yml yaml
            set -f input "YAML.unsafe_load(ARGF.read)"
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
        eval "function _pager; bat --style=plain --language=$lang; end"
    else if isatty stdout; and command -sq less
        function _pager; less; end
    else
        function _pager; cat; end
    end

    ruby -r$libs -e "puts $output" $argv[1] | _pager
end
