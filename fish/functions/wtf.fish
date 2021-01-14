function wtf -d "Display information about commands"
    test -n "$argv"; or return 1

    for subject in $argv
        for type in (type -at $subject)
            switch $type
                case function
                    set -l srcfile (functions -D $subject)
                    if test "$srcfile" != "stdin"
                        exa -l $srcfile
                    end
                    functions $subject
                case builtin
                    echo -ns (set_color --bold --italic brcyan) $subject
                    echo (set_color normal) "is a builtin"
                case file
                    exa -1 (type -aP $subject)
            end
        end
    end
end
