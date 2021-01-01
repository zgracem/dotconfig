# Overrides $__fish_data_dir/functions/grep.fish
function grep --description 'Print lines that match patterns'
    set params -EsI -d skip -D skip
    #           │││  │       └───── silently skip devices
    #           │││  └───────────── silently skip directories
    #           ││└──────────────── ignore binary files
    #           │└───────────────── no errors about missing/unreadable files
    #           └────────────────── use ERE syntax

    # display results in colour if supported
    set params $params --colour=auto

    # skip version control directories
    set params $params --exclude-dir=.git --exclude-dir=.svn

    command grep $params $argv
end
