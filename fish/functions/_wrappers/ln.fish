function ln --description 'Make links between files'
    set -p argv -v # verbose
    command ln $argv
end
