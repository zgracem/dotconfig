function autocomp -a cmd manpath
    if not set -q cmd[1]; or not set -q manpath[1]
        echo >&2 "Usage: autocomp COMMAND MAN_PATH"
        return 1
    end

    set -f compfile $PWD/$cmd.fish

    if not path is -d $manpath
        echo >&2 "MAN_PATH not found: $manpath"
        return 1
    else if path is -f $compfile
        echo >&2 "file exists: $compfile"
        return 1
    end

    set -f manfiles $manpath/man*/$cmd.*
    if not set -q manfiles[1]
        echo >&2 "man page not found: $manpath/man*/$cmd.*"
        return 1
    end

    set -fx MANPATH .
    fish_update_completions --directory=$PWD --manpath --progress $manfiles
    or return

    if path is -f $compfile
        bat -pp $compfile
    else
        echo >&2 "completion file not found: $compfile"
        return 1
    end
end
