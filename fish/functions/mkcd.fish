function mkcd --description 'Create a directory, then move into it' -a dir
    command mkdir -p $dir
    and cd $dir
end
