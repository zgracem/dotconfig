command -q bat; or return

function bat --description 'A cat clone with wings'
    set -f argv_
    for arg in $argv
        switch "$arg"
            case cache "-*"
                set -a argv_ $arg
            case "*"
                set -a argv_ (cygpath --windows $arg)
        end
    end
    set -f argv $argv_

    set -f cmd (path filter -x $PATH/bat $PATH/batcat $PATH/cat)
    if set -q cmd[1]
        $cmd[1] $argv
    else
        return 127
    end
end
