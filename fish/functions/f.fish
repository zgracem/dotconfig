function f --description 'Open a Finder/Explorer window for $PWD/$1' -a target
    set -q target[1]; or set target (pwd)

    if is-cygwin
        explorer (cygpath --windows $target)
    else
        echo >&2 "not available on this system"
        return 1
    end
end
