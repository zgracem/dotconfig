function reveal --description 'Reveal $PWD/$1 in Explorer' -a target
    set -q target[1]; or set target (pwd)

    if is-cygwin
        explorer /select, (cygpath --windows $target)
    else
        echo >&2 "not available on this system"
        return 1
    end
end
