function wtf -d "Display information about commands"
    set -q argv[1]; or return 1

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
                    set_color --bold --italic brcyan
                    echo -ns $subject
                    set_color normal
                    echo " is a builtin"
                case file
                    exa -l -s none -r (type -aP $subject)
            end
        end
    end
end
