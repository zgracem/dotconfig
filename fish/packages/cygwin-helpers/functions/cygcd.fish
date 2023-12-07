function cygcd -d "Change to a directory with Windows/DOS syntax"
    # Usage: cygcd 'C:\Users'
    set -l path (cygpath -au "$argv")
    or return

    cd "$path"
end
