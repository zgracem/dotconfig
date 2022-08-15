is-cygwin; or exit
in-path bat; or exit

function bat --description 'A cat clone with wings'
    set -l args
    for arg in $argv
        switch "$arg"
            case cache "-*"
                set -a args $arg
            case "*"
                set -a args (cygpath --windows $arg)
        end
    end

    command bat $args
end
