function wtf -d "Display information about commands"
    set -q argv[1]; or return 1

    for subject in $argv
        set -l types (type -at $subject 2>/dev/null)
        contains -- $subject (abbr --list); and set -p types abbreviation
        contains -- $subject (set --names); and set -p types variable

        if test (count $types) -eq 0
            echo >&2 "not found: $subject"
            return 1
        end

        for type in $types
            switch $type
                case function
                    functions $subject
                case builtin
                    echo -ns (set_color -iu brmagenta) $subject (set_color normal)
                    echo " is a builtin"
                case file
                    echo -ns (set_color -iu brblue) $subject (set_color normal)
                    echo " is a file"
                    set -l paths (type -aP $subject)
                    if command -q eza
                        eza --long --sort none $paths
                    else
                        ls -lh $paths
                    end
                case abbreviation
                    echo -ns (set_color -iu brcyan) $subject (set_color normal)
                    echo " is an abbreviation"
                    abbr --show | string match -er -- "-- $subject\b" | fish_indent --ansi
                case variable
                    echo -ns (set_color -i bryellow) $subject (set_color normal)
                    echo " is a variable"
                    set --show $subject
            end
        end
    end
end
