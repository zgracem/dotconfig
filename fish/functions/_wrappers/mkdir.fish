function mkdir --description 'Make directories'
    set -p argv -p # only create dirs if they don't exist
    set -p argv -v # verbose
    command mkdir $argv
end
