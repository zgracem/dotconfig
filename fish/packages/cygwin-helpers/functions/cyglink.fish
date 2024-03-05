function cyglink -d "Create a directory junction"
    # Inverts the syntax of Windows MKLINK for consistency with e.g. ln(1)
    set -l target $argv[1]
    set -l link $argv[2]
    if not set -q argv[1]
        echo >&2 (status function) "<target> <link>"
        return 1
    end

    if not path is -d $target
        echo >&2 "not a directory: $target"
        return 1
    end

    set -l cyg_target (cygpath --absolute --windows $target)
    set -l cyg_link (cygpath --absolute --windows $link)

    cmd /C mklink /J $cyg_link $cyg_target
end
