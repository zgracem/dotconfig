function wtf -d "Display information about commands"
    set -q argv[1]; or return 1

    for subject in $argv
        for type in (type -at $subject 2>/dev/null)
            switch $type
                case function
                    set -l srcfile (functions -D $subject)
                    if test $srcfile != "stdin"
                        if command -sq exa
                            exa -l $srcfile
                        else
                            ll $srcfile
                        end
                    end
                    functions $subject
                case builtin
                    set_color --bold --italic brcyan
                    echo -ns $subject
                    set_color normal
                    echo " is a builtin"
                case file
                    if command -sq exa
                        exa --long --sort none (type -aP $subject)
                    else
                        ll (type -aP $subject)
                    end
            end
        end; and return

        set -l abbrs (abbr --list)
        if contains -- $subject $abbrs
            set_color --bold --italic brmagenta
            echo -ns $subject
            set_color normal
            echo -n " is an abbreviation for "
            set_color brwhite
            abbr -s | string replace -fr "abbr -a -g -- $subject '?(.+?)'?\$" '$1'
            set_color normal

            return
        end

        echo >&2 "not found: $subject"
        return 1
    end
end
