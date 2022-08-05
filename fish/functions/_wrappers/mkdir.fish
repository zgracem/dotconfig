function mkdir --description 'Make directories'
    set -p argv -p
    set -p argv -v
    command mkdir $argv
end
