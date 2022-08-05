# Overrides $__fish_data_dir/functions/grep.fish
function grep --description 'Print lines that match patterns'
    # Use extended regex syntax
    set -p argv -E

    # Don't warn about unreadable or missing files
    set -p argv -s

    # Ignore binary files, directories, and devices
    set -p argv -I -d skip -D skip

    # display results in colour if supported
    set -p argv --colour=auto

    # skip version control directories
    set -p argv --exclude-dir=.git --exclude-dir=.svn

    command grep $argv
end
