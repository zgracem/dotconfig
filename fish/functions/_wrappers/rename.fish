function rename --description 'Rename multiple files'
    set -p argv --verbose
    command rename $argv
end
