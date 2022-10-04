function fd
    set -p argv --hidden
    set -p argv --no-ignore-parent # disregard any ../.gitignore
    set -p argv --no-ignore-vcs # use .ignore, but not .gitignore
    set -p argv --follow # follow symlinks

    command fd $argv
end
