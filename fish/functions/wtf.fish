function wtf -d "Display information about commands"
    set -q argv[1]; or return 1

    for subject in $argv
        for type in (type -at $subject 2>/dev/null)
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
                    if in-path eza
                        eza --long --sort none $paths
                    else
                        ls -lh $paths
                    end
            end
        end; and return

        if contains -- $subject (abbr --list)
            set_color --underline --italic brcyan
            echo -ns $subject
            set_color normal
            echo " is an abbreviation"
            abbr -s | string match -e -- "-- $subject" | command bat -pp -lfish
            return
        end

        echo >&2 "not found: $subject"
        return 1
    end
end
