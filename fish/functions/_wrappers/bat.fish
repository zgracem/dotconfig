in-path bat; or in-path batcat; or exit

function bat --description 'A cat clone with wings'
    set -f cmd bat
    set -f argv_
    if is-cygwin
        for arg in $argv
            switch "$arg"
                case cache "-*"
                    set -a argv_ $arg
                case "*"
                    set -a argv_ (cygpath --windows $arg)
            end
        end
    else
        set -f argv_ $argv
    end

    if not in-path bat; and in-path batcat
        set -f cmd batcat
    else
        set -f cmd cat
    end

    command $cmd $argv_
end
