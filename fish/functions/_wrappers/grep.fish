# Overrides $__fish_data_dir/functions/grep.fish
function grep --description 'Print lines that match patterns'
    # Use extended regex syntax
    set -l params -E

    # Don't warn about unreadable or missing files
    set -a params -s

    # Ignore binary files, directories, and devices
    set -a params -I -d skip -D skip

    # display results in colour if supported
    set -a params --colour=auto

    # skip version control directories
    set -a params --exclude-dir=.git --exclude-dir=.svn

    command grep $params $argv
end
