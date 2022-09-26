function fd
    set -p argv --hidden
    set -p argv --no-ignore-parent
    set -p argv --no-ignore-vcs # use .ignore, but not .gitignore

    command fd $argv
end
