function mkcd --description 'Create a directory, then move into it' -a dir
    mkdir -pv $dir
    and cd $dir
end
