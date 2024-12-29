function wtf -d "Display information about commands"
    set -q argv[1]; or return 1
    set -f all_abbr (abbr --list)

    for subject in $argv
        set -l types (type -at $subject 2>/dev/null)
        if test (count $types) -eq 0
            echo >&2 "not found: $subject"
            return 1
        end

        if contains -- $subject $all_abbr
            set --prepend types abbreviation
        end
        for type in $types
            switch $type
                case function
                    functions $subject
                case builtin
                    set_color --underline --italic $fish_color_keyword
                    echo -ns $subject
                    set_color normal
                    echo " is a builtin"
                case file
                    set -l paths (type -aP $subject)
                    if command -q eza
                        eza --long --sort none $paths
                    else
                        ls -lh $paths
                    end
                case abbreviation
                    set_color --underline --italic brcyan
                    echo -n $subject
                    set_color normal
                    echo " is an abbreviation"
                    abbr -s | string match -er -- "-- $subject\b" | fish_indent --ansi
            end
        end
    end
end
