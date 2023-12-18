function reveal --description 'Reveal $1 in Finder/Explorer' -a target
    set -q target[1]; or set target (pwd)

    if is-cygwin
        explorer /select, (cygpath --windows $target)
    else
        echo >&2 "not available on this system"
        return 1
    end
end
