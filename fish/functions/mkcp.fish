function mkcp --description 'Create a directory, then copy files into it'
    command mkdir -p $argv[-1]
    and cp $argv
end
