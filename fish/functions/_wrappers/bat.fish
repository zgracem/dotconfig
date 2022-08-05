if in-path bat
    function bat --description 'A cat clone with wings'
        set -l args
        string match -q "$argv[1]" cache; or set -p argv --italic-text=always
        for arg in $argv
            switch "$arg"
                case cache "-*"
                    set -a args $arg
                case "*"
                    if is-cygwin
                        set -a args (cygpath --windows $arg)
                    else
                        set -a args $arg
                    end
            end
        end

        command bat $args
    end
end
